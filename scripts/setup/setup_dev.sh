#!/bin/bash

# Função para imprimir o status de cada etapa
print_status() {
    local step="$1"
    local message="$2"
    local status="$3"
    local cols=$(tput cols)
    local line_length=${#message}
    local padding=$((cols - line_length - 10))
    printf "%s %-${padding}s [%s]\n" "$step" "$message" "$status"
}

# Atualizar o sistema
print_status "1" "Atualizando o sistema..." "Em andamento"
apt-get update && apt-get upgrade -y && print_status "1" "Atualizando o sistema..." "Sucesso" || print_status "1" "Atualizando o sistema..." "Falha"

# Instalar curl
print_status "2" "Instalando curl..." "Em andamento"
apt-get install -y curl && print_status "2" "Instalando curl..." "Sucesso" || print_status "2" "Instalando curl..." "Falha"

# Instalar Docker
print_status "3" "Instalando Docker..." "Em andamento"
curl -fsSL https://get.docker.com -o get-docker.sh
chmod +x get-docker.sh
sed -i 's/+ sleep 20/+ sleep 0/' get-docker.sh # Remove delay for WSL detection
sh get-docker.sh && print_status "3" "Instalando Docker..." "Sucesso" || print_status "3" "Instalando Docker..." "Falha"

# Instalar Docker Compose
print_status "4" "Instalando Docker Compose..." "Em andamento"
curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose && chmod +x /usr/local/bin/docker-compose && print_status "4" "Instalando Docker Compose..." "Sucesso" || print_status "4" "Instalando Docker Compose..." "Falha"

# Instalar Portainer
print_status "5" "Instalando Portainer..." "Em andamento"
docker volume create portainer_data && docker run -d -p 9000:9000 --name portainer --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer-ce && print_status "5" "Instalando Portainer..." "Sucesso" || print_status "5" "Instalando Portainer..." "Falha"

# Instalar Ansible
print_status "6" "Instalando Ansible..." "Em andamento"
apt-get install -y ansible && print_status "6" "Instalando Ansible..." "Sucesso" || print_status "6" "Instalando Ansible..." "Falha"

# Instalar Python
print_status "7" "Instalando Python..." "Em andamento"
apt-get install -y python3 python3-pip && print_status "7" "Instalando Python..." "Sucesso" || print_status "7" "Instalando Python..." "Falha"

# Instalar Go
print_status "8" "Instalando Go..." "Em andamento"
wget https://go.dev/dl/go1.16.5.linux-amd64.tar.gz && tar -C /usr/local -xzf go1.16.5.linux-amd64.tar.gz && echo "export PATH=$PATH:/usr/local/go/bin" >> ~/.profile && source ~/.profile && print_status "8" "Instalando Go..." "Sucesso" || print_status "8" "Instalando Go..." "Falha"

# Limpeza
print_status "9" "Limpando arquivos temporários..." "Em andamento"
rm get-docker.sh go1.16.5.linux-amd64.tar.gz && print_status "9" "Limpando arquivos temporários..." "Sucesso" || print_status "9" "Limpando arquivos temporários..." "Falha"

print_status "10" "Setup dev completo!" ""
