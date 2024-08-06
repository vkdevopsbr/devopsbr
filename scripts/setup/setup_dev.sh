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

# Verificar se sudo está disponível
if command -v sudo > /dev/null; then
    SUDO="sudo"
else
    SUDO=""
fi

# Atualizar o sistema
print_status "1" "Atualizando o sistema..." "Em andamento"
if $SUDO apt-get update && $SUDO apt-get upgrade -y; then
    print_status "1" "Atualizando o sistema..." "Sucesso"
else
    print_status "1" "Atualizando o sistema..." "Falha"
    exit 1
fi

# Instalar curl
print_status "2" "Instalando curl..." "Em andamento"
if $SUDO apt-get install -y curl; then
    print_status "2" "Instalando curl..." "Sucesso"
else
    print_status "2" "Instalando curl..." "Falha"
    exit 1
fi

# Instalar Docker
print_status "3" "Instalando Docker..." "Em andamento"
if curl -fsSL https://get.docker.com -o get-docker.sh && sh get-docker.sh; then
    print_status "3" "Instalando Docker..." "Sucesso"
else
    print_status "3" "Instalando Docker..." "Falha"
    exit 1
fi

# Instalar Docker Compose
print_status "4" "Instalando Docker Compose..." "Em andamento"
if $SUDO curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose && $SUDO chmod +x /usr/local/bin/docker-compose; then
    print_status "4" "Instalando Docker Compose..." "Sucesso"
else
    print_status "4" "Instalando Docker Compose..." "Falha"
    exit 1
fi

# Instalar Portainer
print_status "5" "Instalando Portainer..." "Em andamento"
if $SUDO docker volume create portainer_data && $SUDO docker run -d -p 9000:9000 --name portainer --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer-ce; then
    print_status "5" "Instalando Portainer..." "Sucesso"
else
    print_status "5" "Instalando Portainer..." "Falha"
    exit 1
fi

# Instalar Ansible
print_status "6" "Instalando Ansible..." "Em andamento"
if $SUDO apt-get install -y ansible; then
    print_status "6" "Instalando Ansible..." "Sucesso"
else
    print_status "6" "Instalando Ansible..." "Falha"
    exit 1
fi

# Instalar Python
print_status "7" "Instalando Python..." "Em andamento"
if $SUDO apt-get install -y python3 python3-pip; then
    print_status "7" "Instalando Python..." "Sucesso"
else
    print_status "7" "Instalando Python..." "Falha"
    exit 1
fi

# Instalar Go
print_status "8" "Instalando Go..." "Em andamento"
if wget https://golang.org/dl/go1.16.5.linux-amd64.tar.gz && $SUDO tar -C /usr/local -xzf go1.16.5.linux-amd64.tar.gz; then
    echo "export PATH=$PATH:/usr/local/go/bin" >> ~/.profile
    source ~/.profile
    print_status "8" "Instalando Go..." "Sucesso"
else
    print_status "8" "Instalando Go..." "Falha"
    exit 1
fi

# Limpeza
print_status "9" "Limpando arquivos temporários..." "Em andamento"
if rm -f get-docker.sh go1.16.5.linux-amd64.tar.gz; then
    print_status "9" "Limpando arquivos temporários..." "Sucesso"
else
    print_status "9" "Limpando arquivos temporários..." "Falha"
    exit 1
fi

print_status "10" "Setup dev completo!" ""
