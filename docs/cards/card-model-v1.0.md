# Card Model Specification - v1.0

- **Projeto:** ROLL TCG
- **Documento:** Card Model Specification
- **Versão:** 1.0
- **Status:** Draft
- **Feature:** 04 - Card System & Card Catalog

---

## 1. Objetivo

Definir o modelo conceitual e estrutural das cartas do ROLL TCG, estabelecendo propriedades, classificações, requisitos de utilização, custos, efeitos e estados durante uma partida.

Este documento servirá como referência para a construção do catálogo de cartas e, futuramente, para a implementação do motor de regras.

A especificação é independente de linguagem de programação ou tecnologia.

## 2. Princípios do sistema de cartas

O sistema de cartas deverá seguir os seguintes princípios:

- Cada carta deve possuir uma identificação única e permanente no catálogo.
- Toda carta deve possuir uma categoria e um efeito principal.
- Os requisitos de utilização devem ser explícitos.
- Custos de energia devem ser definidos individualmente.
- Cartas que alteram posições devem declarar suas posições de origem e destino.
- Os efeitos devem ser tipados e interpretáveis pelo motor de regras.
- A raridade não deve determinar automaticamente o poder da carta.
- As cartas devem respeitar as regras gerais da partida.
- A definição de uma carta deve ser independente de cada cópia utilizada em uma partida.

## 3. Classificação das cartas

### 3.1 Categorias

O catálogo inicial utilizará seis categorias:

| Categoria | Identificador | Finalidade |
|---|---|---|
| Ataque | ATTACK | Executar ações ofensivas e buscar progressão posicional ou pontuação |
| Defesa | DEFENSE | Neutralizar ou reduzir ações ofensivas adversárias |
| Fuga | ESCAPE | Sair de posições desfavoráveis e recuperar uma posição competitiva |
| Contra-ataque | COUNTERATTACK | Executar uma ação ofensiva após uma defesa bem-sucedida |
| Finalização | SUBMISSION | Iniciar e desenvolver sequências de finalização |
| Estratégia | STRATEGY | Recuperar energia ou aplicar modificadores estratégicos |

### 3.2 Raridades

| Raridade | Identificador | Característica |
|---|---|---|
| Comum | COMMON | Cartas fundamentais e versáteis |
| Rara | RARE | Cartas com requisitos ou aplicações mais específicas |
| Épica | EPIC | Cartas com impacto estratégico elevado e condições mais restritas |
| Lendária | LEGENDARY | Categoria reservada para futuras expansões |

A raridade representa a classificação de distribuição e identidade da carta. Não representa, isoladamente, superioridade mecânica.

A distribuição inicial do catálogo será definida em `card-catalog-v1.0.md`.

## 4. Atributos dos atletas

As cartas poderão utilizar os atributos permanentes do atleta:

| Atributo | Identificador | Aplicação |
|---|---|---|
| Força | STRENGTH | Ações que dependem de força física |
| Técnica | TECHNIQUE | Execução técnica e precisão |
| Resistência | RESISTANCE | Resistência a ataques e manutenção defensiva |
| Controle | CONTROL | Estabilização e domínio posicional |

Os atributos pertencem ao atleta, não à carta.

Uma carta pode exigir um valor mínimo de atributo para ser utilizada ou indicar qual atributo será considerado na resolução da ação.

### 4.1 Regras de requisitos

Os requisitos devem ser declarados explicitamente.

Exemplo conceitual:

- Atributo aplicável: TECHNIQUE.
- Requisito mínimo: 3.
- Posição necessária: SIDE_CONTROL.
- Energia necessária: 3.

A verificação dos requisitos deve ocorrer antes do pagamento do custo e da abertura da janela de reação.

## 5. Modelo de dados da carta

Cada definição de carta deverá possuir as seguintes propriedades:

| Campo | Obrigatório | Descrição |
|---|---|---|
| id | Sim | Identificador único e permanente |
| name | Sim | Nome da carta |
| category | Sim | Categoria da carta |
| rarity | Sim | Raridade |
| description | Sim | Descrição apresentada ao jogador |
| energyCost | Sim | Custo de energia para utilização |
| resultBonus | Não | Bônus numérico aplicado diretamente ao resultado da ação |
| attribute | Não | Atributo utilizado na resolução |
| requirements | Não | Requisitos adicionais |
| positions | Não | Posições de origem e destino |
| effect | Sim | Efeito principal |
| secondaryEffects | Não | Efeitos adicionais |
| tags | Não | Palavras-chave para classificação e interação |
| artwork | Não | Referência à arte visual |

### 5.1 Regras do campo resultBonus

O campo `resultBonus` representa um bônus numérico aplicado diretamente ao resultado da ação executada com a carta.

Sua aplicação deverá respeitar as seguintes regras:

- O campo é opcional.
- Quando não estiver definido, seu valor será considerado zero.
- Deverá aceitar valores inteiros positivos, negativos ou zero.
- Será aplicado exclusivamente à ação associada à carta.
- Deverá ser considerado antes da comparação final entre os resultados do atacante e do defensor.
- Não deverá alterar permanentemente os atributos do atleta.
- Não deverá ser registrado como um modificador temporário.
- Não permanecerá ativo após a resolução da ação.

O campo `resultBonus` não representa um efeito independente. Ele compõe diretamente o cálculo do resultado da ação, conforme a fórmula definida nas regras gerais do jogo.

### 5.2 Identificação

O identificador deverá seguir um padrão por categoria:

- ATK: Attack.
- DEF: Defense.
- ESC: Escape.
- CTR: Counterattack.
- SUB: Submission.
- STR: Strategy.

Exemplos:

- ATK-001
- DEF-001
- ESC-001
- CTR-001
- SUB-001
- STR-001

O identificador não deverá mudar quando o nome ou a descrição visual da carta forem alterados.

### 5.3 Custo de energia

O campo `energyCost` representa o custo necessário para utilizar a carta.

Regras:

- O custo deve ser um número inteiro não negativo.
- O jogador precisa possuir energia suficiente.
- O custo deve ser pago antes da abertura da janela de reação.
- A energia permanece consumida mesmo quando a ação é defendida.
- Cartas defensivas também possuem custos próprios.
- A defesa passiva permanece disponível quando o jogador não possui energia suficiente para utilizar uma carta defensiva.

Cartas de finalização deverão respeitar os custos específicos de cada etapa definidos nas regras de finalização.

## 6. Requisitos e compatibilidade posicional

As cartas poderão exigir uma ou mais posições para serem utilizadas.

### 6.1 Identificadores de posição

O catálogo deverá utilizar os seguintes identificadores:

| Posição | Identificador |
|---|---|
| Guarda fechada | CLOSED_GUARD |
| Guarda aberta | OPEN_GUARD |
| Meia-guarda | HALF_GUARD |
| Cem quilos | SIDE_CONTROL |
| Joelho na barriga | KNEE_ON_BELLY |
| Montada | MOUNT |
| Controle das costas | BACK_CONTROL |
| Em pé | STANDING |
| Tartaruga | TURTLE |
| Entrelaçamento de pernas | LEG_ENTANGLEMENT |

### 6.2 Regras de compatibilidade

Cada carta deverá declarar as posições nas quais pode ser utilizada.

Cartas que alteram a posição dos atletas deverão declarar:

- Posição de origem.
- Posição de destino.
- Condições necessárias para a transição.
- Resultado em caso de sucesso.
- Resultado em caso de falha, quando aplicável.

Não serão aceitas descrições genéricas como "avança para uma posição superior" sem especificação do destino.

Cartas que oferecem destinos alternativos deverão declarar explicitamente todas as possibilidades e suas condições.

## 7. Modelo de efeitos

Toda carta deverá possuir um efeito principal.

Os efeitos devem utilizar identificadores tipados, evitando descrições livres como única fonte de execução.

### 7.1 Tipos iniciais de efeitos

| Efeito | Identificador | Descrição |
|---|---|---|
| Transição posicional | POSITION_TRANSITION | Altera a posição dos atletas |
| Bloqueio | BLOCK | Neutraliza uma técnica específica |
| Redução de modificador | REDUCE_MODIFIER | Reduz o resultado ou modificador de uma ação |
| Impedir progressão | PREVENT_PROGRESSION | Impede avanço posicional ou de uma sequência |
| Defesa de finalização | SUBMISSION_DEFENSE | Impede o avanço de uma etapa de finalização |
| Recuperação de energia | ENERGY_RECOVERY | Recupera energia |
| Modificador temporário | TEMPORARY_MODIFIER | Aplica bônus ou penalidade temporária |
| Efeito composto | COMPOSITE | Executa uma sequência ordenada de efeitos |

O campo `resultBonus` não constitui um novo tipo de efeito. Ele é uma propriedade opcional da definição da carta, utilizada diretamente no cálculo do resultado.

### 7.2 Efeito principal e efeitos secundários

Uma carta poderá possuir:

- Um efeito principal obrigatório.
- Nenhum ou vários efeitos secundários opcionais.

Quando houver múltiplos efeitos, a ordem de execução deverá ser explicitamente definida.

Efeitos secundários não poderão ignorar requisitos ou regras gerais da partida.

### 7.3 Bloqueio e mitigação

O efeito BLOCK deverá identificar exatamente a técnica que pode neutralizar.

Bloqueios genéricos não serão permitidos.

Os efeitos REDUCE_MODIFIER e PREVENT_PROGRESSION deverão ser utilizados quando a carta reduzir o impacto de uma ação sem neutralizá-la completamente.

Essa distinção preserva a regra de compatibilidade específica entre técnicas e cartas defensivas.

## 8. Definição e instância da carta

O sistema deverá separar a definição de catálogo da cópia utilizada durante a partida.

### 8.1 Card Definition

Representa a definição da carta no catálogo.

Contém:

- Identificação.
- Nome.
- Categoria.
- Raridade.
- Descrição.
- Custo.
- Bônus de resultado, quando aplicável.
- Requisitos.
- Posições.
- Efeitos.
- Referência visual.

A definição deverá ser tratada como imutável durante uma partida. Alterações no catálogo não deverão modificar retroativamente uma partida em andamento.

### 8.2 Card Instance

Representa uma cópia individual de uma carta durante uma partida.

Deverá possuir:

| Campo | Descrição |
|---|---|
| instanceId | Identificador único da cópia |
| cardDefinitionId | Referência à definição do catálogo |
| ownerId | Jogador proprietário |
| currentZone | Zona atual da carta |
| used | Indica se a carta já foi utilizada na partida |

As instâncias devem permitir identificar individualmente cartas iguais pertencentes ao mesmo jogador.

## 9. Zonas e ciclo de vida

As cartas poderão estar nas seguintes zonas:

| Zona | Identificador | Descrição |
|---|---|---|
| Baralho | DECK | Cartas disponíveis para compra |
| Mão | HAND | Cartas disponíveis para utilização |
| Descarte | DISCARD | Cartas já utilizadas |
| Exílio | EXILE | Cartas removidas da partida |

Regras gerais:

- Cada jogador começa com cinco cartas na mão.
- O jogador compra uma carta no início de seu turno.
- O limite máximo da mão é sete cartas.
- Cartas utilizadas são movidas para o descarte, salvo efeito específico em contrário.
- Não existe embaralhamento automático do descarte para formar um novo baralho.
- A exaustão do baralho deverá respeitar as regras gerais da partida.

## 10. Interação com o sistema de finalização

As cartas da categoria SUBMISSION representam técnicas que podem iniciar uma sequência de finalização.

Uma finalização deverá possuir três etapas:

1. Preparação.
2. Ataque.
3. Conclusão.

Cada etapa deverá:

- Exigir uma ação válida.
- Possuir custo de energia.
- Abrir uma janela de reação.
- Respeitar os requisitos posicionais e de atributos.

O progresso da finalização deverá ser mantido em um estado próprio da partida, independente da instância da carta.

A defesa bem-sucedida poderá impedir o avanço da sequência, mas não cancelará automaticamente o progresso anterior.

Uma fuga bem-sucedida deverá cancelar a sequência ativa.

A conclusão bem-sucedida resulta em vitória imediata.

## 11. Compatibilidade com o motor de regras

O motor de regras será responsável por:

- Validar requisitos.
- Verificar compatibilidade posicional.
- Verificar disponibilidade de energia.
- Processar efeitos.
- Abrir e resolver janelas de reação.
- Calcular resultados considerando atributos, bônus da carta e modificadores aplicáveis.
- Atualizar estados dos atletas.
- Atualizar zonas das cartas.
- Registrar eventos da partida.

As cartas deverão fornecer definições estruturadas para que o motor execute os efeitos sem depender exclusivamente de interpretação textual.

## 12. Diretrizes de balanceamento

O balanceamento das cartas deverá observar:

1. Cartas com maior impacto exigem custos maiores ou requisitos mais restritivos.
2. Cartas defensivas devem possuir custos proporcionais à ameaça neutralizada.
3. Cartas comuns devem permanecer úteis durante toda a partida.
4. Cartas raras e épicas devem oferecer especialização ou impacto estratégico, sem eliminar possibilidades de resposta.
5. A raridade não deve ser o único fator de balanceamento.
6. Nenhuma carta poderá ignorar as regras fundamentais de posição, energia ou reação.
7. Os valores numéricos deverão ser validados por testes de partidas.

Os custos, bônus e modificadores apresentados no catálogo inicial serão considerados valores de balanceamento preliminar até a realização de playtests.

## 13. Decisões pendentes de validação

Os seguintes pontos deverão ser revisados durante a consolidação do catálogo:

- Custos definitivos de energia.
- Valores de `resultBonus` e demais modificadores de cada carta.
- Compatibilidade exata entre técnicas e posições.
- Condições de sucesso e falha.
- Distribuição final de raridades.
- Regras específicas de exaustão do baralho.
- Interações entre efeitos compostos.
- Duração e expiração dos modificadores temporários.

## 14. Documentos relacionados

- `docs/game-design/gdd-v0.1.md`
- `docs/game-design/game-rules-v1.0.md`
- `docs/cards/card-effects-v1.0.md`
- `docs/cards/card-catalog-v1.0.md`