#!/bin/bash

# Função para verificar se o script está sendo executado como root
check_root() {
  if [ "$(id -u)" -ne 0 ]; then
    echo "Este script deve ser executado como root." >&2
    exit 1
  fi
}

# Função para atualizar e instalar pacotes
install_packages() {
  echo "Atualizando lista de pacotes..."
  apt-get update -y

  echo "Atualizando pacotes instalados..."
  apt-get upgrade -y

  echo "Instalando pacotes essenciais..."
  apt-get install -y software-properties-common curl wget git vim unzip
}

# Função para instalar Go
install_go() {
  echo "Instalando Go..."
  wget https://dl.google.com/go/go1.16.7.linux-amd64.tar.gz
  tar -C /usr/local -xzf go1.16.7.linux-amd64.tar.gz
  echo "export PATH=\$PATH:/usr/local/go/bin" >> /etc/profile
  source /etc/profile
  rm go1.16.7.linux-amd64.tar.gz
}

# Função para instalar Python
install_python() {
  echo "Instalando Python..."
  apt-get install -y python3 python3-pip
}

# Função para instalar Docker e Docker Compose
install_docker() {
  echo "Instalando Docker..."
  curl -fsSL https://get.docker.com -o get-docker.sh
  sh get-docker.sh
  usermod -aG docker ${USER}

  echo "Instalando Docker Compose..."
  curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
  chmod +x /usr/local/bin/docker-compose
}

# Função para instalar Portainer
install_portainer() {
  echo "Instalando Portainer..."
  docker volume create portainer_data
  docker run -d -p 9000:9000 --name=portainer --restart=always \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -v portainer_data:/data portainer/portainer-ce
}

# Função para instalar Ansible
install_ansible() {
  echo "Instalando Ansible..."
  apt-add-repository --yes --update ppa:ansible/ansible
  apt-get install -y ansible
}

# Função para instalar Terraform
install_terraform() {
  echo "Instalando Terraform..."
  wget https://releases.hashicorp.com/terraform/1.0.9/terraform_1.0.9_linux_amd64.zip
  unzip terraform_1.0.9_linux_amd64.zip
  mv terraform /usr/local/bin/
  rm terraform_1.0.9_linux_amd64.zip
}

# Função para instalar Kubernetes (kubectl)
install_kubectl() {
  echo "Instalando Kubernetes (kubectl)..."
  curl -LO "https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl"
  chmod +x ./kubectl
  mv ./kubectl /usr/local/bin/kubectl
}

# Função para limpar arquivos temporários
cleanup() {
  echo "Limpando arquivos temporários..."
  apt-get autoremove -y
  apt-get clean
}

# Função para registrar logs
log() {
  local LOGFILE="$HOME/setup_dev.log"
  echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" | tee -a "$LOGFILE"
}

# Função principal
main() {
  check_root
  log "Iniciando configuração do ambiente de desenvolvimento..."
  install_packages
  install_docker
  install_portainer
  install_go
  install_python
  install_ansible
  install_terraform
  install_kubectl
  cleanup
  log "Configuração do ambiente de desenvolvimento concluída com sucesso."
}

# Executa a função principal
main
