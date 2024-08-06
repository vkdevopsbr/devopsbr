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

# Atualiza o grupo docker para o usuário atual sem precisar reiniciar a sessão
sudo newgrp docker

# Cria o volume para dados do Portainer
docker volume create portainer_data

# Executa o container do Portainer com privilégios elevados
docker run -d \
  -p 8000:8000 \
  -p 9000:9000 \
  -p 9443:9443 \
  --name portainer \
  --restart=always \
  --privileged \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v portainer_data:/data \
  portainer/portainer-ce:latest


echo "Setup Docker instalado e configurado com sucesso!"
