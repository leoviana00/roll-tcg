# ROLL TCG — Game Design Document

- **Versão:** 0.1
- **Status:** Fundação do design
- **Gênero:** Trading Card Game (TCG) baseado em Jiu-Jitsu Brasileiro
- **Plataforma inicial:** Web
- **Modo inicial:** Partida local contra IA

---

## 1. Visão geral

ROLL TCG é um jogo estratégico de cartas inspirado no Jiu-Jitsu Brasileiro. O jogador controla um atleta, constrói um baralho e disputa combates utilizando técnicas, posições, defesas, escapes e submissões.

O objetivo é representar a lógica técnica e estratégica do Jiu-Jitsu por meio de um sistema de cartas e decisões táticas.

### Princípios do jogo

- Fidelidade às posições e técnicas do Jiu-Jitsu.
- Estratégia baseada em posicionamento, energia e controle.
- Ataques com oportunidades reais de reação.
- Equilíbrio entre atletas e baralhos.
- Progressão de coleção sem vantagem competitiva automática por raridade.

## 2. Formato da partida

- Dois competidores.
- Um atleta por jogador.
- Um baralho de 40 cartas por jogador.
- Duração-alvo de 10 minutos.
- Submissão confirmada encerra a partida imediatamente.
- Sem submissão, vence quem tiver maior pontuação.
- Empate nos critérios de desempate resulta em empate.

### Critérios de vitória

1. Submissão confirmada.
2. Maior pontuação ao final do combate.
3. Maior número de vantagens.
4. Persistindo o empate, a partida termina empatada.

## 3. Sistema de atributos dos atletas

Cada atleta possui quatro atributos, com valores entre 1 e 5.

| Atributo | Função |
|---|---|
| Força | Capacidade física e aplicação de força |
| Técnica | Execução e eficiência das técnicas |
| Resistência | Capacidade de suportar esforço e administrar energia |
| Controle | Capacidade de manter posições e dominar o adversário |

### Distribuição

- Total de 14 pontos.
- Mínimo de 1 por atributo.
- Máximo de 5 por atributo.
- Todos os pontos devem ser distribuídos.

Os atributos serão utilizados para validar requisitos de cartas e participar das disputas ofensivas e defensivas.

### Fórmula de resolução

Resultado = Atributo aplicável + Bônus da carta + Modificadores.

Em caso de igualdade entre ataque e defesa, prevalece a defesa.

## 4. Arquétipos iniciais

| Arquétipo | Força | Técnica | Resistência | Controle |
|---|---:|---:|---:|---:|
| Passador | 4 | 3 | 3 | 4 |
| Guardeiro | 2 | 5 | 3 | 4 |
| Finalizador | 3 | 5 | 3 | 3 |
| Completo | 3 | 4 | 4 | 3 |

Cada arquétipo possui uma habilidade passiva:

- **Passador:** bônus de +1 na primeira tentativa de passagem de guarda por rodada.
- **Guardeiro:** bônus de +1 na primeira tentativa de raspagem por rodada.
- **Finalizador:** bônus de +1 na primeira progressão de submissão por rodada.
- **Completo:** bônus de +1 na primeira reação defensiva por rodada.

Os bônus são parâmetros iniciais de balanceamento.

## 5. Sistema de energia

Energia representa o desgaste físico do atleta.

### Proposta inicial

- Escala de 0 a 10.
- Energia inicial: 10.
- Limite máximo: 10.
- Recuperação automática por rodada.
- Recuperação adicional por cartas e ações específicas.

### Custos preliminares

| Ação | Custo sugerido |
|---|---:|
| Ajuste de posição | 1 |
| Defesa simples | 1 |
| Raspagem | 2 |
| Passagem de guarda | 3 |
| Ataque de submissão | 3 |
| Defesa de submissão | 2 |

Os valores precisam ser validados por testes.

## 6. Sistema de controle

O atributo permanente Controle influencia a capacidade do atleta de manter posições e executar técnicas.

Também será utilizado um indicador situacional de controle, inicialmente proposto na escala de 0 a 5.

| Valor | Interpretação |
|---:|---|
| 0 | Sem controle efetivo |
| 1 | Controle fraco |
| 2 | Controle moderado |
| 3 | Controle consistente |
| 4 | Controle forte |
| 5 | Controle dominante |

A definição final de como esse indicador será armazenado e atualizado ainda está pendente.

## 7. Estrutura de turnos

### Proposta inicial

- 10 rodadas de 1 minuto.
- Dois turnos por rodada, um para cada jogador.
- Iniciativa inicial definida por sorteio.
- Alternância da iniciativa a cada rodada.
- Até duas ações principais por turno.
- Reações acontecem durante as janelas abertas pelo adversário.

### Sequência do turno

1. Recuperação de energia, conforme regra a consolidar.
2. Execução de até duas ações principais.
3. Resolução das reações correspondentes.
4. Atualização dos estados de combate.

A relação entre o relógio de 10 minutos, a duração dos turnos e as janelas de estabilização ainda precisa ser formalizada.

## 8. Sistema de combate e reações

O combate utiliza defesa passiva e cartas de reação.

### Sequência de uma ação ofensiva

1. Validar compatibilidade com a posição.
2. Validar requisitos de atributos.
3. Validar energia disponível.
4. Pagar o custo da ação.
5. Abrir uma janela de reação.
6. O defensor utiliza uma reação compatível ou defesa passiva.
7. Comparar os resultados.
8. Atualizar o estado da partida.

### Regras

- Uma ação ofensiva abre uma janela de reação.
- O defensor pode utilizar uma carta de reação compatível.
- Não há reação à reação.
- Empate favorece a defesa.
- Contra-ataques dependem de cartas específicas.
- Defesa bem-sucedida não altera automaticamente a posição.

## 9. Categorias de cartas

- Ataque.
- Defesa.
- Escape.
- Contra-ataque.
- Submissão.
- Estratégia e recuperação.

### Defesa

Três categorias:

**Bloqueio:** neutraliza uma técnica específica.

**Escape:** permite sair de uma posição desfavorável.

**Contra-ataque:** transforma uma defesa bem-sucedida em oportunidade ofensiva, mediante carta compatível.

Cada Bloqueio precisa identificar expressamente a técnica que neutraliza. Não existe compatibilidade automática entre técnicas semelhantes.

## 10. Catálogo inicial de escapes

| Carta | Origem | Destino no sucesso | Energia |
|---|---|---|---:|
| Fuga da Montada | Por baixo na montada | Guarda recuperada | 3 |
| Fuga do Controle Lateral | Por baixo no controle lateral | Guarda recuperada | 3 |
| Fuga das Costas | Sob controle pelas costas | Controle lateral por cima | 4 |
| Escape da Meia-guarda Desfavorável | Por baixo na meia-guarda | Guarda neutra | A definir |
| Recuperação de Guarda | Guarda parcialmente comprometida | Guarda recuperada | 2 |

### Regras de Escape

Cada carta especifica:

- Posição de origem.
- Técnica utilizada.
- Requisitos de atributos.
- Custo de energia.
- Posição de destino.
- Consequência da falha.

O resultado de cada escape depende de sua própria carta.

## 11. Sistema de submissões

Cada submissão possui três etapas:

1. Preparação.
2. Ataque.
3. Conclusão.

Cada etapa exige uma ação válida, pagamento de energia e oportunidade de reação do adversário.

Uma submissão confirmada encerra a partida.

### Catálogo inicial

| Submissão | Posição de aplicação |
|---|---|
| Armbar | Guarda fechada ou montada |
| Triângulo | Guarda fechada |
| Kimura | Guarda ou controle lateral |
| Mata-leão | Controle das costas |
| Americana | Controle lateral ou montada |
| Chave de pé reta | Guarda ou entrelaçamento de pernas compatível |

Os requisitos e custos específicos são parâmetros iniciais e precisam de validação técnica e de balanceamento.

## 12. Pontuação

| Ação ou posição | Pontos |
|---|---:|
| Queda | 2 |
| Raspagem | 2 |
| Joelho na barriga | 2 |
| Passagem de guarda | 3 |
| Montada | 4 |
| Controle das costas | 4 |
| Submissão confirmada | Vitória imediata |

Os pontos só são concedidos após cumprimento dos requisitos de validade e estabilização.

### Repetição de pontuação

Uma posição não gera pontuação repetida enquanto o controle permanecer estabelecido.

Se o atleta perder o controle e posteriormente reconquistar a posição, poderá pontuar novamente após nova estabilização válida.

### Vantagens

São concedidas por oportunidades ofensivas relevantes que não resultaram em pontuação ou submissão.

Tentativas sem progressão significativa não geram vantagem.

## 13. Construção de baralho

Cada jogador utiliza um baralho de 40 cartas.

| Categoria | Quantidade |
|---|---:|
| Ataque | 10 |
| Defesa | 10 |
| Escape | 5 |
| Contra-ataque | 5 |
| Submissão | 6 |
| Estratégia e recuperação | 4 |
| **Total** | **40** |

### Regras preliminares

- Máximo de duas cópias da mesma carta.
- Baralho individual por jogador.
- Cartas precisam respeitar os requisitos do atleta.

### Compra de cartas

| Regra | Quantidade |
|---|---:|
| Mão inicial | 5 cartas |
| Compra por rodada | 1 carta |
| Limite de mão | 7 cartas |

Quando o baralho acabar, o descarte não será embaralhado automaticamente.

## 14. Cartas de atleta

Cada atleta será representado por uma carta própria, contendo:

- Identificador.
- Nome.
- Ilustração.
- Arquétipo.
- Atributos.
- Habilidade passiva.
- Descrição do estilo.
- Raridade.
- Versão da carta.

O atleta escolhido permanece ativo durante toda a partida e não pertence à mão nem ao descarte.

## 15. Raridade e coleção

Quatro níveis:

- Comum.
- Rara.
- Épica.
- Lendária.

Raridade não representa superioridade competitiva automática.

A coleção poderá incluir:

- Cartas desbloqueadas.
- Versões visuais alternativas.
- Atletas.
- Técnicas.
- Expansões temáticas.

Personalizações cosméticas não devem conceder vantagens competitivas.

## 16. Identidade visual

### Direção artística

Estética esportiva, competitiva, moderna e premium.

### Paleta proposta

| Cor | Código |
|---|---|
| Preto | #111318 |
| Grafite | #292D35 |
| Vermelho | #C62836 |
| Dourado | #C5A15A |
| Branco | #FFFFFF |

As cartas terão ilustrações centrais, nome, categoria, raridade, requisitos, custo, efeito e identificador.

## 17. Fluxo funcional

1. Menu principal.
2. Seleção do atleta.
3. Seleção do baralho.
4. Preparação do combate.
5. Arena.
6. Encerramento.
7. Resultado e estatísticas.

## 18. Escopo do MVP

A primeira versão deverá contemplar:

- Partida local contra uma IA simples.
- Quatro arquétipos iniciais.
- Baralho de 40 cartas.
- Sistema de combate e reações.
- Energia e controle.
- Pontuação e submissões.
- Resultado da partida.

Coleção online, progressão, economia virtual, ranqueamento e multiplayer online ficam para etapas posteriores.

## 19. Arquitetura técnica proposta

| Componente | Tecnologia |
|---|---|
| Backend | Java 21 + Spring Boot |
| Frontend | React + TypeScript |
| Persistência | PostgreSQL |
| Motor de regras | Módulo independente |
| Testes | Testes unitários e de integração |
| Execução local | Docker |

O motor de regras deverá ser independente da interface e da camada web, permitindo reutilização futura no multiplayer.

## 20. Pendências antes da implementação

Os seguintes pontos precisam ser fechados ou testados:

1. Duração real dos turnos e funcionamento do relógio.
2. Tempo de estabilização por posição.
3. Momento exato da recuperação automática de energia.
4. Valores finais de custos e modificadores.
5. Funcionamento definitivo do indicador situacional de controle.
6. Requisitos de atributos do Escape da Meia-guarda.
7. Compatibilidade das reações contra cartas de Escape.
8. Regras completas de compra, descarte e fim do baralho.
9. Distribuição de cartas por raridade.
10. Balanceamento das habilidades passivas dos atletas.

**Status:** documento inicial de referência. As decisões marcadas como propostas ou pendentes não devem ser tratadas como regras definitivas até serem validadas em playtests.