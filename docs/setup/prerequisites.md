# ROLL TCG — Pré-requisitos e Ambiente de Desenvolvimento

**Documento:** Pré-requisitos técnicos  
**Projeto:** ROLL TCG  
**Status:** Base tecnológica planejada para o MVP

## 1. Objetivo

Documentar os requisitos de software e as tecnologias necessárias para preparar um ambiente local de desenvolvimento do ROLL TCG.

Este documento serve como referência para novos colaboradores e para a configuração inicial das máquinas de desenvolvimento.

## 2. Arquitetura tecnológica

| Camada | Tecnologia | Finalidade |
|---|---|---|
| Backend | Java 21 | Linguagem principal do backend |
| Framework backend | Spring Boot | Desenvolvimento das APIs e serviços |
| Build backend | Apache Maven | Gerenciamento de dependências, compilação e testes |
| Frontend | React | Construção da interface web |
| Linguagem frontend | TypeScript | Tipagem estática e desenvolvimento frontend |
| Runtime frontend | Node.js LTS | Execução das ferramentas do frontend |
| Gerenciador de pacotes | npm | Gerenciamento das dependências frontend |
| Banco de dados | PostgreSQL | Persistência dos dados |
| Containers | Docker | Empacotamento e execução dos serviços |
| Orquestração local | Docker Compose | Execução integrada dos componentes |
| Versionamento | Git | Controle de versão |
| Repositório | GitHub | Hospedagem do código e colaboração |

## 3. Pré-requisitos obrigatórios

### 3.1. Git

Utilizado para controle de versão, gerenciamento de branches, commits e integração com o GitHub.

- Download: https://git-scm.com/install/windows
- Documentação: https://git-scm.com/doc

### 3.2. Java Development Kit (JDK)

Utilizado para compilar e executar o backend.

- Versão de referência: Java 21 LTS.
- Distribuição recomendada: Eclipse Temurin JDK.
- Download: https://adoptium.net/temurin/releases/?version=21
- Documentação: https://adoptium.net/installation/

Selecionar o pacote JDK correspondente ao sistema operacional e à arquitetura da máquina.

### 3.3. Node.js e npm

Necessários para executar o ambiente frontend, instalar dependências e executar scripts de desenvolvimento.

- Versão recomendada: LTS.
- Download: https://nodejs.org/pt-br/download
- Documentação: https://nodejs.org/docs/

O npm é distribuído junto com o Node.js.

### 3.4. Docker Desktop

Utilizado para executar containers e os serviços necessários ao ambiente local.

- Download: https://www.docker.com/products/docker-desktop/
- Instalação no Windows: https://docs.docker.com/desktop/setup/install/windows-install/
- Documentação do Docker Compose: https://docs.docker.com/compose/

No Windows, recomenda-se utilizar o backend WSL 2, conforme os requisitos oficiais do Docker Desktop.

### 3.5. PostgreSQL

Banco de dados relacional utilizado pelo projeto.

Para desenvolvimento local, a recomendação é executar o PostgreSQL por meio de container Docker Compose.

A instalação nativa do PostgreSQL na máquina é opcional.

- Download: https://www.postgresql.org/download/
- Documentação: https://www.postgresql.org/docs/

## 4. Ferramentas complementares

### 4.1. Apache Maven

Ferramenta de build e gerenciamento de dependências do backend Java.

- Download: https://maven.apache.org/download.cgi
- Documentação: https://maven.apache.org/guides/

**Recomendação:** utilizar o Maven Wrapper (`mvnw` ou `mvnw.cmd`) no repositório para padronizar a versão utilizada pela equipe e evitar a necessidade de instalação global do Maven.

### 4.2. Visual Studio Code

Editor recomendado para desenvolvimento do backend, frontend e documentação.

- Download: https://code.visualstudio.com/Download
- Documentação: https://code.visualstudio.com/docs

Extensões recomendadas:

- Extension Pack for Java.
- Spring Boot Extension Pack.
- Extension Pack for Visual Studio Code.
- Docker.
- Prettier.

## 5. Tecnologias gerenciadas pelo projeto

As tecnologias abaixo não exigem instalação independente na máquina do desenvolvedor.

| Tecnologia | Como será utilizada |
|---|---|
| Spring Boot | Dependência gerenciada pelo Maven |
| React | Dependência gerenciada pelo npm |
| TypeScript | Dependência gerenciada pelo npm |
| PostgreSQL | Imagem Docker ou instalação local |
| Docker Compose | Configuração versionada no repositório |

As versões específicas de frameworks, bibliotecas e dependências deverão ser definidas nos arquivos de configuração do projeto.

## 6. Verificação da instalação

Após instalar os pré-requisitos, executar os seguintes comandos no terminal:

### Git
```powershell
git --version
```

### Java
```powershell
java -version
javac -version
```

### Node.js
```powershell
node --version
npm --version
```

### Docker
```powershell
docker --version
docker compose version
```

### Maven
Caso esteja instalado globalmente:
```powershell
mvn --version
```

Caso o projeto disponibilize Maven Wrapper, executar na pasta do backend:
```powershell
.\mvnw.cmd --version
```

## 7. Considerações

- Utilizar Java 21 como versão de referência do backend.
- Priorizar versões LTS para ferramentas de execução.
- Utilizar Docker Compose para padronizar os serviços locais.
- Evitar instalações globais desnecessárias quando houver ferramentas gerenciadas pelo próprio repositório.
- Manter versões e configurações documentadas e versionadas.
- Atualizar este documento quando houver alterações na arquitetura tecnológica.

---

**ROLL TCG — Development Environment Requirements**