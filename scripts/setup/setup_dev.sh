#!/bin/bash

log() {
    echo -e "\033[1;34m$1\033[0m"
}

success() {
    echo -e "\033[1;32m$1 [Sucesso]\033[0m"
}

in_progress() {
    echo -e "\033[1;33m$1 [Em andamento]\033[0m"
}

# Atualizar o sistema
in_progress "1 Atualizando o sistema..."
sudo apt-get update && sudo apt-get upgrade -y
success "1 Atualizando o sistema..."

# Instalar curl
in_progress "2 Instalando curl..."
sudo apt-get install -y curl
success "2 Instalando curl..."

# Instalar Docker
in_progress "3 Instalando Docker..."
curl -fsSL https://get.docker.com -o get-docker.sh
sh get-docker.sh
success "3 Instalando Docker..."

# Instalar Docker Compose
in_progress "4 Instalando Docker Compose..."
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
success "4 Instalando Docker Compose..."

# Instalar Portainer
in_progress "5 Instalando Portainer..."
sudo docker volume create portainer_data
sudo docker run -d -p 9000:9000 --name portainer --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer-ce
success "5 Instalando Portainer..."

# Instalar Ansible
in_progress "6 Instalando Ansible..."
sudo apt-get install -y ansible
success "6 Instalando Ansible..."

# Instalar Python
in_progress "7 Instalando Python..."
sudo apt-get install -y python3 python3-pip
success "7 Instalando Python..."

# Instalar Go
in_progress "8 Instalando Go..."
wget https://golang.org/dl/go1.16.5.linux-amd64.tar.gz
sudo tar -C /usr/local -xzf go1.16.5.linux-amd64.tar.gz
echo "export PATH=\$PATH:/usr/local/go/bin" >> ~/.profile
source ~/.profile
success "8 Instalando Go..."

# Limpeza
in_progress "9 Limpando arquivos temporários..."
rm get-docker.sh
rm go1.16.5.linux-amd64.tar.gz
success "9 Limpando arquivos temporários..."

success "Setup dev completo!"
