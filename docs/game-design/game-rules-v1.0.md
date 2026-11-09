# ROLL TCG Ã¢â‚¬â€ EspecificaÃƒÂ§ÃƒÂ£o das Regras do Jogo

**VersÃƒÂ£o:** 1.0
**Status:** EspecificaÃƒÂ§ÃƒÂ£o inicial para implementaÃƒÂ§ÃƒÂ£o do MVP
**Documento relacionado:** `docs/game-design/gdd-v0.1.md`
**Issue:** #5 Ã¢â‚¬â€ Game Rules Specification

---

## 1. Objetivo e escopo

Este documento formaliza as regras funcionais do ROLL TCG, estabelecendo os critÃƒÂ©rios necessÃƒÂ¡rios para implementar o motor de regras do jogo.

O jogo ÃƒÂ© um Trading Card Game estratÃƒÂ©gico inspirado no Jiu-Jitsu brasileiro, no qual dois jogadores controlam atletas e utilizam cartas para executar ataques, defesas, transiÃƒÂ§ÃƒÂµes posicionais, escapes e finalizaÃƒÂ§ÃƒÂµes.

A especificaÃƒÂ§ÃƒÂ£o contempla:

- Estrutura de partidas, rodadas e turnos.
- Atributos, energia e controle.
- PosiÃƒÂ§ÃƒÂµes e transiÃƒÂ§ÃƒÂµes.
- AÃƒÂ§ÃƒÂµes, combate e reaÃƒÂ§ÃƒÂµes.
- FinalizaÃƒÂ§ÃƒÂµes.
- PontuaÃƒÂ§ÃƒÂ£o e vantagens.
- Gerenciamento de cartas e deck.
- CondiÃƒÂ§ÃƒÂµes de vitÃƒÂ³ria e encerramento.

Os valores numÃƒÂ©ricos identificados como provisÃƒÂ³rios deverÃƒÂ£o ser validados por meio de playtests e ajustes de balanceamento.

## 2. Estrutura da partida

### 2.1. ConfiguraÃƒÂ§ÃƒÂ£o

- Dois jogadores participam da partida.
- Cada jogador controla um atleta.
- Cada atleta possui atributos prÃƒÂ³prios e um deck de 40 cartas.
- A partida possui no mÃƒÂ¡ximo 10 rodadas.
- A experiÃƒÂªncia desejada ÃƒÂ© de aproximadamente 10 minutos por partida.

O tempo de 10 minutos ÃƒÂ© uma meta de experiÃƒÂªncia, nÃƒÂ£o um cronÃƒÂ´metro obrigatÃƒÂ³rio.

### 2.2. Iniciativa

- A iniciativa inicial ÃƒÂ© definida aleatoriamente.
- A iniciativa alterna entre os jogadores a cada rodada.
- Ambos os jogadores realizam um turno por rodada.

### 2.3. Estrutura da rodada

Cada rodada segue esta sequÃƒÂªncia:

1. O jogador com iniciativa inicia seu turno.
2. O segundo jogador realiza seu turno.
3. O sistema verifica pontuaÃƒÂ§ÃƒÂ£o, vantagens, estabilizaÃƒÂ§ÃƒÂ£o e condiÃƒÂ§ÃƒÂµes de encerramento.
4. A iniciativa ÃƒÂ© alternada para a prÃƒÂ³xima rodada.

### 2.4. Estrutura do turno

No inÃƒÂ­cio do prÃƒÂ³prio turno, o jogador:

1. Recupera energia.
2. Compra uma carta.
3. Atualiza efeitos temporÃƒÂ¡rios.

Durante o turno, pode executar atÃƒÂ© duas aÃƒÂ§ÃƒÂµes principais.

ReaÃƒÂ§ÃƒÂµes realizadas durante o turno adversÃƒÂ¡rio nÃƒÂ£o consomem aÃƒÂ§ÃƒÂµes principais do jogador defensor.

## 3. Sistema de energia

### 3.1. Escala

- Energia inicial: 10.
- Energia mÃƒÂ¡xima: 10.
- Energia mÃƒÂ­nima: 0.
- RecuperaÃƒÂ§ÃƒÂ£o automÃƒÂ¡tica: +2 no inÃƒÂ­cio do prÃƒÂ³prio turno.

Esses valores sÃƒÂ£o parÃƒÂ¢metros provisÃƒÂ³rios de balanceamento.

### 3.2. Custos iniciais de energia

| AÃƒÂ§ÃƒÂ£o | Custo |
|---|---:|
| Ajuste posicional | 1 |
| Defesa simples | 1 |
| Raspagem | 2 |
| Passagem de guarda | 3 |
| Ataque de finalizaÃƒÂ§ÃƒÂ£o | 3 |
| Defesa de finalizaÃƒÂ§ÃƒÂ£o | 2 |
| Escape da montada | 3 |
| Escape do cem quilos | 3 |
| Escape das costas | 4 |
| RecuperaÃƒÂ§ÃƒÂ£o de energia | +2 |

Os custos deverÃƒÂ£o ser associados ÃƒÂ s respectivas cartas ou aÃƒÂ§ÃƒÂµes e poderÃƒÂ£o ser ajustados apÃƒÂ³s os playtests.

### 3.3. Regras de consumo

- A energia ÃƒÂ© validada antes da execuÃƒÂ§ÃƒÂ£o da aÃƒÂ§ÃƒÂ£o.
- O custo ÃƒÂ© pago antes da abertura da janela de reaÃƒÂ§ÃƒÂ£o.
- O custo permanece consumido mesmo quando o adversÃƒÂ¡rio consegue defender a aÃƒÂ§ÃƒÂ£o.
- Cartas defensivas tambÃƒÂ©m podem consumir energia.
- Cartas incompatÃƒÂ­veis ou aÃƒÂ§ÃƒÂµes invÃƒÂ¡lidas nÃƒÂ£o consomem energia.

### 3.4. Energia zero

Quando o atleta chega a zero:

- NÃƒÂ£o pode executar aÃƒÂ§ÃƒÂµes que exigem energia.
- Continua podendo utilizar defesa passiva.
- NÃƒÂ£o recebe penalidade automÃƒÂ¡tica nos atributos.
- Recupera energia normalmente no inÃƒÂ­cio do prÃƒÂ³ximo turno.

### 3.5. AÃƒÂ§ÃƒÂ£o de recuperaÃƒÂ§ÃƒÂ£o

O jogador pode utilizar uma aÃƒÂ§ÃƒÂ£o principal para recuperar +2 de energia.

Essa aÃƒÂ§ÃƒÂ£o:

- Consome uma das duas aÃƒÂ§ÃƒÂµes principais do turno.
- NÃƒÂ£o altera posiÃƒÂ§ÃƒÂ£o nem pontuaÃƒÂ§ÃƒÂ£o.
- NÃƒÂ£o abre uma janela de reaÃƒÂ§ÃƒÂ£o ofensiva.
- NÃƒÂ£o impede que o adversÃƒÂ¡rio execute aÃƒÂ§ÃƒÂµes em seu prÃƒÂ³prio turno.

## 4. Sistema de controle

### 4.1. Controle permanente

Cada atleta possui o atributo permanente `Controle`, com escala de 1 a 5.

Esse atributo nÃƒÂ£o muda durante a partida.

### 4.2. Controle situacional

Cada jogador possui um nÃƒÂ­vel independente de controle situacional, com escala de 0 a 5.

| NÃƒÂ­vel | ClassificaÃƒÂ§ÃƒÂ£o |
|---:|---|
| 0 | Sem controle |
| 1 | Controle fraco |
| 2 | Controle moderado |
| 3 | Controle consistente |
| 4 | Controle forte |
| 5 | Controle dominante |

### 4.3. AplicaÃƒÂ§ÃƒÂ£o

O controle situacional influencia:

- EstabilizaÃƒÂ§ÃƒÂ£o de posiÃƒÂ§ÃƒÂµes.
- ValidaÃƒÂ§ÃƒÂ£o de pontuaÃƒÂ§ÃƒÂ£o.
- Dificuldade de progressÃƒÂ£o e defesa.
- Requisitos de determinadas cartas de finalizaÃƒÂ§ÃƒÂ£o.

O controle situacional nÃƒÂ£o permite executar tÃƒÂ©cnicas incompatÃƒÂ­veis com a posiÃƒÂ§ÃƒÂ£o atual.

### 4.4. AlteraÃƒÂ§ÃƒÂµes de controle

Valores iniciais propostos:

| Evento | AlteraÃƒÂ§ÃƒÂ£o |
|---|---:|
| Estabelecer posiÃƒÂ§ÃƒÂ£o favorÃƒÂ¡vel | +1 |
| Executar progressÃƒÂ£o posicional vÃƒÂ¡lida | +1 |
| Consolidar controle apÃƒÂ³s defesa | +1 |
| Manter domÃƒÂ­nio em sequÃƒÂªncia vÃƒÂ¡lida | +1 |
| Escape bem-sucedido | -2 |
| Perder posiÃƒÂ§ÃƒÂ£o dominante | -2 |
| ReversÃƒÂ£o do adversÃƒÂ¡rio | -2 |
| Falhar em manter controle | -1 |

O valor permanece limitado entre 0 e 5.

Esses modificadores sÃƒÂ£o provisÃƒÂ³rios e dependem de validaÃƒÂ§ÃƒÂ£o.

## 5. PosiÃƒÂ§ÃƒÂµes e transiÃƒÂ§ÃƒÂµes

### 5.1. CatÃƒÂ¡logo inicial de posiÃƒÂ§ÃƒÂµes

O MVP utilizarÃƒÂ¡ as seguintes posiÃƒÂ§ÃƒÂµes:

1. Guarda fechada.
2. Guarda aberta.
3. Meia-guarda.
4. Cem quilos.
5. Joelho na barriga.
6. Montada.
7. Controle das costas.
8. Em pÃƒÂ©.
9. Tartaruga.
10. Emaranhamento de pernas.

### 5.2. Regras de transiÃƒÂ§ÃƒÂ£o

- Toda transiÃƒÂ§ÃƒÂ£o precisa ter uma posiÃƒÂ§ÃƒÂ£o de origem e uma posiÃƒÂ§ÃƒÂ£o de destino.
- A carta ou aÃƒÂ§ÃƒÂ£o deve ser compatÃƒÂ­vel com a posiÃƒÂ§ÃƒÂ£o atual.
- A transiÃƒÂ§ÃƒÂ£o depende da resoluÃƒÂ§ÃƒÂ£o do combate e da reaÃƒÂ§ÃƒÂ£o do adversÃƒÂ¡rio.
- NÃƒÂ£o existem mudanÃƒÂ§as posicionais automÃƒÂ¡ticas sem uma aÃƒÂ§ÃƒÂ£o vÃƒÂ¡lida.

Exemplos:

| Origem | AÃƒÂ§ÃƒÂ£o | Destino |
|---|---|---|
| Em pÃƒÂ© | Queda | Guarda ou cem quilos |
| Guarda fechada | Passagem | Cem quilos |
| Guarda aberta | Raspagem | PosiÃƒÂ§ÃƒÂ£o superior vÃƒÂ¡lida |
| Meia-guarda | Passagem | Cem quilos |
| Cem quilos | ProgressÃƒÂ£o | Montada |
| Cem quilos | Pegada de costas | Controle das costas |
| Montada | TransiÃƒÂ§ÃƒÂ£o | Controle das costas |
| Controle das costas | Escape | PosiÃƒÂ§ÃƒÂ£o defensiva vÃƒÂ¡lida |

### 5.3. RestriÃƒÂ§ÃƒÂµes

A posiÃƒÂ§ÃƒÂ£o determina quais tÃƒÂ©cnicas podem ser executadas.

Exemplos:

- Passagem de guarda exige que o adversÃƒÂ¡rio esteja em uma posiÃƒÂ§ÃƒÂ£o de guarda compatÃƒÂ­vel.
- Raspagem exige uma posiÃƒÂ§ÃƒÂ£o de guarda e condiÃƒÂ§ÃƒÂµes vÃƒÂ¡lidas de reversÃƒÂ£o.
- Mata-leÃƒÂ£o exige controle das costas.
- Armbar exige uma posiÃƒÂ§ÃƒÂ£o compatÃƒÂ­vel com a tÃƒÂ©cnica.

O catÃƒÂ¡logo de compatibilidade deverÃƒÂ¡ ser refinado durante a implementaÃƒÂ§ÃƒÂ£o e os playtests.

## 6. Combate, aÃƒÂ§ÃƒÂµes e reaÃƒÂ§ÃƒÂµes

### 6.1. Tipos de aÃƒÂ§ÃƒÂ£o

O sistema contempla:

- Ataque posicional.
- ProgressÃƒÂ£o posicional.
- Ataque de finalizaÃƒÂ§ÃƒÂ£o.
- Defesa.
- Escape.
- Contra-ataque.
- RecuperaÃƒÂ§ÃƒÂ£o de energia.

### 6.2. ResoluÃƒÂ§ÃƒÂ£o de uma aÃƒÂ§ÃƒÂ£o ofensiva

A resoluÃƒÂ§ÃƒÂ£o segue esta sequÃƒÂªncia:

1. O atacante declara a aÃƒÂ§ÃƒÂ£o.
2. O sistema valida posiÃƒÂ§ÃƒÂ£o, atributos e energia.
3. O custo de energia ÃƒÂ© pago.
4. O sistema abre uma janela de reaÃƒÂ§ÃƒÂ£o, quando prevista para aquela aÃƒÂ§ÃƒÂ£o.
5. O defensor utiliza uma carta de reaÃƒÂ§ÃƒÂ£o compatÃƒÂ­vel ou defesa passiva.
6. O sistema calcula os resultados.
7. A posiÃƒÂ§ÃƒÂ£o, o controle, a energia e a pontuaÃƒÂ§ÃƒÂ£o sÃƒÂ£o atualizados.

### 6.3. FÃƒÂ³rmula de resoluÃƒÂ§ÃƒÂ£o

`Resultado = Atributo aplicÃƒÂ¡vel + BÃƒÂ´nus da carta + Modificadores`

Em caso de empate, a defesa vence.

### 6.4. Cartas de bloqueio

- Bloqueiam uma tÃƒÂ©cnica especÃƒÂ­fica.
- Precisam corresponder exatamente ÃƒÂ  tÃƒÂ©cnica utilizada.
- NÃƒÂ£o podem ser utilizadas contra tÃƒÂ©cnicas incompatÃƒÂ­veis.
- Uma carta incompatÃƒÂ­vel nÃƒÂ£o ÃƒÂ© consumida.

### 6.5. Defesa passiva

A defesa passiva estÃƒÂ¡ sempre disponÃƒÂ­vel, inclusive quando o atleta possui zero de energia.

A defesa passiva utiliza os atributos aplicÃƒÂ¡veis e os modificadores da situaÃƒÂ§ÃƒÂ£o.

### 6.6. Contra-ataques

- Exigem uma carta especÃƒÂ­fica de contra-ataque.
- Dependem de uma defesa bem-sucedida ou de uma condiÃƒÂ§ÃƒÂ£o descrita na carta.
- Resolvem defesa e contra-ataque como uma ÃƒÂºnica reaÃƒÂ§ÃƒÂ£o composta.
- NÃƒÂ£o abrem uma segunda janela de reaÃƒÂ§ÃƒÂ£o.

### 6.7. Limites de reaÃƒÂ§ÃƒÂ£o

- Cada aÃƒÂ§ÃƒÂ£o ofensiva abre no mÃƒÂ¡ximo uma janela de reaÃƒÂ§ÃƒÂ£o.
- NÃƒÂ£o existe reaÃƒÂ§ÃƒÂ£o a uma reaÃƒÂ§ÃƒÂ£o.
- A defesa bem-sucedida nÃƒÂ£o altera automaticamente a posiÃƒÂ§ÃƒÂ£o.
- A carta ou aÃƒÂ§ÃƒÂ£o define os efeitos posicionais da resoluÃƒÂ§ÃƒÂ£o.

## 7. Sistema de finalizaÃƒÂ§ÃƒÂµes

### 7.1. Etapas obrigatÃƒÂ³rias

Toda finalizaÃƒÂ§ÃƒÂ£o possui trÃƒÂªs etapas:

1. PreparaÃƒÂ§ÃƒÂ£o.
2. Ataque.
3. ConclusÃƒÂ£o.

Cada etapa:

- Ãƒâ€° executada como uma aÃƒÂ§ÃƒÂ£o.
- Consome a energia definida pela carta.
- Abre uma janela de reaÃƒÂ§ÃƒÂ£o para o adversÃƒÂ¡rio.

Somente uma etapa pode ser executada por aÃƒÂ§ÃƒÂ£o principal.

### 7.2. CatÃƒÂ¡logo inicial

| FinalizaÃƒÂ§ÃƒÂ£o | PosiÃƒÂ§ÃƒÂ£o compatÃƒÂ­vel | Requisitos iniciais |
|---|---|---|
| Armbar | Guarda fechada ou montada | TÃƒÂ©cnica 3 |
| TriÃƒÂ¢ngulo | Guarda fechada | TÃƒÂ©cnica 4 |
| Kimura | Guarda ou cem quilos | TÃƒÂ©cnica 3 e ForÃƒÂ§a 2 |
| Mata-leÃƒÂ£o | Controle das costas | TÃƒÂ©cnica 3 e Controle 3 |
| Americana | Cem quilos ou montada | TÃƒÂ©cnica 2 e ForÃƒÂ§a 3 |
| Chave de pÃƒÂ© reta | Guarda ou emaranhamento de pernas compatÃƒÂ­vel | TÃƒÂ©cnica 4 |

Os requisitos sÃƒÂ£o valores iniciais sujeitos a validaÃƒÂ§ÃƒÂ£o tÃƒÂ©cnica e balanceamento.

### 7.3. ProgressÃƒÂ£o

- O progresso fica associado ÃƒÂ  finalizaÃƒÂ§ÃƒÂ£o iniciada.
- O jogador nÃƒÂ£o pode trocar de tÃƒÂ©cnica durante a sequÃƒÂªncia sem reiniciar a preparaÃƒÂ§ÃƒÂ£o.
- Cada etapa exige uma nova aÃƒÂ§ÃƒÂ£o.
- O defensor pode impedir a progressÃƒÂ£o utilizando uma reaÃƒÂ§ÃƒÂ£o vÃƒÂ¡lida.
- Uma defesa bem-sucedida impede o avanÃƒÂ§o da etapa, mas nÃƒÂ£o cancela automaticamente as etapas anteriores.
- O atacante poderÃƒÂ¡ tentar avanÃƒÂ§ar novamente em um turno posterior.
- Um escape bem-sucedido altera a posiÃƒÂ§ÃƒÂ£o e cancela a sequÃƒÂªncia de finalizaÃƒÂ§ÃƒÂ£o.

### 7.4. VitÃƒÂ³ria por finalizaÃƒÂ§ÃƒÂ£o

Uma finalizaÃƒÂ§ÃƒÂ£o concluÃƒÂ­da com sucesso encerra imediatamente a partida.

## 8. PontuaÃƒÂ§ÃƒÂ£o, estabilizaÃƒÂ§ÃƒÂ£o e vantagens

### 8.1. PontuaÃƒÂ§ÃƒÂ£o

| Evento | Pontos |
|---|---:|
| Queda | 2 |
| Raspagem | 2 |
| Joelho na barriga | 2 |
| Passagem de guarda | 3 |
| Montada | 4 |
| Controle das costas | 4 |
| FinalizaÃƒÂ§ÃƒÂ£o confirmada | VitÃƒÂ³ria imediata |

### 8.2. EstabilizaÃƒÂ§ÃƒÂ£o

A pontuaÃƒÂ§ÃƒÂ£o depende da confirmaÃƒÂ§ÃƒÂ£o da estabilizaÃƒÂ§ÃƒÂ£o da posiÃƒÂ§ÃƒÂ£o.

A estabilizaÃƒÂ§ÃƒÂ£o ÃƒÂ© baseada em eventos, nÃƒÂ£o em tempo real.

Para validar a estabilizaÃƒÂ§ÃƒÂ£o:

1. A transiÃƒÂ§ÃƒÂ£o precisa ser executada com sucesso.
2. O atleta deve alcanÃƒÂ§ar o destino definido pela carta.
3. O adversÃƒÂ¡rio deve ter tido oportunidade de reaÃƒÂ§ÃƒÂ£o.
4. A posiÃƒÂ§ÃƒÂ£o deve permanecer vÃƒÂ¡lida apÃƒÂ³s a resoluÃƒÂ§ÃƒÂ£o da reaÃƒÂ§ÃƒÂ£o.

Somente apÃƒÂ³s essas condiÃƒÂ§ÃƒÂµes os pontos sÃƒÂ£o atribuÃƒÂ­dos.

### 8.3. RepetiÃƒÂ§ÃƒÂ£o de pontuaÃƒÂ§ÃƒÂ£o

- NÃƒÂ£o hÃƒÂ¡ pontuaÃƒÂ§ÃƒÂ£o repetida enquanto o atleta mantÃƒÂ©m o controle da posiÃƒÂ§ÃƒÂ£o.
- Se perder a posiÃƒÂ§ÃƒÂ£o e posteriormente recuperÃƒÂ¡-la por uma nova aÃƒÂ§ÃƒÂ£o vÃƒÂ¡lida, poderÃƒÂ¡ pontuar novamente apÃƒÂ³s nova estabilizaÃƒÂ§ÃƒÂ£o.

### 8.4. Vantagens

Uma vantagem pode ser concedida por uma oportunidade ofensiva relevante que nÃƒÂ£o resulte em pontuaÃƒÂ§ÃƒÂ£o ou finalizaÃƒÂ§ÃƒÂ£o.

Exemplos:

- Tentativa vÃƒÂ¡lida de raspagem sem conclusÃƒÂ£o.
- ProgressÃƒÂ£o significativa em passagem de guarda sem conclusÃƒÂ£o.
- AmeaÃƒÂ§a real de finalizaÃƒÂ§ÃƒÂ£o defendida pelo adversÃƒÂ¡rio.

NÃƒÂ£o sÃƒÂ£o concedidas vantagens por tentativas sem progresso significativo.

### 8.5. Limite

Cada sequÃƒÂªncia ofensiva concede no mÃƒÂ¡ximo uma vantagem.

Os critÃƒÂ©rios objetivos para classificar uma ameaÃƒÂ§a como relevante deverÃƒÂ£o ser detalhados no catÃƒÂ¡logo de cartas e validados por playtests.

## 9. Gerenciamento de deck e cartas

### 9.1. ComposiÃƒÂ§ÃƒÂ£o

Cada jogador utiliza um deck de exatamente 40 cartas.

| Categoria | Quantidade |
|---|---:|
| Ataque | 10 |
| Defesa (bloqueios) | 10 |
| Escape | 5 |
| Contra-ataque | 5 |
| FinalizaÃƒÂ§ÃƒÂ£o | 6 |
| EstratÃƒÂ©gia e recuperaÃƒÂ§ÃƒÂ£o | 4 |
| **Total** | **40** |

### 9.2. Limite de cÃƒÂ³pias

- MÃƒÂ¡ximo de duas cÃƒÂ³pias da mesma carta.
- As cartas precisam atender aos requisitos do atleta selecionado.

### 9.3. Carta de atleta

- A carta de atleta ÃƒÂ© separada do deck.
- Permanece ativa durante toda a partida.
- NÃƒÂ£o entra na mÃƒÂ£o, no descarte ou no baralho de compra.

### 9.4. PreparaÃƒÂ§ÃƒÂ£o

No inÃƒÂ­cio da partida:

1. O deck ÃƒÂ© embaralhado.
2. Cada jogador compra cinco cartas.
3. O restante forma o baralho de compra.

### 9.5. Compra de cartas

- Cada jogador compra uma carta no inÃƒÂ­cio do prÃƒÂ³prio turno.
- O limite mÃƒÂ¡ximo da mÃƒÂ£o ÃƒÂ© de sete cartas.
- Se a mÃƒÂ£o jÃƒÂ¡ estiver com sete cartas, o jogador escolhe uma para descartar antes de comprar a prÃƒÂ³xima.

### 9.6. Descarte

- Cartas utilizadas vÃƒÂ£o para a pilha de descarte apÃƒÂ³s a resoluÃƒÂ§ÃƒÂ£o.
- Cartas de reaÃƒÂ§ÃƒÂ£o utilizadas no turno adversÃƒÂ¡rio tambÃƒÂ©m sÃƒÂ£o descartadas apÃƒÂ³s a resoluÃƒÂ§ÃƒÂ£o.
- Cartas invÃƒÂ¡lidas ou incompatÃƒÂ­veis nÃƒÂ£o sÃƒÂ£o consumidas.

### 9.7. Baralho vazio

Quando o baralho de compra terminar:

- NÃƒÂ£o haverÃƒÂ¡ novas compras.
- A pilha de descarte nÃƒÂ£o serÃƒÂ¡ embaralhada novamente.
- O jogador continuarÃƒÂ¡ utilizando as cartas restantes na mÃƒÂ£o.
- A partida continuarÃƒÂ¡ normalmente.
- NÃƒÂ£o haverÃƒÂ¡ penalidade automÃƒÂ¡tica por esgotamento do baralho no MVP.

## 10. Encerramento e condiÃƒÂ§ÃƒÂµes de vitÃƒÂ³ria

### 10.1. VitÃƒÂ³ria por finalizaÃƒÂ§ÃƒÂ£o

A conclusÃƒÂ£o bem-sucedida de uma finalizaÃƒÂ§ÃƒÂ£o encerra imediatamente a partida.

### 10.2. Limite de rodadas

- A partida possui no mÃƒÂ¡ximo dez rodadas.
- ApÃƒÂ³s os dois turnos da dÃƒÂ©cima rodada, o sistema encerra a partida.
- NÃƒÂ£o existe prorrogaÃƒÂ§ÃƒÂ£o ou Golden Score.

### 10.3. CritÃƒÂ©rios de desempate

Ao tÃƒÂ©rmino da dÃƒÂ©cima rodada, o resultado ÃƒÂ© definido nesta ordem:

1. Maior pontuaÃƒÂ§ÃƒÂ£o.
2. Maior nÃƒÂºmero de vantagens.
3. Persistindo a igualdade, empate.

### 10.4. DesistÃƒÂªncia

A desistÃƒÂªncia voluntÃƒÂ¡ria representa derrota para o jogador que desistiu e vitÃƒÂ³ria para o adversÃƒÂ¡rio.

### 10.5. InterrupÃƒÂ§ÃƒÂµes

- InterrupÃƒÂ§ÃƒÂµes recuperÃƒÂ¡veis permitem retomar a partida a partir do ÃƒÂºltimo estado salvo.
- InterrupÃƒÂ§ÃƒÂµes irrecuperÃƒÂ¡veis registram a partida como interrompida.
- Uma partida interrompida por falha tÃƒÂ©cnica nÃƒÂ£o atribui vitÃƒÂ³ria ou derrota automaticamente.

## 11. Estado da partida e requisitos para implementaÃƒÂ§ÃƒÂ£o

O motor de regras deverÃƒÂ¡ manter, no mÃƒÂ­nimo, as seguintes informaÃƒÂ§ÃƒÂµes:

### 11.1. Estado dos jogadores

- IdentificaÃƒÂ§ÃƒÂ£o do atleta.
- Atributos permanentes.
- Energia atual.
- Controle situacional.
- PontuaÃƒÂ§ÃƒÂ£o.
- Vantagens.
- MÃƒÂ£o de cartas.
- Baralho de compra.
- Pilha de descarte.

### 11.2. Estado do combate

- Rodada atual.
- Jogador ativo.
- Iniciativa.
- PosiÃƒÂ§ÃƒÂ£o atual.
- IdentificaÃƒÂ§ÃƒÂ£o de quem estÃƒÂ¡ por cima e por baixo.
- HistÃƒÂ³rico de posiÃƒÂ§ÃƒÂµes pontuadas.
- Estado de estabilizaÃƒÂ§ÃƒÂ£o.
- Estado da sequÃƒÂªncia de finalizaÃƒÂ§ÃƒÂ£o.
- Janela de reaÃƒÂ§ÃƒÂ£o.
- Efeitos temporÃƒÂ¡rios ativos.

### 11.3. Requisitos do motor de regras

O motor deverÃƒÂ¡:

- Validar aÃƒÂ§ÃƒÂµes antes de executÃƒÂ¡-las.
- Verificar compatibilidade entre posiÃƒÂ§ÃƒÂ£o, carta e atributos.
- Controlar consumo e recuperaÃƒÂ§ÃƒÂ£o de energia.
- Gerenciar janelas de reaÃƒÂ§ÃƒÂ£o.
- Resolver ataques, defesas e contra-ataques.
- Atualizar posiÃƒÂ§ÃƒÂµes e controle.
- Validar estabilizaÃƒÂ§ÃƒÂ£o e pontuaÃƒÂ§ÃƒÂ£o.
- Gerenciar finalizaÃƒÂ§ÃƒÂµes.
- Controlar compra, uso e descarte de cartas.
- Determinar condiÃƒÂ§ÃƒÂµes de vitÃƒÂ³ria, empate e interrupÃƒÂ§ÃƒÂ£o.

As regras devem ser implementadas de forma independente da interface grÃƒÂ¡fica, permitindo testes automatizados e evoluÃƒÂ§ÃƒÂ£o futura do jogo.

## 12. ParÃƒÂ¢metros pendentes de balanceamento

Os seguintes parÃƒÂ¢metros precisam de validaÃƒÂ§ÃƒÂ£o durante os playtests:

| ParÃƒÂ¢metro | SituaÃƒÂ§ÃƒÂ£o |
|---|---|
| RecuperaÃƒÂ§ÃƒÂ£o automÃƒÂ¡tica de energia (+2) | ProvisÃƒÂ³rio |
| Custos individuais das aÃƒÂ§ÃƒÂµes | ProvisÃƒÂ³rios |
| Modificadores de controle situacional | ProvisÃƒÂ³rios |
| BÃƒÂ´nus e modificadores das cartas | Pendente |
| Compatibilidade tÃƒÂ©cnica das posiÃƒÂ§ÃƒÂµes | Pendente de validaÃƒÂ§ÃƒÂ£o |
| Requisitos de atributos das finalizaÃƒÂ§ÃƒÂµes | ProvisÃƒÂ³rios |
| CritÃƒÂ©rios objetivos para concessÃƒÂ£o de vantagens | Pendente |
| EquilÃƒÂ­brio entre arquÃƒÂ©tipos | Pendente |
| DistribuiÃƒÂ§ÃƒÂ£o e poder das cartas | Pendente |

As regras estruturais definidas neste documento servem como base funcional para a implementaÃƒÂ§ÃƒÂ£o do MVP. Os parÃƒÂ¢metros de balanceamento poderÃƒÂ£o ser ajustados sem alterar a estrutura fundamental do jogo.

---

**ROLL TCG Ã¢â‚¬â€ Game Rules Specification v1.0**
Documento-base para implementaÃƒÂ§ÃƒÂ£o do motor de regras e execuÃƒÂ§ÃƒÂ£o dos primeiros playtests.