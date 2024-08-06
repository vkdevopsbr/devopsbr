# Dockerfile Básico

## Introdução

Um Dockerfile é um arquivo de texto que contém todas as instruções necessárias para construir uma imagem Docker.

## Exemplo de Dockerfile

```Dockerfile
# Use uma imagem base oficial do Node.js
FROM node:14

# Crie um diretório de trabalho
WORKDIR /usr/src/app

# Copie o package.json e o package-lock.json
COPY package*.json ./

# Instale as dependências
RUN npm install

# Copie o código da aplicação
COPY . .

# Exponha a porta que a aplicação irá rodar
EXPOSE 8080

# Comando para rodar a aplicação
CMD ["node", "server.js"]


Comandos Úteis
docker build -t nome-da-imagem . : Construir a imagem Docker.
docker run -p 8080:8080 nome-da-imagem : Rodar o container usando a imagem que fez o build.