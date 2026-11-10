$ErrorActionPreference = "Stop"

$rulesPath = "docs/game-design/game-rules-v1.0.md"
$modelPath = "docs/cards/card-model-v1.0.md"
$effectsPath = "docs/cards/card-effects-v1.0.md"
$catalogPath = "docs/cards/card-catalog-v1.0.md"
$reportPath = "docs/cards/card-audit-report.md"

$files = @($rulesPath, $modelPath, $effectsPath, $catalogPath)
foreach ($file in $files) {
    if (-not (Test-Path $file)) {
        throw "Arquivo obrigatório não encontrado: $file"
    }
}

$rules = Get-Content $rulesPath -Raw
$model = Get-Content $modelPath -Raw
$effects = Get-Content $effectsPath -Raw
$catalog = Get-Content $catalogPath -Raw

$issues = New-Object System.Collections.Generic.List[string]
$warnings = New-Object System.Collections.Generic.List[string]
$passed = New-Object System.Collections.Generic.List[string]

function Add-Check {
    param([string]$Condition, [string]$Message)
    if ($Condition -eq "OK") {
        $script:passed.Add($Message)
    } elseif ($Condition -eq "ERROR") {
        $script:issues.Add($Message)
    } else {
        $script:warnings.Add($Message)
    }
}

# 1. Extrair cartas pelo cabeçalho padronizado
$matches = [regex]::Matches(
    $catalog,
    '(?m)^###\s+((?:ATK|DEF|ESC|CTR|SUB|STR)-\d{3})\s+-\s+(.+?)\s*$'
)

$cards = @()
for ($i = 0; $i -lt $matches.Count; $i++) {
    $start = $matches[$i].Index
    $end = if ($i -lt $matches.Count - 1) {
        $matches[$i + 1].Index
    } else {
        $catalog.Length
    }

    $body = $catalog.Substring($start, $end - $start)
    $cards += [PSCustomObject]@{
        Id = $matches[$i].Groups[1].Value
        Name = $matches[$i].Groups[2].Value.Trim()
        Body = $body
    }
}

Add-Check $(if ($cards.Count -eq 40) { "OK" } else { "ERROR" }) "Quantidade de cartas: $($cards.Count) (esperado: 40)."

# 2. IDs únicos
$duplicates = @($cards | Group-Object Id | Where-Object Count -gt 1)
Add-Check $(if ($duplicates.Count -eq 0) { "OK" } else { "ERROR" }) "IDs duplicados: $($duplicates.Count)."
foreach ($duplicate in $duplicates) {
    $issues.Add("ID duplicado: $($duplicate.Name).")
}

# 3. Distribuição por categoria
$expected = @{
    ATK = 10
    DEF = 10
    ESC = 5
    CTR = 5
    SUB = 6
    STR = 4
}

$categoryLines = @()
foreach ($category in $expected.Keys | Sort-Object) {
    $actual = @($cards | Where-Object { $_.Id -like "$category-*" }).Count
    $status = if ($actual -eq $expected[$category]) { "OK" } else { "ERROR" }
    Add-Check $status "$category`: $actual cartas (esperado: $($expected[$category]))."
    $categoryLines += "| $category | $actual | $($expected[$category]) |"
}

# 4. Campos e conteúdo mínimo por carta
foreach ($card in $cards) {
    $body = $card.Body
    if ($body -notmatch '(?i)raridade') {
        $warnings.Add("$($card.Id): campo de raridade não identificado.")
    }
    if ($body -notmatch '(?i)energia|custo') {
        $warnings.Add("$($card.Id): custo de energia não identificado.")
    }
    if ($body -notmatch '(?i)efeito|effect') {
        $warnings.Add("$($card.Id): descrição de efeito não identificada.")
    }
}

# 5. Distribuição de raridade declarada
$rarities = @("COMMON", "RARE", "EPIC", "LEGENDARY")
$rarityCounts = @{ COMMON = 0; RARE = 0; EPIC = 0; LEGENDARY = 0 }
foreach ($card in $cards) {
    $rarityMatches = [regex]::Matches($card.Body, '(?im)^[ \t]*\|[ \t]*Raridade[ \t]*\|[ \t]*(COMMON|RARE|EPIC|LEGENDARY)[ \t]*\|')
    if ($rarityMatches.Count -ne 1) {
        $issues.Add("$($card.Id): esperada exatamente uma propriedade Raridade válida; encontradas $($rarityMatches.Count).")
        continue
    }
    $rarity = $rarityMatches[0].Groups[1].Value.ToUpperInvariant()
    $rarityCounts[$rarity]++
}
$rarityLines = @()
foreach ($rarity in $rarities) {
    $rarityLines += "| $rarity | $($rarityCounts[$rarity]) |"
}
Add-Check "OK" "Raridade declarada: propriedade individual validada nas cartas."

# 6. Regras de energia conhecidas
$knownChecks = @(
    @{
        Id = "ESC-005"
        Pattern = '(?is)###\s+ESC-005.*?(?=###\s+(?:ATK|DEF|ESC|CTR|SUB|STR)-|\z)'
        Expected = '(?i)(?:custo.{0,30}3|3.{0,20}energia)'
        Message = "ESC-005: verificar custo de 3 de energia para escape da lateral."
    },
    @{
        Id = "STR-001"
        Pattern = '(?is)###\s+STR-001.*?(?=###\s+(?:ATK|DEF|ESC|CTR|SUB|STR)-|\z)'
        Expected = '(?i)(?:recupera.{0,30}2|2.{0,20}energia)'
        Message = "STR-001: verificar recuperação básica de 2 de energia."
    }
)

foreach ($check in $knownChecks) {
    $match = [regex]::Match($catalog, $check.Pattern)
    if (-not $match.Success) {
        $warnings.Add("$($check.Id): não foi possível localizar o bloco da carta.")
    } elseif ($match.Value -match $check.Expected) {
        $passed.Add($check.Message)
    } else {
        $issues.Add($check.Message)
    }
}

# 7. Verificar se os tipos de efeito do catálogo aparecem no modelo
$effectTypes = @(
    "POSITION_TRANSITION",
    "BLOCK",
    "REDUCE_MODIFIER",
    "PREVENT_PROGRESSION",
    "ENERGY_RECOVERY",
    "TEMPORARY_MODIFIER"
)

foreach ($type in $effectTypes) {
    if ($effects -match [regex]::Escape($type)) {
        $passed.Add("Tipo de efeito documentado: $type.")
    } else {
        $warnings.Add("Tipo de efeito não localizado no documento de efeitos: $type.")
    }
}

# 8. Conferir parâmetros fundamentais nas regras
$ruleChecks = @(
    @{ Pattern = '(?i)40 cartas'; Name = "Deck de 40 cartas" },
    @{ Pattern = '(?i)10 rodadas'; Name = "Limite de 10 rodadas" },
    @{ Pattern = '(?i)recupera.{0,30}2'; Name = "Recuperação automática de 2 de energia" },
    @{ Pattern = '(?i)empate.{0,50}defesa vence|defesa vence.{0,30}empate'; Name = "Defesa vence em caso de empate" }
)

foreach ($check in $ruleChecks) {
    if ($rules -match $check.Pattern) {
        $passed.Add("Regra localizada: $($check.Name).")
    } else {
        $warnings.Add("Regra não localizada automaticamente: $($check.Name).")
    }
}

# 9. Gerar relatório
$now = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
$lines = @(
    "# ROLL TCG — Relatório de Auditoria do Catálogo",
    "",
    "**Data da execução:** $now",
    "**Escopo:** Feature 04 — Card System & Card Catalog",
    "**Modo:** Somente leitura dos documentos de origem",
    "",
    "## 1. Resumo",
    "",
    "| Indicador | Quantidade |",
    "|---|---:|",
    "| Cartas identificadas | $($cards.Count) |",
    "| Verificações aprovadas | $($passed.Count) |",
    "| Erros | $($issues.Count) |",
    "| Alertas | $($warnings.Count) |",
    "",
    "## 2. Distribuição por categoria",
    "",
    "| Categoria | Encontradas | Esperadas |",
    "|---|---:|---:|"
)
$lines += $categoryLines
$lines += @("", "## 3. Verificações aprovadas", "")
if ($passed.Count -eq 0) { $lines += "- Nenhuma." }
foreach ($item in $passed) { $lines += "- [x] $item" }

$lines += @("", "## 4. Erros", "")
if ($issues.Count -eq 0) { $lines += "- Nenhum erro identificado pelas verificações automatizadas." }
foreach ($item in $issues) { $lines += "- [ ] $item" }

$lines += @("", "## 5. Alertas e pontos para revisão", "")
if ($warnings.Count -eq 0) { $lines += "- Nenhum alerta." }
foreach ($item in $warnings) { $lines += "- [ ] $item" }

$lines += @(
    "",
    "## 6. Distribuição textual de raridade",
    "",
    "| Raridade | Cartas em cujo bloco foi localizada |",
    "|---|---:|"
)
$lines += $rarityLines
$lines += @(
    "",
    "A contagem de raridade é indicativa: uma carta pode conter menções adicionais à raridade no texto.",
    "",
    "## 7. Limitações",
    "",
    "- A auditoria identifica padrões textuais e estruturais; não executa o motor de jogo.",
    "- Compatibilidade posicional e coerência estratégica exigem revisão semântica.",
    "- Valores de balanceamento provisórios não são tratados automaticamente como erros.",
    "- A ausência de um padrão textual não prova necessariamente ausência da regra.",
    "",
    "## 8. Documentos analisados",
    "",
    "- ``$rulesPath``",
    "- ``$modelPath``",
    "- ``$effectsPath``",
    "- ``$catalogPath``",
    ""
)

$lines | Set-Content -Path $reportPath -Encoding UTF8

Write-Host ""
Write-Host "AUDITORIA CONCLUIDA" -ForegroundColor Cyan
Write-Host "Cartas identificadas: $($cards.Count)"
Write-Host "Aprovacoes: $($passed.Count)"
Write-Host "Erros: $($issues.Count)"
Write-Host "Alertas: $($warnings.Count)"
Write-Host "Relatorio: $reportPath"
