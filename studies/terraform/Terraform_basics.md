
#### `studies/terraform/Terraform_basics.md`

Um guia básico sobre Terraform.

```markdown
# Terraform Básico

## Introdução

Terraform é uma ferramenta de infraestrutura como código para criar, atualizar e versionar infraestrutura de maneira segura e eficiente.

## Conceitos Principais

- **Providers**: APIs que interagem com serviços de nuvem e outros provedores.
- **Resources**: Componentes de infraestrutura que são gerenciados pelo Terraform.


# Comandos Básicos
terraform init : Inicializar o Terraform.
terraform plan : Criar um plano de execução.
terraform apply : Aplicar as mudanças para alcançar o estado desejado.
terraform destroy : Destruir a infraestrutura criada.


## Exemplo de Configuração

```hcl
provider "aws" {
  region = "us-west-2"
}

resource "aws_instance" "example" {
  ami           = "ami-2757f631"
  instance_type = "t2.micro"
}

output "instance_id" {
  value = aws_instance.example.id
}

