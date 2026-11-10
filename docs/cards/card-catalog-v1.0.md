# Card Catalog - v1.0

**Projeto:** ROLL TCG
\
**Documento:** Card Catalog
\
**Versão:** 1.0
\
**Status:** Draft
**Feature:** 04 - Card System & Card Catalog

---

## 1. Objetivo

Definir o catálogo inicial de 40 cartas do ROLL TCG, especificando suas propriedades, requisitos, custos de energia, compatibilidade posicional e efeitos.

O catálogo deverá respeitar os modelos definidos em:

- `card-model-v1.0.md`
- `card-effects-v1.0.md`
- `game-rules-v1.0.md`

Os valores numéricos deste documento são preliminares e deverão ser validados por meio de playtests.

## 2. Composição do catálogo

| Categoria | Identificador | Quantidade |
|---|---|---:|
| Ataque | ATTACK | 10 |
| Defesa | DEFENSE | 10 |
| Fuga | ESCAPE | 5 |
| Contra-ataque | COUNTERATTACK | 5 |
| Finalização | SUBMISSION | 6 |
| Estratégia | STRATEGY | 4 |
| **Total** | | **40** |

## 3. Padrão de especificação

Cada carta deverá possuir:

- Identificador único.
- Nome.
- Categoria.
- Raridade.
- Custo de energia.
- Atributo aplicável.
- Requisito mínimo.
- Posição de origem.
- Posição de destino, quando aplicável.
- Efeito principal.
- Bônus de resultado, quando aplicável.
- Condição de sucesso.
- Condição de falha.
- Pontuação, quando aplicável.
- Reação compatível, quando aplicável.

### 3.1. Interpretação das posições

As posições representam o estado do combate entre os dois atletas, e não posições independentes para cada jogador.

- **Origem:** estado posicional necessário para executar a carta.
- **Destino:** estado posicional resultante de uma transição bem-sucedida.
- **Alternativas:** quando uma carta possuir mais de uma origem ou destino, somente as opções declaradas poderão ser utilizadas.
- **Pontuação:** somente será atribuída após a confirmação da estabilização, conforme as regras do jogo.

### 3.2. Interpretação dos efeitos defensivos

Os efeitos defensivos possuem responsabilidades distintas:

- **BLOCK:** neutraliza uma técnica ofensiva específica e compatível.
- **REDUCE_MODIFIER:** reduz o resultado calculado de uma ação ofensiva.
- **PREVENT_PROGRESSION:** impede uma progressão posicional específica.
- **SUBMISSION_DEFENSE:** impede o avanço da etapa atual de uma finalização específica.

Uma carta defensiva deverá identificar a ação ou técnica contra a qual pode ser utilizada. Não será permitido utilizar um efeito defensivo genérico contra qualquer ação ofensiva.

Uma defesa bem-sucedida não provoca automaticamente uma mudança de posição. A transição dependerá de um efeito específico que autorize essa alteração.

### 3.3. Critérios de compatibilidade

A compatibilidade entre cartas deverá considerar:

- A posição atual do combate.
- A posição de origem declarada pela carta.
- O tipo de ação ofensiva.
- A técnica ou progressão que poderá ser neutralizada.
- Os requisitos de atributo e energia.
- As condições de ativação da reação.

Uma carta incompatível não poderá ser utilizada e não deverá consumir energia nem ser removida da mão.

### 3.4. Regras gerais das cartas de fuga

Uma fuga bem-sucedida deverá:

- Executar a transição posicional declarada na carta.
- Reduzir em 2 pontos o controle situacional do adversário, respeitando o limite mínimo de 0.
- Cancelar uma finalização ativa contra o atleta que conseguiu escapar.
- Respeitar a janela de reação e os requisitos da ação.

A redução do controle situacional é uma consequência da regra de fuga, não um bônus de resultado da carta.

### 3.5. Regras gerais das cartas de contra-ataque

As cartas de contra-ataque deverão:

- Exigir uma condição de ativação válida, normalmente uma defesa bem-sucedida.
- Ser compatíveis com a posição e a ação ofensiva que originou a reação.
- Resolver defesa e contra-ataque como uma única reação composta.
- Não abrir uma segunda janela de reação.
- Não executar o contra-ataque quando a defesa inicial falhar.

### 3.6. Regras gerais das cartas de finalização

As finalizações possuem três etapas:

1. Preparação.
2. Ataque.
3. Conclusão.

Cada etapa representa uma ação e deverá respeitar o custo de energia e a janela de reação definidos pelas regras da carta e do jogo.

A progressão da finalização deverá permanecer vinculada à técnica iniciada. Não será permitido trocar de técnica durante uma sequência ativa sem reiniciar sua preparação.

Uma defesa bem-sucedida impede o avanço da etapa correspondente, mas não cancela automaticamente as etapas anteriores. Uma fuga bem-sucedida cancela a sequência ativa.

A conclusão bem-sucedida encerra imediatamente a partida por finalização.

### 3.7. Regras gerais das cartas de estratégia

As cartas de estratégia modificam temporariamente atributos, resultados ou recursos do atleta.

Seus efeitos deverão respeitar:

- A duração declarada.
- O limite máximo de energia.
- O limite de controle situacional.
- A validade da ação à qual o modificador será aplicado.
- A expiração dos efeitos temporários.

## 4. Cartas de ataque - ATTACK

As cartas de ataque representam ações ofensivas destinadas a conquistar posições, realizar transições e obter pontuação.

### ATK-001 - Queda de Duas Pernas

| Propriedade | Valor |
|---|---|
| Categoria | ATTACK |
| Raridade | COMMON |
| Custo | 3 |
| Atributo | STRENGTH |
| Requisito mínimo | 3 |
| Origem | STANDING |
| Destino | SIDE_CONTROL |

**Efeito:** POSITION_TRANSITION.

**Sucesso:** realiza a queda e estabelece controle em SIDE_CONTROL, respeitando a resolução da ação.

**Falha:** os atletas permanecem em STANDING.

**Pontuação:** 2 pontos após estabilização.

**Reação:** defesa compatível com queda, incluindo defesa específica de queda.

### ATK-002 - Queda de Uma Perna

| Propriedade | Valor |
|---|---|
| Categoria | ATTACK |
| Raridade | COMMON |
| Custo | 2 |
| Atributo | TECHNIQUE |
| Requisito mínimo | 3 |
| Origem | STANDING |
| Destino | SIDE_CONTROL |

**Efeito:** POSITION_TRANSITION.

**Sucesso:** realiza a queda e estabelece controle em SIDE_CONTROL.

**Falha:** os atletas permanecem em STANDING.

**Pontuação:** 2 pontos após estabilização.

**Reação:** defesa compatível com queda.

### ATK-003 - Raspagem de Guarda

| Propriedade | Valor |
|---|---|
| Categoria | ATTACK |
| Raridade | COMMON |
| Custo | 2 |
| Atributo | TECHNIQUE |
| Requisito mínimo | 3 |
| Origem | CLOSED_GUARD ou OPEN_GUARD |
| Destino | SIDE_CONTROL |

**Efeito:** POSITION_TRANSITION.

**Sucesso:** realiza a reversão e estabelece controle superior em SIDE_CONTROL.

**Falha:** os atletas permanecem nas posições anteriores.

**Pontuação:** 2 pontos após estabilização.

**Reação:** defesa compatível com raspagem.

**Observação:** a compatibilidade do destino SIDE_CONTROL deverá ser validada nas regras de transição posicional e nos playtests.

### ATK-004 - Passagem Toreando

| Propriedade | Valor |
|---|---|
| Categoria | ATTACK |
| Raridade | COMMON |
| Custo | 3 |
| Atributo | TECHNIQUE |
| Requisito mínimo | 3 |
| Origem | OPEN_GUARD |
| Destino | SIDE_CONTROL |

**Efeito:** POSITION_TRANSITION.

**Sucesso:** supera a guarda adversária por meio de movimentação e controle das pernas, estabelecendo SIDE_CONTROL.

**Falha:** a guarda adversária permanece estabelecida.

**Pontuação:** 3 pontos após estabilização.

**Reação:** defesa específica de retenção de guarda.

### ATK-005 - Passagem Knee Cut

| Propriedade | Valor |
|---|---|
| Categoria | ATTACK |
| Raridade | RARE |
| Custo | 3 |
| Atributo | TECHNIQUE |
| Requisito mínimo | 4 |
| Origem | HALF_GUARD |
| Destino | SIDE_CONTROL |

**Efeito:** POSITION_TRANSITION.

**Sucesso:** executa a passagem técnica por meio do corte de joelho e estabelece SIDE_CONTROL.

**Falha:** os atletas permanecem na disputa posicional de HALF_GUARD.

**Pontuação:** 3 pontos após estabilização.

**Reação:** defesa compatível com passagem de meia-guarda.

### ATK-006 - Joelho na Barriga

| Propriedade | Valor |
|---|---|
| Categoria | ATTACK |
| Raridade | COMMON |
| Custo | 2 |
| Atributo | CONTROL |
| Requisito mínimo | 2 |
| Origem | SIDE_CONTROL |
| Destino | KNEE_ON_BELLY |

**Efeito:** POSITION_TRANSITION.

**Sucesso:** estabelece KNEE_ON_BELLY e mantém controle sobre o adversário.

**Falha:** mantém SIDE_CONTROL.

**Pontuação:** 2 pontos após estabilização.

**Reação:** defesa compatível com progressão posicional.

### ATK-007 - Conquista da Montada

| Propriedade | Valor |
|---|---|
| Categoria | ATTACK |
| Raridade | RARE |
| Custo | 3 |
| Atributo | CONTROL |
| Requisito mínimo | 3 |
| Origem | SIDE_CONTROL |
| Destino | MOUNT |

**Efeito:** POSITION_TRANSITION.

**Sucesso:** supera a defesa adversária e estabelece MOUNT.

**Falha:** mantém SIDE_CONTROL.

**Pontuação:** 4 pontos após estabilização.

**Reação:** defesa compatível com progressão para montada.

### ATK-008 - Tomada de Costas

| Propriedade | Valor |
|---|---|
| Categoria | ATTACK |
| Raridade | RARE |
| Custo | 3 |
| Atributo | TECHNIQUE |
| Requisito mínimo | 4 |
| Origem | MOUNT ou TURTLE |
| Destino | BACK_CONTROL |

**Efeito:** POSITION_TRANSITION.

**Sucesso:** executa a transição e estabelece BACK_CONTROL.

**Falha:** mantém a posição anterior.

**Pontuação:** 4 pontos após estabilização.

**Reação:** defesa compatível com tomada de costas.

### ATK-009 - Pressão na Meia-guarda

| Propriedade | Valor |
|---|---|
| Categoria | ATTACK |
| Raridade | RARE |
| Custo | 2 |
| Atributo | STRENGTH |
| Requisito mínimo | 3 |
| Origem | HALF_GUARD |
| Destino | SIDE_CONTROL |

**Efeito:** POSITION_TRANSITION.

**Sucesso:** utiliza pressão física e controle de base para superar a retenção da meia-guarda e estabelecer SIDE_CONTROL.

**Falha:** mantém HALF_GUARD.

**Pontuação:** 3 pontos após estabilização.

**Reação:** defesa compatível com progressão na meia-guarda.

### ATK-010 - Pressão de Passagem

| Propriedade | Valor |
|---|---|
| Categoria | ATTACK |
| Raridade | EPIC |
| Custo | 4 |
| Atributo | STRENGTH |
| Requisito mínimo | 4 |
| Origem | OPEN_GUARD ou HALF_GUARD |
| Destino | SIDE_CONTROL |
| Bônus de resultado | +1 |

**Efeito:** POSITION_TRANSITION.

**Sucesso:** executa a passagem utilizando pressão física superior. O bônus de +1 é aplicado ao resultado da ação, conforme a fórmula de combate.

**Falha:** não altera a posição.

**Pontuação:** 3 pontos após estabilização.

**Reação:** defesa compatível com passagem de guarda.

### 4.1. Distribuição de raridade - ATTACK

| Raridade | Quantidade |
|---|---:|
| COMMON | 5 |
| RARE | 4 |
| EPIC | 1 |
| LEGENDARY | 0 |
| **Total** | **10** |

## 5. Cartas de defesa - DEFENSE

As cartas de defesa representam ações destinadas a neutralizar ataques, reduzir a efetividade de ações ofensivas e preservar posições defensivas.

### DEF-001 - Reposição de Frames

| Propriedade | Valor |
|---|---|
| Categoria | DEFENSE |
| Raridade | COMMON |
| Custo | 1 |
| Atributo | CONTROL |
| Requisito mínimo | 2 |
| Origem | SIDE_CONTROL ou MOUNT |
| Destino | Mantém a posição atual |

**Efeito:** REDUCE_MODIFIER.

**Sucesso:** reduz em 1 o resultado da ação ofensiva compatível, representando a recuperação de estruturas defensivas e a criação de espaço.

**Falha:** a ação ofensiva mantém seu resultado original.

**Reação:** compatível com ações ofensivas de progressão posicional a partir de SIDE_CONTROL ou MOUNT.

### DEF-002 - Sprawl

| Propriedade | Valor |
|---|---|
| Categoria | DEFENSE |
| Raridade | COMMON |
| Custo | 2 |
| Atributo | STRENGTH |
| Requisito mínimo | 3 |
| Origem | STANDING |
| Destino | STANDING |

**Efeito:** BLOCK.

**Sucesso:** neutraliza uma tentativa de queda compatível, impedindo a transição posicional.

**Falha:** a queda adversária continua sendo resolvida normalmente.

**Reação:** compatível com ATK-001 e ATK-002.

### DEF-003 - Retenção de Guarda

| Propriedade | Valor |
|---|---|
| Categoria | DEFENSE |
| Raridade | COMMON |
| Custo | 2 |
| Atributo | TECHNIQUE |
| Requisito mínimo | 3 |
| Origem | OPEN_GUARD ou HALF_GUARD |
| Destino | Mantém a posição de origem |

**Efeito:** PREVENT_PROGRESSION.

**Sucesso:** impede a progressão da passagem de guarda adversária, preservando a posição defensiva.

**Falha:** a progressão ofensiva continua sendo resolvida normalmente.

**Reação:** compatível com ATK-004, ATK-005, ATK-009 e ATK-010, respeitando a posição de origem da carta ofensiva.

### DEF-004 - Quebra de Pegada

| Propriedade | Valor |
|---|---|
| Categoria | DEFENSE |
| Raridade | COMMON |
| Custo | 1 |
| Atributo | TECHNIQUE |
| Requisito mínimo | 2 |
| Origem | Posição compatível com a técnica adversária |
| Destino | Não aplicável |

**Efeito:** BLOCK.

**Sucesso:** neutraliza uma técnica específica que dependa de pegada estabelecida, desde que a carta ofensiva declare essa dependência e seja compatível com a posição atual.

**Falha:** a ação ofensiva continua sendo resolvida normalmente.

**Reação:** exclusivamente contra técnicas que declarem dependência de pegada.

**Observação:** nenhuma carta de ataque atualmente especificada declara essa dependência. A compatibilidade desta carta deverá ser validada quando o catálogo de ataques for ampliado.

### DEF-005 - Cotovelos Fechados

| Propriedade | Valor |
|---|---|
| Categoria | DEFENSE |
| Raridade | COMMON |
| Custo | 1 |
| Atributo | RESISTANCE |
| Requisito mínimo | 3 |
| Origem | Posição defensiva compatível |
| Destino | Mantém a posição atual |

**Efeito:** REDUCE_MODIFIER.

**Sucesso:** reduz em 1 o resultado de uma ação ofensiva compatível direcionada aos braços ou ao tronco.

**Falha:** a ação ofensiva mantém seu resultado original.

**Reação:** exclusivamente contra ataques cuja definição identifique os braços ou o tronco como região de aplicação.

**Observação:** as técnicas compatíveis deverão ser identificadas explicitamente no catálogo de cartas ofensivas. Não será permitido aplicar esta defesa indiscriminadamente.

### DEF-006 - Base Defensiva

| Propriedade | Valor |
|---|---|
| Categoria | DEFENSE |
| Raridade | RARE |
| Custo | 2 |
| Atributo | CONTROL |
| Requisito mínimo | 3 |
| Origem | Posição inferior compatível |
| Destino | Mantém a posição de origem |

**Efeito:** REDUCE_MODIFIER.

**Sucesso:** reduz em 2 o resultado de uma ação ofensiva adversária de progressão posicional.

**Falha:** a ação ofensiva mantém seu resultado original.

**Reação:** compatível com tentativas de progressão posicional a partir da posição defensiva atual.

**Observação:** a redução de 2 pontos é preliminar e deverá ser validada em playtests.

### DEF-007 - Defesa de Armbar

| Propriedade | Valor |
|---|---|
| Categoria | DEFENSE |
| Raridade | RARE |
| Custo | 2 |
| Atributo | STRENGTH |
| Requisito mínimo | 3 |
| Origem | Posição compatível com a ameaça de armbar |
| Destino | Mantém a posição, salvo efeito específico da ação |

**Efeito:** SUBMISSION_DEFENSE.

**Sucesso:** impede o avanço da etapa atual de uma tentativa de Armbar.

**Falha:** a progressão da finalização continua sendo resolvida normalmente.

**Reação:** exclusivamente contra a finalização SUB-001 - Armbar.

### DEF-008 - Defesa de Triângulo

| Propriedade | Valor |
|---|---|
| Categoria | DEFENSE |
| Raridade | RARE |
| Custo | 2 |
| Atributo | RESISTANCE |
| Requisito mínimo | 3 |
| Origem | CLOSED_GUARD |
| Destino | Mantém a posição, salvo efeito específico da ação |

**Efeito:** SUBMISSION_DEFENSE.

**Sucesso:** impede o avanço da etapa atual de uma tentativa de Triangle.

**Falha:** a progressão da finalização continua sendo resolvida normalmente.

**Reação:** exclusivamente contra a finalização SUB-002 - Triangle.

### DEF-009 - Defesa de Mata-leão

| Propriedade | Valor |
|---|---|
| Categoria | DEFENSE |
| Raridade | EPIC |
| Custo | 3 |
| Atributo | TECHNIQUE |
| Requisito mínimo | 4 |
| Origem | BACK_CONTROL |
| Destino | Mantém a posição, salvo efeito específico da ação |

**Efeito:** SUBMISSION_DEFENSE.

**Sucesso:** impede o avanço da etapa atual de uma tentativa de Mata-leão.

**Falha:** a progressão da finalização continua sendo resolvida normalmente.

**Reação:** exclusivamente contra a finalização SUB-004 - Mata-leão.

### DEF-010 - Recuperação de Estrutura

| Propriedade | Valor |
|---|---|
| Categoria | DEFENSE |
| Raridade | RARE |
| Custo | 2 |
| Atributo | CONTROL |
| Requisito mínimo | 3 |
| Origem | Posição inferior compatível |
| Destino | Mantém a posição atual |

**Efeito:** REDUCE_MODIFIER.

**Sucesso:** reduz em 1 o resultado de uma ação ofensiva adversária que tenha como objetivo estabelecer uma progressão posicional capaz de aumentar o controle situacional.

**Falha:** a ação ofensiva mantém seu resultado original.

**Reação:** compatível com ações de progressão posicional a partir da posição defensiva atual.

**Observação:** esta carta reduz o resultado da ação ofensiva. Ela não altera diretamente o valor de controle situacional do adversário.

### 5.1. Distribuição de raridade - DEFENSE

| Raridade | Quantidade |
|---|---:|
| COMMON | 5 |
| RARE | 4 |
| EPIC | 1 |
| LEGENDARY | 0 |
| **Total** | **10** |

## 6. Cartas de fuga - ESCAPE

As cartas de fuga representam ações destinadas a recuperar posições defensivas, escapar de posições de controle e interromper sequências de finalização.

### ESC-001 - Fuga de Quadril (Shrimp)

| Propriedade | Valor |
|---|---|
| Categoria | ESCAPE |
| Raridade | COMMON |
| Custo | 2 |
| Atributo | TECHNIQUE |
| Requisito mínimo | 3 |
| Origem | SIDE_CONTROL ou MOUNT |
| Destino | HALF_GUARD ou CLOSED_GUARD, conforme a origem |

**Efeito:** POSITION_TRANSITION.

**Sucesso:** utiliza a movimentação de quadril para recuperar espaço e estabelecer uma posição de guarda compatível com a posição de origem.

**Falha:** mantém a posição atual.

**Efeito adicional:** reduz em 2 o controle situacional do adversário e cancela uma finalização ativa, quando aplicável.

**Reação:** defesa compatível com tentativa de fuga posicional.

### ESC-002 - Ponte e Rolamento

| Propriedade | Valor |
|---|---|
| Categoria | ESCAPE |
| Raridade | COMMON |
| Custo | 3 |
| Atributo | STRENGTH |
| Requisito mínimo | 3 |
| Origem | MOUNT |
| Destino | CLOSED_GUARD ou SIDE_CONTROL, conforme o resultado da reversão |

**Efeito:** POSITION_TRANSITION.

**Sucesso:** utiliza a ponte e o rolamento para remover o controle adversário e estabelecer uma posição favorável.

**Falha:** mantém MOUNT.

**Efeito adicional:** reduz em 2 o controle situacional do adversário.

**Reação:** defesa compatível com tentativa de reversão ou fuga da montada.

**Observação:** o destino exato deverá ser determinado pela resolução da ação e validado nas regras de transição.

### ESC-003 - Escape das Costas

| Propriedade | Valor |
|---|---|
| Categoria | ESCAPE |
| Raridade | RARE |
| Custo | 4 |
| Atributo | TECHNIQUE |
| Requisito mínimo | 4 |
| Origem | BACK_CONTROL |
| Destino | SIDE_CONTROL ou CLOSED_GUARD |

**Efeito:** POSITION_TRANSITION.

**Sucesso:** remove o controle das costas e estabelece uma posição defensiva compatível.

**Falha:** mantém BACK_CONTROL.

**Efeito adicional:** reduz em 2 o controle situacional do adversário e cancela uma finalização ativa, quando aplicável.

**Reação:** defesa compatível com tentativa de fuga das costas.

### ESC-004 - Recuperação da Tartaruga

| Propriedade | Valor |
|---|---|
| Categoria | ESCAPE |
| Raridade | COMMON |
| Custo | 2 |
| Atributo | RESISTANCE |
| Requisito mínimo | 3 |
| Origem | TURTLE |
| Destino | CLOSED_GUARD ou STANDING |

**Efeito:** POSITION_TRANSITION.

**Sucesso:** recupera uma posição defensiva ou retorna à posição em pé, conforme a condição de execução.

**Falha:** mantém TURTLE.

**Efeito adicional:** reduz em 2 o controle situacional do adversário.

**Reação:** defesa compatível com tentativa de recuperação da tartaruga.

### ESC-005 - Recuperação de Meia-guarda

| Propriedade | Valor |
|---|---|
| Categoria | ESCAPE |
| Raridade | RARE |
| Custo | 3 |
| Atributo | TECHNIQUE |
| Requisito mínimo | 3 |
| Origem | SIDE_CONTROL |
| Destino | HALF_GUARD |

**Efeito:** POSITION_TRANSITION.

**Sucesso:** recupera a meia-guarda e estabelece uma posição defensiva intermediária.

**Falha:** mantém SIDE_CONTROL.

**Efeito adicional:** reduz em 2 o controle situacional do adversário e cancela uma finalização ativa, quando aplicável.

**Reação:** defesa compatível com tentativa de recuperação de meia-guarda.

### 6.1. Distribuição de raridade - ESCAPE

| Raridade | Quantidade |
|---|---:|
| COMMON | 3 |
| RARE | 2 |
| EPIC | 0 |
| LEGENDARY | 0 |
| **Total** | **5** |

## 7. Cartas de contra-ataque - COUNTERATTACK

As cartas de contra-ataque representam ações ofensivas executadas como consequência de uma defesa bem-sucedida ou de uma condição específica de reação.

Todas as cartas desta categoria deverão respeitar a regra de resolução composta: defesa e contra-ataque são resolvidos como uma única reação, sem abertura de uma segunda janela de reação.

### CTR-001 - Arm Drag

| Propriedade | Valor |
|---|---|
| Categoria | COUNTERATTACK |
| Raridade | COMMON |
| Custo | 2 |
| Atributo | TECHNIQUE |
| Requisito mínimo | 3 |
| Origem | CLOSED_GUARD ou OPEN_GUARD |
| Destino | BACK_CONTROL ou posição superior compatível |

**Efeito:** POSITION_TRANSITION.

**Condição de ativação:** defesa bem-sucedida contra uma ação ofensiva compatível e existência de posição favorável para execução do Arm Drag.

**Sucesso:** utiliza o controle do braço adversário para criar uma oportunidade de progressão e estabelecer uma posição superior compatível.

**Falha:** mantém a posição resultante da defesa inicial.

**Reação:** integra a resolução da defesa que ativou o contra-ataque. Não abre uma segunda janela de reação.

### CTR-002 - Raspagem de Contra-ataque

| Propriedade | Valor |
|---|---|
| Categoria | COUNTERATTACK |
| Raridade | COMMON |
| Custo | 2 |
| Atributo | TECHNIQUE |
| Requisito mínimo | 3 |
| Origem | CLOSED_GUARD ou OPEN_GUARD |
| Destino | SIDE_CONTROL |

**Efeito:** POSITION_TRANSITION.

**Condição de ativação:** defesa bem-sucedida contra uma tentativa compatível de progressão posicional.

**Sucesso:** executa uma reversão e estabelece controle superior em SIDE_CONTROL.

**Falha:** mantém a posição resultante da defesa inicial.

**Pontuação:** 2 pontos após estabilização, quando a ação resultar em uma raspagem válida.

**Reação:** integra a resolução da defesa que ativou o contra-ataque.

### CTR-003 - Reversão de Queda

| Propriedade | Valor |
|---|---|
| Categoria | COUNTERATTACK |
| Raridade | RARE |
| Custo | 3 |
| Atributo | STRENGTH |
| Requisito mínimo | 4 |
| Origem | STANDING |
| Destino | SIDE_CONTROL |

**Efeito:** POSITION_TRANSITION.

**Condição de ativação:** defesa bem-sucedida contra uma tentativa de queda adversária.

**Sucesso:** utiliza a reação à tentativa de queda para estabelecer controle superior em SIDE_CONTROL.

**Falha:** mantém STANDING.

**Pontuação:** 2 pontos após estabilização, caso a transição configure uma queda válida.

**Reação:** integra a resolução da defesa que ativou o contra-ataque.

### CTR-004 - Contra-ataque de Base

| Propriedade | Valor |
|---|---|
| Categoria | COUNTERATTACK |
| Raridade | RARE |
| Custo | 2 |
| Atributo | TECHNIQUE |
| Requisito mínimo | 3 |
| Origem | STANDING |
| Destino | STANDING ou SIDE_CONTROL, conforme a ação resolvida |

**Efeito:** POSITION_TRANSITION.

**Condição de ativação:** defesa bem-sucedida contra uma ação ofensiva em STANDING.

**Sucesso:** utiliza o desequilíbrio adversário para estabelecer uma posição favorável ou iniciar uma transição compatível.

**Falha:** mantém STANDING.

**Reação:** integra a resolução da defesa que ativou o contra-ataque.

### CTR-005 - Contra-ataque de Finalização

| Propriedade | Valor |
|---|---|
| Categoria | COUNTERATTACK |
| Raridade | EPIC |
| Custo | 3 |
| Atributo | TECHNIQUE |
| Requisito mínimo | 4 |
| Origem | Posição compatível com a finalização escolhida |
| Destino | Mantém a posição ou inicia uma sequência de finalização |

**Efeito:** inicia uma sequência de finalização compatível, utilizando a mecânica de SUBMISSION.

**Condição de ativação:** defesa bem-sucedida contra uma ação ofensiva compatível e existência de posição favorável para iniciar uma finalização.

**Sucesso:** inicia a preparação de uma finalização permitida pela posição e pelos requisitos da técnica.

**Falha:** mantém a posição resultante da defesa inicial.

**Reação:** integra a resolução da defesa que ativou o contra-ataque. A sequência de finalização iniciada seguirá as regras normais de SUBMISSION nas ações posteriores.

### 7.1. Distribuição de raridade - COUNTERATTACK

| Raridade | Quantidade |
|---|---:|
| COMMON | 2 |
| RARE | 2 |
| EPIC | 1 |
| LEGENDARY | 0 |
| **Total** | **5** |

## 8. Cartas de finalização - SUBMISSION

As cartas de finalização representam técnicas destinadas a encerrar a partida por meio de uma sequência de preparação, ataque e conclusão.

Cada carta define uma técnica específica, seus requisitos de posição e atributos.

### SUB-001 - Armbar

| Propriedade | Valor |
|---|---|
| Categoria | SUBMISSION |
| Raridade | COMMON |
| Custo de energia | Conforme custo definido para cada etapa |
| Atributo | TECHNIQUE |
| Requisito mínimo | 3 |
| Origem | CLOSED_GUARD ou MOUNT |
| Destino | Finalização concluída |

**Efeito:** sequência de finalização em três etapas.

**Sucesso:** conclui a sequência de Armbar e encerra a partida por finalização.

**Falha:** a etapa atual não avança.

**Reação:** defesa específica de Armbar, incluindo DEF-007.

### SUB-002 - Triangle

| Propriedade | Valor |
|---|---|
| Categoria | SUBMISSION |
| Raridade | RARE |
| Custo de energia | Conforme custo definido para cada etapa |
| Atributo | TECHNIQUE |
| Requisito mínimo | 4 |
| Origem | CLOSED_GUARD |
| Destino | Finalização concluída |

**Efeito:** sequência de finalização em três etapas.

**Sucesso:** conclui a sequência de Triangle e encerra a partida por finalização.

**Falha:** a etapa atual não avança.

**Reação:** defesa específica de Triangle, incluindo DEF-008.

### SUB-003 - Kimura

| Propriedade | Valor |
|---|---|
| Categoria | SUBMISSION |
| Raridade | RARE |
| Custo de energia | Conforme custo definido para cada etapa |
| Atributos | TECHNIQUE 3 e STRENGTH 2 |
| Origem | CLOSED_GUARD, OPEN_GUARD ou SIDE_CONTROL |
| Destino | Finalização concluída |

**Efeito:** sequência de finalização em três etapas.

**Sucesso:** conclui a sequência de Kimura e encerra a partida por finalização.

**Falha:** a etapa atual não avança.

**Reação:** defesa compatível com Kimura.

### SUB-004 - Mata-leão

| Propriedade | Valor |
|---|---|
| Categoria | SUBMISSION |
| Raridade | EPIC |
| Custo de energia | Conforme custo definido para cada etapa |
| Atributos | TECHNIQUE 3 e CONTROL 3 |
| Origem | BACK_CONTROL |
| Destino | Finalização concluída |

**Efeito:** sequência de finalização em três etapas.

**Sucesso:** conclui a sequência de Mata-leão e encerra a partida por finalização.

**Falha:** a etapa atual não avança.

**Reação:** defesa específica de Mata-leão, incluindo DEF-009.

### SUB-005 - Americana

| Propriedade | Valor |
|---|---|
| Categoria | SUBMISSION |
| Raridade | COMMON |
| Custo de energia | Conforme custo definido para cada etapa |
| Atributos | TECHNIQUE 2 e STRENGTH 3 |
| Origem | SIDE_CONTROL ou MOUNT |
| Destino | Finalização concluída |

**Efeito:** sequência de finalização em três etapas.

**Sucesso:** conclui a sequência de Americana e encerra a partida por finalização.

**Falha:** a etapa atual não avança.

**Reação:** defesa compatível com Americana.

### SUB-006 - Chave de Pé Reta

| Propriedade | Valor |
|---|---|
| Categoria | SUBMISSION |
| Raridade | RARE |
| Custo de energia | Conforme custo definido para cada etapa |
| Atributo | TECHNIQUE |
| Requisito mínimo | 4 |
| Origem | LEG_ENTANGLEMENT ou outra posição compatível validada |
| Destino | Finalização concluída |

**Efeito:** sequência de finalização em três etapas.

**Sucesso:** conclui a sequência de Chave de Pé Reta e encerra a partida por finalização.

**Falha:** a etapa atual não avança.

**Reação:** defesa compatível com Chave de Pé Reta.

### 8.1. Regras de progressão das finalizações

- A sequência possui três etapas: PREPARATION, ATTACK e CONCLUSION.
- Cada etapa deverá ser executada como uma ação independente.
- A sequência deverá permanecer vinculada à técnica iniciada.
- Uma defesa bem-sucedida impede o avanço da etapa atual.
- A defesa não cancela automaticamente as etapas anteriores.
- Uma fuga bem-sucedida cancela a sequência ativa.
- A conclusão bem-sucedida encerra imediatamente a partida.

**Observação técnica:** o custo individual de energia por etapa ainda precisa ser definido. As regras gerais estabelecem custos para ações de finalização, mas não determinam uma distribuição específica entre as três etapas. Os custos não devem ser inventados como valores definitivos.

Também deverá ser validado como o estado persistente da finalização será mantido após o uso da carta e sua movimentação para a zona de descarte.

### 8.2. Distribuição de raridade - SUBMISSION

| Raridade | Quantidade |
|---|---:|
| COMMON | 2 |
| RARE | 3 |
| EPIC | 1 |
| LEGENDARY | 0 |
| **Total** | **6** |

## 9. Cartas de estratégia - STRATEGY

As cartas de estratégia representam ajustes táticos e gerenciamento de recursos durante a luta.

### STR-001 - Recuperação de Fôlego

| Propriedade | Valor |
|---|---|
| Categoria | STRATEGY |
| Raridade | COMMON |
| Custo | 0 |
| Atributo | Não aplicável |
| Requisito mínimo | Nenhum |
| Origem | Qualquer posição válida |
| Destino | Mantém a posição atual |

**Efeito:** recuperação de energia.

**Sucesso:** recupera 2 pontos de energia, respeitando o limite máximo de 10.

**Falha:** não altera a energia quando o atleta já estiver no limite máximo.

**Condição de execução:** consome uma ação principal.

**Reação:** não abre janela de reação ofensiva.

**Observação:** a recuperação segue o valor básico de +2 definido nas regras gerais da partida.

### STR-002 - Ajuste de Estratégia

| Propriedade | Valor |
|---|---|
| Categoria | STRATEGY |
| Raridade | COMMON |
| Custo | 1 |
| Atributo | TECHNIQUE |
| Requisito mínimo | Nenhum |
| Origem | Qualquer posição válida |
| Destino | Mantém a posição atual |

**Efeito:** TEMPORARY_MODIFIER.

**Sucesso:** concede +1 ao atributo TECHNIQUE até o final do turno atual.

**Falha:** não aplica o modificador quando a carta não puder ser executada.

**Reação:** não abre janela de reação ofensiva.

### STR-003 - Preparação Tática

| Propriedade | Valor |
|---|---|
| Categoria | STRATEGY |
| Raridade | RARE |
| Custo | 1 |
| Atributo | Não aplicável |
| Requisito mínimo | Nenhum |
| Origem | Qualquer posição válida |
| Destino | Mantém a posição atual |

**Efeito:** TEMPORARY_MODIFIER.

**Sucesso:** concede +1 ao resultado da próxima ação ofensiva válida do atleta.

**Duração:** até a utilização do modificador ou o final do próximo turno do atleta, conforme a regra de expiração definida pelo motor.

**Falha:** o modificador não é consumido por uma ação inválida ou incompatível.

**Reação:** não abre janela de reação ofensiva.

### STR-004 - Controle do Ritmo

| Propriedade | Valor |
|---|---|
| Categoria | STRATEGY |
| Raridade | EPIC |
| Custo | 2 |
| Atributo | CONTROL |
| Requisito mínimo | Nenhum |
| Origem | Qualquer posição válida |
| Destino | Mantém a posição atual |

**Efeito:** ajuste de controle situacional.

**Sucesso:** aumenta em 1 ponto o controle situacional do próprio atleta, respeitando o limite máximo de 5.

**Falha:** não altera o controle situacional quando o atleta já estiver no limite máximo.

**Reação:** não abre janela de reação ofensiva.

**Observação:** o efeito exige validação no modelo de efeitos, pois representa alteração direta do controle situacional, não um bônus ao resultado de combate.

### 9.1. Distribuição de raridade - STRATEGY

| Raridade | Quantidade |
|---|---:|
| COMMON | 2 |
| RARE | 1 |
| EPIC | 1 |
| LEGENDARY | 0 |
| **Total** | **4** |

## 10. Distribuição consolidada de raridade

| Categoria | COMMON | RARE | EPIC | LEGENDARY | Total |
|---|---:|---:|---:|---:|---:|
| ATTACK | 5 | 4 | 1 | 0 | 10 |
| DEFENSE | 5 | 4 | 1 | 0 | 10 |
| ESCAPE | 3 | 2 | 0 | 0 | 5 |
| COUNTERATTACK | 2 | 2 | 1 | 0 | 5 |
| SUBMISSION | 2 | 3 | 1 | 0 | 6 |
| STRATEGY | 2 | 1 | 1 | 0 | 4 |
| **Total** | **19** | **16** | **5** | **0** | **40** |

### 10.1. Percentual de raridade

| Raridade | Quantidade | Percentual |
|---|---:|---:|
| COMMON | 19 | 47,5% |
| RARE | 16 | 40% |
| EPIC | 5 | 12,5% |
| LEGENDARY | 0 | 0% |
| **Total** | **40** | **100%** |

## 11. Pendências de validação

Os seguintes pontos deverão ser revisados antes da implementação do catálogo no motor do jogo.

### 11.1. Compatibilidade posicional

- Validar se ATK-003 deverá resultar exclusivamente em SIDE_CONTROL.
- Validar os destinos alternativos das cartas ESCAPE.
- Definir as condições exatas de origem e destino de CTR-001 e CTR-005.
- Validar a posição necessária para cada etapa de SUBMISSION.

### 11.2. Custos de energia

- Validar os custos individuais das cartas de ataque e defesa.
- Definir o custo de energia de cada etapa das finalizações.
- Validar os custos de ESCAPE e COUNTERATTACK.
- Confirmar a recuperação de energia de STR-001 em relação à recuperação básica de +2.

### 11.3. Efeitos e integração com o motor

- Confirmar os parâmetros necessários para BLOCK, REDUCE_MODIFIER e PREVENT_PROGRESSION.
- Confirmar a identificação da técnica protegida por SUBMISSION_DEFENSE.
- Definir como o controle situacional será alterado por ESCAPE.
- Validar o efeito de controle situacional de STR-004.
- Definir como a sequência de finalização será persistida entre as ações.
- Definir como os modificadores temporários serão consumidos e expirados.

### 11.4. Balanceamento

- Validar os bônus de resultado das cartas.
- Validar a diferença de força entre cartas COMMON, RARE e EPIC.
- Avaliar a relação entre custo de energia e impacto de cada carta.
- Validar a quantidade de cartas por categoria e raridade.
- Realizar playtests para avaliar a duração e o equilíbrio das partidas.

## 12. Regras de composição do baralho

O catálogo disponibiliza 40 definições de cartas.

A composição do baralho de cada atleta deverá respeitar as regras gerais:

- Exatamente 40 cartas por baralho.
- Máximo de 2 cópias da mesma carta.
- Carta do atleta não integra o baralho.
- Carta do atleta permanece ativa durante toda a partida.
- As cartas utilizadas são movimentadas para a zona de descarte após a resolução.
- Cartas inválidas ou incompatíveis não são consumidas.
- A mão inicial contém 5 cartas.
- O limite máximo de mão é 7 cartas.

A quantidade de cópias de cada definição dentro de um baralho deverá ser validada separadamente da quantidade de definições existentes no catálogo.

---

**Fim do documento - Card Catalog v1.0**
