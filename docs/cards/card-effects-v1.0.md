# Card Effects Specification - v1.0

- **Projeto:** ROLL TCG
- **Documento:** Card Effects Specification
- **Versão:** 1.0
- **Status:** Draft
- **Feature:** 04 - Card System & Card Catalog

---

## 1. Objetivo

Definir os tipos de efeitos disponíveis no sistema de cartas do ROLL TCG e estabelecer as regras para sua validação, execução e interação com o motor de regras.

Este documento complementa `card-model-v1.0.md` e estabelece o padrão que deverá ser utilizado no catálogo inicial de cartas.

O objetivo é garantir que os efeitos sejam estruturados, previsíveis, rastreáveis e independentes de suas descrições visuais.

## 2. Princípios de execução

O processamento dos efeitos deverá seguir os seguintes princípios:

- Os efeitos devem ser declarativos e estruturados.
- O motor de regras será responsável pela execução.
- Nenhum efeito poderá ignorar os requisitos da carta.
- Os efeitos devem respeitar as regras de energia, posição e reação.
- Cada efeito deverá possuir um identificador de tipo.
- Efeitos compostos deverão possuir ordem explícita de execução.
- Toda alteração no estado da partida deverá ser validada.
- Os resultados deverão ser registrados no histórico de eventos da partida.

A descrição textual apresentada ao jogador não será utilizada como fonte de execução das regras.

## 3. Estrutura de um efeito

Todo efeito deverá possuir uma estrutura lógica contendo:

| Campo | Obrigatório | Descrição |
|---|---|---|
| type | Sim | Identificador do tipo de efeito |
| parameters | Sim | Parâmetros necessários para execução |
| target | Não | Atleta ou elemento afetado |
| duration | Não | Duração do efeito |
| conditions | Não | Condições adicionais de execução |
| priority | Não | Ordem de execução quando aplicável |

### 3.1 Tipos de parâmetros

Os parâmetros deverão ser específicos para cada tipo de efeito.

Exemplos:

- Valor de energia recuperada.
- Valor de modificador aplicado.
- Técnica que poderá ser bloqueada.
- Posição de origem.
- Posição de destino.
- Etapa de finalização afetada.
- Duração de um modificador temporário.

Um efeito não poderá receber parâmetros incompatíveis com seu tipo.

## 4. Catálogo de efeitos

O sistema inicial utilizará os seguintes tipos de efeitos.

### 4.1 POSITION_TRANSITION

**Finalidade:** alterar a posição dos atletas durante a partida.

Parâmetros:

| Parâmetro | Obrigatório | Descrição |
|---|---|---|
| originPosition | Sim | Posição de origem |
| destinationPosition | Sim | Posição de destino |
| target | Sim | Atleta cuja posição será alterada |

Regras:

- A posição atual deverá corresponder à posição de origem.
- A transição deverá respeitar os requisitos da carta.
- O destino deverá ser uma posição válida.
- A transição deverá ser validada antes de alterar o estado da partida.
- A pontuação correspondente deverá respeitar as regras de estabilização.

Uma transição inválida não poderá alterar a posição dos atletas.

### 4.2 BLOCK

**Finalidade:** neutralizar completamente uma técnica específica.

Parâmetros:

| Parâmetro | Obrigatório | Descrição |
|---|---|---|
| blockedTechniqueId | Sim | Identificador da técnica neutralizada |
| target | Sim | Ação adversária afetada |

Regras:

- O bloqueio deverá identificar exatamente a técnica que poderá neutralizar.
- O bloqueio deverá ocorrer dentro de uma janela de reação válida.
- A técnica deverá corresponder ao identificador declarado.
- Um bloqueio bem-sucedido neutraliza a ação correspondente.
- Bloqueios não poderão ser utilizados contra técnicas incompatíveis.

O efeito BLOCK não deverá ser confundido com redução de modificadores ou impedimento de progressão.

### 4.3 REDUCE_MODIFIER

**Finalidade:** reduzir o resultado de uma ação adversária sem necessariamente neutralizá-la.

Parâmetros:

| Parâmetro | Obrigatório | Descrição |
|---|---|---|
| modifierValue | Sim | Valor da redução |
| target | Sim | Resultado ou ação afetada |
| modifierType | Sim | Tipo de modificador afetado |

Regras:

- A redução será aplicada antes da comparação final dos resultados.
- O valor não poderá ser negativo.
- O efeito não deverá cancelar automaticamente a ação.
- A ação continuará sujeita às regras normais de resolução.
- Quando utilizado durante uma reação, o efeito deverá ser considerado no cálculo do resultado da ação original.

### 4.4 PREVENT_PROGRESSION

**Finalidade:** impedir uma progressão posicional ou de uma sequência de finalização.

Parâmetros:

| Parâmetro | Obrigatório | Descrição |
|---|---|---|
| progressionType | Sim | Tipo de progressão afetada |
| target | Sim | Progressão adversária |
| scope | Sim | Escopo da prevenção |

Regras:

- O efeito deverá identificar a progressão que pretende impedir.
- A prevenção deverá ocorrer antes da atualização do estado.
- O efeito não deverá cancelar automaticamente estados anteriores.
- A prevenção não deverá ser confundida com bloqueio completo da técnica.

### 4.5 SUBMISSION_DEFENSE

**Finalidade:** impedir o avanço de uma etapa de finalização.

Parâmetros:

| Parâmetro | Obrigatório | Descrição |
|---|---|---|
| submissionId | Sim | Identificador da finalização |
| stage | Sim | Etapa afetada |
| target | Sim | Sequência de finalização adversária |

Regras:

- A defesa deverá ser compatível com a finalização ativa.
- A defesa deverá ser executada durante a janela de reação.
- O efeito deverá impedir o avanço da etapa correspondente.
- O progresso anterior deverá ser preservado, salvo efeito específico em contrário.
- Uma fuga bem-sucedida deverá cancelar a sequência ativa.

### 4.6 ENERGY_RECOVERY

**Finalidade:** recuperar energia do atleta.

Parâmetros:

| Parâmetro | Obrigatório | Descrição |
|---|---|---|
| recoveryAmount | Sim | Quantidade de energia recuperada |
| target | Sim | Atleta que receberá a recuperação |

Regras:

- A energia recuperada deverá ser um número inteiro positivo.
- A energia final não poderá ultrapassar o limite máximo de 10.
- A recuperação deverá respeitar o custo de ação da carta.
- O efeito não poderá gerar energia acima do limite estabelecido.

A recuperação automática de energia no início do turno e a ação básica de recuperação permanecem definidas nas regras gerais da partida.

### 4.7 TEMPORARY_MODIFIER

**Finalidade:** aplicar bônus ou penalidade temporária a um atleta ou ação.

Parâmetros:

| Parâmetro | Obrigatório | Descrição |
|---|---|---|
| attribute | Sim | Atributo afetado |
| modifierValue | Sim | Valor do modificador |
| duration | Sim | Duração do modificador |
| target | Sim | Atleta afetado |

Regras:

- O atributo afetado deverá existir no modelo de atributos.
- O modificador poderá ser positivo ou negativo.
- A duração deverá ser explicitamente definida.
- O modificador deverá expirar conforme sua regra de duração.
- O modificador não deverá alterar permanentemente os atributos do atleta.
- O efeito deverá ser considerado nos cálculos enquanto estiver ativo.

O efeito TEMPORARY_MODIFIER não deverá ser utilizado para representar o campo `resultBonus`, pois esse campo aplica um bônus diretamente ao resultado de uma única ação e não cria um estado temporário.

### 4.8 COMPOSITE

**Finalidade:** executar dois ou mais efeitos em uma sequência controlada.

Parâmetros:

| Parâmetro | Obrigatório | Descrição |
|---|---|---|
| effects | Sim | Lista ordenada de efeitos |
| executionMode | Sim | Estratégia de execução |

Regras:

- A lista deverá conter pelo menos dois efeitos.
- A ordem de execução deverá ser explícita.
- Cada efeito deverá ser validado individualmente.
- Os efeitos deverão respeitar os requisitos gerais da partida.
- A execução deverá interromper-se quando uma condição obrigatória falhar.
- O resultado deverá registrar quais efeitos foram executados e quais foram interrompidos.

O comportamento de reversão de efeitos em caso de falha deverá ser definido na implementação do motor de regras.

## 5. Alvos dos efeitos

Os efeitos poderão atuar sobre diferentes elementos da partida.

| Alvo | Identificador | Descrição |
|---|---|---|
| Jogador ativo | ACTIVE_PLAYER | Jogador que utiliza a carta |
| Adversário | OPPONENT | Jogador adversário |
| Atleta próprio | OWN_ATHLETE | Atleta controlado pelo jogador |
| Atleta adversário | OPPONENT_ATHLETE | Atleta controlado pelo adversário |
| Ação adversária | OPPONENT_ACTION | Ação executada pelo adversário |
| Finalização ativa | ACTIVE_SUBMISSION | Sequência de finalização em andamento |

A definição do alvo deverá ser compatível com o tipo de efeito.

## 6. Ordem de processamento

A execução de uma carta deverá respeitar o seguinte fluxo:

1. Identificar a carta utilizada.
2. Validar a disponibilidade da carta na mão.
3. Validar os requisitos posicionais.
4. Validar os requisitos de atributos.
5. Validar a disponibilidade de energia.
6. Consumir a energia necessária.
7. Abrir a janela de reação, quando aplicável.
8. Resolver a reação do adversário e os efeitos defensivos válidos.
9. Calcular o resultado da ação, considerando atributo, bônus da carta e modificadores aplicáveis.
10. Determinar se a ação foi bem-sucedida, bloqueada ou mitigada.
11. Executar os efeitos autorizados conforme o resultado.
12. Atualizar o estado da partida.
13. Registrar os eventos produzidos.
14. Mover a carta para a zona correspondente.

O fluxo deverá respeitar as regras específicas de cada categoria de carta.

### 6.1 Aplicação do bônus da carta

O campo `resultBonus`, definido no documento `card-model-v1.0.md`, representa um bônus direto aplicado ao resultado da ação associada à carta.

Sua aplicação deverá seguir estas regras:

- O bônus será considerado durante o cálculo do resultado da ação.
- O bônus será aplicado antes da comparação entre os resultados do atacante e do defensor.
- O bônus será somado ao atributo aplicável e aos demais modificadores válidos.
- Quando o campo não estiver definido, será considerado o valor zero.
- O bônus será aplicado exclusivamente à ação associada à carta.
- O bônus não será registrado como modificador temporário.
- O bônus não permanecerá ativo após a resolução da ação.
- O bônus não alterará os atributos permanentes do atleta.

O campo `resultBonus` não constitui um efeito independente e não deverá ser incluído na lista de efeitos secundários da carta.

## 7. Janelas de reação

As cartas de reação deverão ser executadas exclusivamente durante uma janela válida.

Regras:

- A janela deverá ser aberta após a validação e o pagamento do custo da ação ofensiva.
- O defensor poderá utilizar uma carta compatível.
- A carta de reação deverá respeitar seus próprios requisitos e custos.
- A defesa passiva permanecerá disponível.
- Uma reação não poderá abrir uma nova janela de reação.
- O resultado da reação deverá ser resolvido antes da conclusão da ação original.
- Os efeitos defensivos válidos deverão ser considerados na resolução da ação original.

Cartas de contra-ataque deverão seguir as condições específicas definidas nas regras gerais da partida.

## 8. Resolução de resultados

A resolução das ações deverá respeitar a fórmula definida no documento de regras:

`Resultado = Atributo aplicável + Bônus da carta + Modificadores`

Regras:

- Os valores deverão ser calculados após a resolução da reação e a validação dos modificadores aplicáveis.
- O campo `resultBonus` deverá ser incluído no cálculo quando estiver definido na carta utilizada.
- Modificadores temporários deverão ser considerados quando ativos.
- Reduções defensivas deverão ser aplicadas antes da comparação final.
- Em caso de empate, a defesa será favorecida.
- O resultado deverá determinar se a ação foi bem-sucedida, bloqueada ou mitigada.

O cálculo do resultado deverá ocorrer antes da aplicação dos efeitos que dependem do sucesso da ação.

Os efeitos defensivos que alteram o resultado ou impedem uma progressão deverão ser processados no momento adequado da resolução, respeitando a janela de reação e a ordem estabelecida nesta especificação.

## 9. Falhas e efeitos inválidos

Um efeito deverá ser considerado inválido quando:

- Possuir parâmetros obrigatórios ausentes.
- Utilizar um identificador de efeito inexistente.
- Referenciar uma posição incompatível.
- Tentar alterar um estado inválido.
- Exceder limites estabelecidos.
- Não atender às condições de execução.

Regras:

- Efeitos inválidos não poderão alterar o estado da partida.
- O resultado da validação deverá ser registrado.
- O motor deverá identificar o motivo da falha.
- O comportamento da ação original deverá respeitar as regras específicas de resolução.

## 10. Registro de eventos

Toda execução deverá produzir registros suficientes para reconstruir o resultado da ação.

Informações mínimas:

- Identificador da partida.
- Jogador responsável.
- Identificador da carta.
- Tipo de efeito.
- Alvo afetado.
- Estado anterior relevante.
- Resultado da execução.
- Estado posterior relevante.
- Motivo de falha, quando aplicável.

O registro deverá permitir auditoria e investigação de inconsistências.

## 11. Interação com finalizações

Os efeitos relacionados a finalizações deverão respeitar as três etapas estabelecidas:

1. Preparação.
2. Ataque.
3. Conclusão.

Regras:

- Cada etapa deverá ser validada individualmente.
- Cada etapa deverá possuir custo de energia.
- Cada etapa deverá abrir uma janela de reação.
- Uma defesa poderá impedir o avanço da etapa atual.
- O progresso anterior será preservado, salvo regra específica.
- Uma fuga bem-sucedida cancelará a sequência.
- Uma conclusão bem-sucedida encerra a partida imediatamente.

O estado persistente da finalização deverá ser mantido pelo motor de regras, independentemente da instância da carta.

## 12. Limites e restrições

Nenhum efeito poderá:

- Ultrapassar o limite máximo de energia.
- Criar posições inexistentes.
- Ignorar requisitos de atributos.
- Ignorar compatibilidade posicional.
- Ignorar janelas de reação.
- Executar uma segunda reação.
- Alterar atributos permanentes sem regra específica.
- Conceder vitória sem atender às condições de finalização.

## 13. Diretrizes para implementação futura

A implementação deverá manter separados:

- Definição dos efeitos.
- Validação dos efeitos.
- Execução dos efeitos.
- Atualização do estado da partida.
- Registro dos eventos.

Os efeitos deverão ser implementados de maneira modular, permitindo adicionar novos tipos sem modificar desnecessariamente os efeitos já existentes.

A implementação deverá possuir testes unitários para cada tipo de efeito e testes de integração para sequências compostas e janelas de reação.

## 14. Decisões pendentes de validação

Os seguintes pontos deverão ser detalhados antes da implementação:

- Política de atomicidade dos efeitos compostos.
- Ordem exata de aplicação de modificadores simultâneos.
- Duração e expiração de modificadores temporários.
- Escopo de prevenção de progressão.
- Tratamento de efeitos inválidos durante uma reação.
- Regras de persistência dos estados de finalização.
- Estratégia de registro e auditoria dos eventos.

## 15. Documentos relacionados

- `docs/game-design/gdd-v0.1.md`
- `docs/game-design/game-rules-v1.0.md`
- `docs/cards/card-model-v1.0.md`
- `docs/cards/card-catalog-v1.0.md`