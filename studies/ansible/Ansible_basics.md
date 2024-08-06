
#### `studies/ansible/Ansible_basics.md`

Um guia básico sobre Ansible.

```markdown
# Ansible Básico

## Introdução

Ansible é uma ferramenta de automação de TI que pode configurar sistemas, implantar software e orquestrar tarefas mais avançadas.

## Conceitos Principais

- **Playbook**: Um arquivo YAML que contém uma lista de tarefas a serem executadas.
- **Inventory**: Um arquivo que lista os hosts onde as tarefas serão executadas.

## Exemplo de Playbook

```yaml
---
- name: Instalar e configurar Nginx
  hosts: webservers
  become: yes
  tasks:
    - name: Instalar Nginx
      apt:
        name: nginx
        state: present

    - name: Iniciar Nginx
      service:
        name: nginx
        state: started
        enabled: yes


#Comandos Básicos
ansible-playbook -i inventory playbook.yml : Executar um playbook.
ansible all -m ping : Verificar conectividade com todos os hosts no inventário.