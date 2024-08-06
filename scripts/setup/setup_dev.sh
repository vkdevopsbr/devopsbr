#!/bin/bash

# Atualiza a lista de pacotes e instala as dependências
sudo apt-get update
sudo apt-get install -y ca-certificates curl gnupg

# Cria o diretório para armazenar a chave GPG do Docker
sudo install -m 0755 -d /etc/apt/keyrings

# Baixa a chave GPG do Docker
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc

# Define permissões apropriadas para a chave GPG
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Adiciona o repositório do Docker às fontes do Apt
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Atualiza a lista de pacotes novamente
sudo apt-get update

# Instala o Docker e seus componentes
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Adiciona o usuário atual ao grupo docker
sudo usermod -aG docker $USER

# Executa um novo shell com o grupo docker
exec sg docker newgrp `id -gn` << END
docker --version
docker ps
END


echo "Docker instalado e configurado com sucesso!"
