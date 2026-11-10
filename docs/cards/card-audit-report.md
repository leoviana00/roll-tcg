# ROLL TCG — Relatório de Auditoria do Catálogo

**Data da execução:** 2026-11-10 19:54:33
**Escopo:** Feature 04 — Card System & Card Catalog
**Modo:** Somente leitura dos documentos de origem

## 1. Resumo

| Indicador | Quantidade |
|---|---:|
| Cartas identificadas | 40 |
| Verificações aprovadas | 21 |
| Erros | 0 |
| Alertas | 0 |

## 2. Distribuição por categoria

| Categoria | Encontradas | Esperadas |
|---|---:|---:|
| ATK | 10 | 10 |
| CTR | 5 | 5 |
| DEF | 10 | 10 |
| ESC | 5 | 5 |
| STR | 4 | 4 |
| SUB | 6 | 6 |

## 3. Verificações aprovadas

- [x] Quantidade de cartas: 40 (esperado: 40).
- [x] IDs duplicados: 0.
- [x] ATK: 10 cartas (esperado: 10).
- [x] CTR: 5 cartas (esperado: 5).
- [x] DEF: 10 cartas (esperado: 10).
- [x] ESC: 5 cartas (esperado: 5).
- [x] STR: 4 cartas (esperado: 4).
- [x] SUB: 6 cartas (esperado: 6).
- [x] Raridade declarada: propriedade individual validada nas cartas.
- [x] ESC-005: verificar custo de 3 de energia para escape da lateral.
- [x] STR-001: verificar recuperação básica de 2 de energia.
- [x] Tipo de efeito documentado: POSITION_TRANSITION.
- [x] Tipo de efeito documentado: BLOCK.
- [x] Tipo de efeito documentado: REDUCE_MODIFIER.
- [x] Tipo de efeito documentado: PREVENT_PROGRESSION.
- [x] Tipo de efeito documentado: ENERGY_RECOVERY.
- [x] Tipo de efeito documentado: TEMPORARY_MODIFIER.
- [x] Regra localizada: Deck de 40 cartas.
- [x] Regra localizada: Limite de 10 rodadas.
- [x] Regra localizada: Recuperação automática de 2 de energia.
- [x] Regra localizada: Defesa vence em caso de empate.

## 4. Erros

- Nenhum erro identificado pelas verificações automatizadas.

## 5. Alertas e pontos para revisão

- Nenhum alerta.

## 6. Distribuição textual de raridade

| Raridade | Cartas em cujo bloco foi localizada |
|---|---:|
| COMMON | 19 |
| RARE | 16 |
| EPIC | 5 |
| LEGENDARY | 0 |

A contagem de raridade é indicativa: uma carta pode conter menções adicionais à raridade no texto.

## 7. Limitações

- A auditoria identifica padrões textuais e estruturais; não executa o motor de jogo.
- Compatibilidade posicional e coerência estratégica exigem revisão semântica.
- Valores de balanceamento provisórios não são tratados automaticamente como erros.
- A ausência de um padrão textual não prova necessariamente ausência da regra.

## 8. Documentos analisados

- `docs/game-design/game-rules-v1.0.md`
- `docs/cards/card-model-v1.0.md`
- `docs/cards/card-effects-v1.0.md`
- `docs/cards/card-catalog-v1.0.md`
