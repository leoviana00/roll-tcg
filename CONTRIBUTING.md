
# Contributing Guide

Obrigado por contribuir com o ROLL TCG!

Este documento define as diretrizes para desenvolvimento, manutenção e contribuição no projeto.

## 1. Fluxo de desenvolvimento

O desenvolvimento deve acontecer em branches específicas, evitando alterações diretas na branch `main`.

| Branch | Finalidade |
|---|---|
| `main` | Versão estável do projeto |
| `develop` | Integração de funcionalidades |
| `feature/*` | Desenvolvimento de novas funcionalidades |
| `fix/*` | Correção de bugs |
| `hotfix/*` | Correções urgentes em produção |

## 2. Convenção de branches

Utilizamos nomes objetivos e descritivos.

Exemplos:

- `feature/repository-foundation`
- `feature/game-engine`
- `feature/card-system`
- `fix/card-validation`
- `hotfix/release-error`

## 3. Padrão de commits

O projeto utiliza Conventional Commits.

Formato:

`<tipo>(<escopo>): <descrição>`

Tipos principais:

| Tipo | Finalidade |
|---|---|
| `feat` | Nova funcionalidade |
| `fix` | Correção de bug |
| `docs` | Documentação |
| `style` | Formatação sem alteração de lógica |
| `refactor` | Refatoração |
| `test` | Testes |
| `build` | Dependências e build |
| `ci` | Integração contínua |
| `chore` | Manutenção geral |

Exemplos:

- `chore(repository): initialize repository structure`
- `docs(readme): add project overview`
- `feat(game-engine): implement turn management`
- `fix(cards): correct card validation`

Alterações incompatíveis devem indicar `BREAKING CHANGE` no corpo do commit ou utilizar `!` após o tipo.

## 4. Pull Requests

Toda alteração deve ser submetida por Pull Request.

Antes de abrir um PR:

- Verifique se o código está funcionando.
- Execute os testes aplicáveis.
- Revise suas próprias alterações.
- Atualize a documentação quando necessário.
- Vincule a Issue relacionada, quando existir.

## 5. Boas práticas

- Mantenha as alterações pequenas e focadas.
- Evite misturar funcionalidades distintas no mesmo PR.
- Não envie credenciais, tokens ou arquivos `.env`.
- Escreva código legível e de fácil manutenção.
- Priorize testes para novas funcionalidades.
- Mantenha as regras do jogo independentes da interface.

## 6. Versionamento

O projeto utiliza Semantic Versioning:

`MAJOR.MINOR.PATCH`

A versão será controlada inicialmente pelo arquivo `version.json`.

A geração do changelog e das tags será automatizada pelo pipeline de release.

## 7. Dúvidas e sugestões

Utilize as Issues do GitHub para reportar problemas, sugerir funcionalidades ou propor melhorias.
