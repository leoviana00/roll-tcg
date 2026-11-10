# ROLL TCG — Especificação das Regras do Jogo

- **Versão:** 1.0
- **Status:** Especificação inicial para implementação do MVP
- **Documento relacionado:** `docs/game-design/gdd-v0.1.md`
- **Issue:** #5 — Game Rules Specification

---

## 1. Objetivo e escopo

Este documento formaliza as regras funcionais do ROLL TCG, estabelecendo os critérios necessários para implementar o motor de regras do jogo.

O jogo é um Trading Card Game estratégico inspirado no Jiu-Jitsu brasileiro, no qual dois jogadores controlam atletas e utilizam cartas para executar ataques, defesas, transições posicionais, escapes e finalizações.

A especificação contempla:

- Estrutura de partidas, rodadas e turnos.

- Atributos, energia e controle.

- Posições e transições.

- Ações, combate e reações.

- Finalizações.

- Pontuação e vantagens.

- Gerenciamento de cartas e deck.

- Condições de vitória e encerramento.

Os valores numéricos identificados como provisórios deverão ser validados por meio de playtests e ajustes de balanceamento.

## 2. Estrutura da partida

### 2.1. Configuração

- Dois jogadores participam da partida.

- Cada jogador controla um atleta.

- Cada atleta possui atributos próprios e um deck de 40 cartas.

- A partida possui no máximo 10 rodadas.

- A experiência desejada é de aproximadamente 10 minutos por partida.

O tempo de 10 minutos é uma meta de experiência, não um cronômetro obrigatório.

### 2.2. Iniciativa

- A iniciativa inicial é definida aleatoriamente.

- A iniciativa alterna entre os jogadores a cada rodada.

- Ambos os jogadores realizam um turno por rodada.

### 2.3. Estrutura da rodada

Cada rodada segue esta sequência:

1. O jogador com iniciativa inicia seu turno.

2. O segundo jogador realiza seu turno.

3. O sistema verifica pontuação, vantagens, estabilização e condições de encerramento.

4. A iniciativa é alternada para a próxima rodada.

### 2.4. Estrutura do turno

No início do próprio turno, o jogador:

1. Recupera energia.

2. Compra uma carta.

3. Atualiza efeitos temporários.

Durante o turno, pode executar até duas ações principais.

Reações realizadas durante o turno adversário não consomem ações principais do jogador defensor.

## 3. Sistema de energia

### 3.1. Escala

- Energia inicial: 10.

- Energia máxima: 10.

- Energia mínima: 0.

- Recuperação automática: +2 no início do próprio turno.

Esses valores são parâmetros provisórios de balanceamento.

### 3.2. Custos iniciais de energia

| Ação | Custo |
|---|---:|
| Ajuste posicional | 1 |
| Defesa simples | 1 |
| Raspagem | 2 |
| Passagem de guarda | 3 |
| Ataque de finalização | 3 |
| Defesa de finalização | 2 |
| Escape da montada | 3 |
| Escape do cem quilos | 3 |
| Escape das costas | 4 |
| Recuperação de energia | +2 |

Os custos deverão ser associados às respectivas cartas ou ações e poderão ser ajustados após os playtests.

### 3.3. Regras de consumo

- A energia é validada antes da execução da ação.

- O custo é pago antes da abertura da janela de reação.

- O custo permanece consumido mesmo quando o adversário consegue defender a ação.

- Cartas defensivas também podem consumir energia.

- Cartas incompatíveis ou ações inválidas não consomem energia.

### 3.4. Energia zero

Quando o atleta chega a zero:

- Não pode executar ações que exigem energia.

- Continua podendo utilizar defesa passiva.

- Não recebe penalidade automática nos atributos.

- Recupera energia normalmente no início do próximo turno.

### 3.5. Ação de recuperação

O jogador pode utilizar uma ação principal para recuperar +2 de energia.

Essa ação:

- Consome uma das duas ações principais do turno.

- Não altera posição nem pontuação.

- Não abre uma janela de reação ofensiva.

- Não impede que o adversário execute ações em seu próprio turno.

## 4. Sistema de controle

### 4.1. Controle permanente

Cada atleta possui o atributo permanente `Controle`, com escala de 1 a 5.

Esse atributo não muda durante a partida.

### 4.2. Controle situacional

Cada jogador possui um nível independente de controle situacional, com escala de 0 a 5.

| Nível | Classificação |
|---:|---|
| 0 | Sem controle |
| 1 | Controle fraco |
| 2 | Controle moderado |
| 3 | Controle consistente |
| 4 | Controle forte |
| 5 | Controle dominante |

### 4.3. Aplicação

O controle situacional influencia:

- Estabilização de posições.

- Validação de pontuação.

- Dificuldade de progressão e defesa.

- Requisitos de determinadas cartas de finalização.

O controle situacional não permite executar técnicas incompatíveis com a posição atual.

### 4.4. Alterações de controle

Valores iniciais propostos:

| Evento | Alteração |
|---|---:|
| Estabelecer posição favorável | +1 |
| Executar progressão posicional válida | +1 |
| Consolidar controle após defesa | +1 |
| Manter domínio em sequência válida | +1 |
| Escape bem-sucedido | -2 |
| Perder posição dominante | -2 |
| Reversão do adversário | -2 |
| Falhar em manter controle | -1 |

O valor permanece limitado entre 0 e 5.

Esses modificadores são provisórios e dependem de validação.

## 5. Posições e transições

### 5.1. Catálogo inicial de posições

O MVP utilizará as seguintes posições:

1. Guarda fechada.

2. Guarda aberta.

3. Meia-guarda.

4. Cem quilos.

5. Joelho na barriga.

6. Montada.

7. Controle das costas.

8. Em pé.

9. Tartaruga.

10. Emaranhamento de pernas.

### 5.2. Regras de transição

- Toda transição precisa ter uma posição de origem e uma posição de destino.

- A carta ou ação deve ser compatível com a posição atual.

- A transição depende da resolução do combate e da reação do adversário.

- Não existem mudanças posicionais automáticas sem uma ação válida.

Exemplos:

| Origem | Ação | Destino |
|---|---|---|
| Em pé | Queda | Guarda ou cem quilos |
| Guarda fechada | Passagem | Cem quilos |
| Guarda aberta | Raspagem | Posição superior válida |
| Meia-guarda | Passagem | Cem quilos |
| Cem quilos | Progressão | Montada |
| Cem quilos | Pegada de costas | Controle das costas |
| Montada | Transição | Controle das costas |
| Controle das costas | Escape | Posição defensiva válida |

### 5.3. Restrições

A posição determina quais técnicas podem ser executadas.

Exemplos:

- Passagem de guarda exige que o adversário esteja em uma posição de guarda compatível.

- Raspagem exige uma posição de guarda e condições válidas de reversão.

- Mata-leão exige controle das costas.

- Armbar exige uma posição compatível com a técnica.

O catálogo de compatibilidade deverá ser refinado durante a implementação e os playtests.

## 6. Combate, ações e reações

### 6.1. Tipos de ação

O sistema contempla:

- Ataque posicional.

- Progressão posicional.

- Ataque de finalização.

- Defesa.

- Escape.

- Contra-ataque.

- Recuperação de energia.

### 6.2. Resolução de uma ação ofensiva

A resolução segue esta sequência:

1. O atacante declara a ação.

2. O sistema valida posição, atributos e energia.

3. O custo de energia é pago.

4. O sistema abre uma janela de reação, quando prevista para aquela ação.

5. O defensor utiliza uma carta de reação compatível ou defesa passiva.

6. O sistema calcula os resultados.

7. A posição, o controle, a energia e a pontuação são atualizados.

### 6.3. Fórmula de resolução

`Resultado = Atributo aplicável + Bônus da carta + Modificadores`

Em caso de empate, a defesa vence.

### 6.4. Cartas de bloqueio

- Bloqueiam uma técnica específica.

- Precisam corresponder exatamente à técnica utilizada.

- Não podem ser utilizadas contra técnicas incompatíveis.

- Uma carta incompatível não é consumida.

### 6.5. Defesa passiva

A defesa passiva está sempre disponível, inclusive quando o atleta possui zero de energia.

A defesa passiva utiliza os atributos aplicáveis e os modificadores da situação.

### 6.6. Contra-ataques

- Exigem uma carta específica de contra-ataque.

- Dependem de uma defesa bem-sucedida ou de uma condição descrita na carta.

- Resolvem defesa e contra-ataque como uma única reação composta.

- Não abrem uma segunda janela de reação.

### 6.7. Limites de reação

- Cada ação ofensiva abre no máximo uma janela de reação.

- Não existe reação a uma reação.

- A defesa bem-sucedida não altera automaticamente a posição.

- A carta ou ação define os efeitos posicionais da resolução.

## 7. Sistema de finalizações

### 7.1. Etapas obrigatórias

Toda finalização possui três etapas:

1. Preparação.

2. Ataque.

3. Conclusão.

Cada etapa:

- É executada como uma ação.

- Consome a energia definida pela carta.

- Abre uma janela de reação para o adversário.

Somente uma etapa pode ser executada por ação principal.

### 7.2. Catálogo inicial

| Finalização | Posição compatível | Requisitos iniciais |
|---|---|---|
| Armbar | Guarda fechada ou montada | Técnica 3 |
| Triângulo | Guarda fechada | Técnica 4 |
| Kimura | Guarda ou cem quilos | Técnica 3 e Força 2 |
| Mata-leão | Controle das costas | Técnica 3 e Controle 3 |
| Americana | Cem quilos ou montada | Técnica 2 e Força 3 |
| Chave de pé reta | Guarda ou emaranhamento de pernas compatível | Técnica 4 |

Os requisitos são valores iniciais sujeitos a validação técnica e balanceamento.

### 7.3. Progressão

- O progresso fica associado à finalização iniciada.

- O jogador não pode trocar de técnica durante a sequência sem reiniciar a preparação.

- Cada etapa exige uma nova ação.

- O defensor pode impedir a progressão utilizando uma reação válida.

- Uma defesa bem-sucedida impede o avanço da etapa, mas não cancela automaticamente as etapas anteriores.

- O atacante poderá tentar avançar novamente em um turno posterior.

- Um escape bem-sucedido altera a posição e cancela a sequência de finalização.

### 7.4. Vitória por finalização

Uma finalização concluída com sucesso encerra imediatamente a partida.

## 8. Pontuação, estabilização e vantagens

### 8.1. Pontuação

| Evento | Pontos |
|---|---:|
| Queda | 2 |
| Raspagem | 2 |
| Joelho na barriga | 2 |
| Passagem de guarda | 3 |
| Montada | 4 |
| Controle das costas | 4 |
| Finalização confirmada | Vitória imediata |

### 8.2. Estabilização

A pontuação depende da confirmação da estabilização da posição.

A estabilização é baseada em eventos, não em tempo real.

Para validar a estabilização:

1. A transição precisa ser executada com sucesso.

2. O atleta deve alcançar o destino definido pela carta.

3. O adversário deve ter tido oportunidade de reação.

4. A posição deve permanecer válida após a resolução da reação.

Somente após essas condições os pontos são atribuídos.

### 8.3. Repetição de pontuação

- Não há pontuação repetida enquanto o atleta mantém o controle da posição.

- Se perder a posição e posteriormente recuperá-la por uma nova ação válida, poderá pontuar novamente após nova estabilização.

### 8.4. Vantagens

Uma vantagem pode ser concedida por uma oportunidade ofensiva relevante que não resulte em pontuação ou finalização.

Exemplos:

- Tentativa válida de raspagem sem conclusão.

- Progressão significativa em passagem de guarda sem conclusão.

- Ameaça real de finalização defendida pelo adversário.

Não são concedidas vantagens por tentativas sem progresso significativo.

### 8.5. Limite

Cada sequência ofensiva concede no máximo uma vantagem.

Os critérios objetivos para classificar uma ameaça como relevante deverão ser detalhados no catálogo de cartas e validados por playtests.

## 9. Gerenciamento de deck e cartas

### 9.1. Composição

Cada jogador utiliza um deck de exatamente 40 cartas.

| Categoria | Quantidade |
|---|---:|
| Ataque | 10 |
| Defesa (bloqueios) | 10 |
| Escape | 5 |
| Contra-ataque | 5 |
| Finalização | 6 |
| Estratégia e recuperação | 4 |
| **Total** | **40** |

### 9.2. Limite de cópias

- Máximo de duas cópias da mesma carta.

- As cartas precisam atender aos requisitos do atleta selecionado.

### 9.3. Carta de atleta

- A carta de atleta é separada do deck.

- Permanece ativa durante toda a partida.

- Não entra na mão, no descarte ou no baralho de compra.

### 9.4. Preparação

No início da partida:

1. O deck é embaralhado.

2. Cada jogador compra cinco cartas.

3. O restante forma o baralho de compra.

### 9.5. Compra de cartas

- Cada jogador compra uma carta no início do próprio turno.

- O limite máximo da mão é de sete cartas.

- Se a mão já estiver com sete cartas, o jogador escolhe uma para descartar antes de comprar a próxima.

### 9.6. Descarte

- Cartas utilizadas vão para a pilha de descarte após a resolução.

- Cartas de reação utilizadas no turno adversário também são descartadas após a resolução.

- Cartas inválidas ou incompatíveis não são consumidas.

### 9.7. Baralho vazio

Quando o baralho de compra terminar:

- Não haverá novas compras.

- A pilha de descarte não será embaralhada novamente.

- O jogador continuará utilizando as cartas restantes na mão.

- A partida continuará normalmente.

- Não haverá penalidade automática por esgotamento do baralho no MVP.

## 10. Encerramento e condições de vitória

### 10.1. Vitória por finalização

A conclusão bem-sucedida de uma finalização encerra imediatamente a partida.

### 10.2. Limite de rodadas

- A partida possui no máximo dez rodadas.

- Após os dois turnos da décima rodada, o sistema encerra a partida.

- Não existe prorrogação ou Golden Score.

### 10.3. Critérios de desempate

Ao término da décima rodada, o resultado é definido nesta ordem:

1. Maior pontuação.

2. Maior número de vantagens.

3. Persistindo a igualdade, empate.

### 10.4. Desistência

A desistência voluntária representa derrota para o jogador que desistiu e vitória para o adversário.

### 10.5. Interrupções

- Interrupções recuperáveis permitem retomar a partida a partir do último estado salvo.

- Interrupções irrecuperáveis registram a partida como interrompida.

- Uma partida interrompida por falha técnica não atribui vitória ou derrota automaticamente.

## 11. Estado da partida e requisitos para implementação

O motor de regras deverá manter, no mínimo, as seguintes informações:

### 11.1. Estado dos jogadores

- Identificação do atleta.

- Atributos permanentes.

- Energia atual.

- Controle situacional.

- Pontuação.

- Vantagens.

- Mão de cartas.

- Baralho de compra.

- Pilha de descarte.

### 11.2. Estado do combate

- Rodada atual.

- Jogador ativo.

- Iniciativa.

- Posição atual.

- Identificação de quem está por cima e por baixo.

- Histórico de posições pontuadas.

- Estado de estabilização.

- Estado da sequência de finalização.

- Janela de reação.

- Efeitos temporários ativos.

### 11.3. Requisitos do motor de regras

O motor deverá:

- Validar ações antes de executá-las.

- Verificar compatibilidade entre posição, carta e atributos.

- Controlar consumo e recuperação de energia.

- Gerenciar janelas de reação.

- Resolver ataques, defesas e contra-ataques.

- Atualizar posições e controle.

- Validar estabilização e pontuação.

- Gerenciar finalizações.

- Controlar compra, uso e descarte de cartas.

- Determinar condições de vitória, empate e interrupção.

As regras devem ser implementadas de forma independente da interface gráfica, permitindo testes automatizados e evolução futura do jogo.

## 12. Parâmetros pendentes de balanceamento

Os seguintes parâmetros precisam de validação durante os playtests:

| Parâmetro | Situação |
|---|---|
| Recuperação automática de energia (+2) | Provisório |
| Custos individuais das ações | Provisórios |
| Modificadores de controle situacional | Provisórios |
| Bônus e modificadores das cartas | Pendente |
| Compatibilidade técnica das posições | Pendente de validação |
| Requisitos de atributos das finalizações | Provisórios |
| Critérios objetivos para concessão de vantagens | Pendente |
| Equilíbrio entre arquétipos | Pendente |
| Distribuição e poder das cartas | Pendente |

As regras estruturais definidas neste documento servem como base funcional para a implementação do MVP. Os parâmetros de balanceamento poderão ser ajustados sem alterar a estrutura fundamental do jogo.

---

****ROLL TCG — Game Rules Specification v1.0****

Documento-base para implementação do motor de regras e execução dos primeiros playtests.
