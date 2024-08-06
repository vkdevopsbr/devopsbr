#!/bin/bash

# Atualizar o sistema
echo "Atualizando o sistema..."
apt-get update && apt-get upgrade -y
echo "Sistema atualizado com sucesso!"

# Instalar Docker
echo "Instalando Docker..."
curl -fsSL https://get.docker.com -o get-docker.sh
sh get-docker.sh
echo "Docker instalado com sucesso!"

# Instalar Docker Compose
echo "Instalando Docker Compose..."
curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
echo "Docker Compose instalado com sucesso!"

# Instalar Portainer
echo "Instalando Portainer..."
docker volume create portainer_data
docker run -d -p 9000:9000 --name portainer --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer-ce
echo "Portainer instalado com sucesso!"

# Instalar Ansible
echo "Instalando Ansible..."
apt-get install -y ansible
echo "Ansible instalado com sucesso!"

# Instalar Python
echo "Instalando Python..."
apt-get install -y python3 python3-pip
echo "Python instalado com sucesso!"

# Instalar Go
echo "Instalando Go..."
wget https://go.dev/dl/go1.16.5.linux-amd64.tar.gz
tar -C /usr/local -xzf go1.16.5.linux-amd64.tar.gz
echo "export PATH=$PATH:/usr/local/go/bin" >> ~/.profile
source ~/.profile
echo "Go instalado com sucesso!"

# Limpeza
echo "Limpando arquivos temporários..."
rm get-docker.sh
rm go1.16.5.linux-amd64.tar.gz
echo "Arquivos temporários limpos com sucesso!"

echo "Setup dev completo!"
