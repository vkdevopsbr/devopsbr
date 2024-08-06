#!/bin/bash

set -e

# Função para exibir mensagens de log
log() {
    echo -e "\033[1;34m$1\033[0m"
}

# Função para exibir mensagens de sucesso
success() {
    echo -e "\033[1;32m$1 [Sucesso]\033[0m"
}

# Atualizar o sistema
log "Atualizando o sistema..."
sudo apt-get update && sudo apt-get upgrade -y
success "Sistema atualizado!"

# Instalar curl
log "Instalando curl..."
sudo apt-get install -y curl
success "curl instalado!"

# Instalar Docker
log "Instalando Docker..."
if ! command -v docker &> /dev/null
then
    curl -fsSL https://get.docker.com -o get-docker.sh
    sh get-docker.sh
    rm get-docker.sh
    success "Docker instalado!"
else
    success "Docker já está instalado!"
fi

# Instalar Docker Compose
log "Instalando Docker Compose..."
if ! command -v docker-compose &> /dev/null
then
    sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    sudo chmod +x /usr/local/bin/docker-compose
    success "Docker Compose instalado!"
else
    success "Docker Compose já está instalado!"
fi

# Instalar Portainer
log "Instalando Portainer..."
if [ ! "$(docker ps -q -f name=portainer)" ]; then
    sudo docker volume create portainer_data
    sudo docker run -d -p 9000:9000 --name portainer --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer-ce
    success "Portainer instalado!"
else
    success "Portainer já está instalado!"
fi

# Instalar Ansible
log "Instalando Ansible..."
if ! command -v ansible &> /dev/null
then
    sudo apt-get install -y ansible
    success "Ansible instalado!"
else
    success "Ansible já está instalado!"
fi

# Instalar Python
log "Instalando Python..."
if ! command -v python3 &> /dev/null
then
    sudo apt-get install -y python3 python3-pip
    success "Python instalado!"
else
    success "Python já está instalado!"
fi

# Instalar Go
log "Instalando Go..."
if ! command -v go &> /dev/null
then
    wget https://golang.org/dl/go1.16.5.linux-amd64.tar.gz
    sudo tar -C /usr/local -xzf go1.16.5.linux-amd64.tar.gz
    echo "export PATH=\$PATH:/usr/local/go/bin" >> ~/.profile
    source ~/.profile
    rm go1.16.5.linux-amd64.tar.gz
    success "Go instalado!"
else
    success "Go já está instalado!"
fi

success "Setup dev completo!"
