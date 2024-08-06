# Fluxos de Trabalho com Git

## Introdução

Git é um sistema de controle de versão distribuído que permite que múltiplos desenvolvedores trabalhem em um projeto de maneira eficiente.

## Fluxo de Trabalho Básico

1. **Clonar o Repositório**:
   ```bash
   git clone https://github.com/vkdevopsbr/devopsbr.git
   ```

2. **Criar uma Nova Branch**:
   ```bash
   git checkout -b minha-nova-feature
   ```

3. **Fazer Mudanças e Comitar**:
   ```bash
   git add .
   git commit -m "Adiciona minhanova feature"
   ```

4. **Enviar para o Repositório Remoto**:
   ```bash
   git push origin minha-nova-feature
   ```

## Dicas Úteis

- **Branch Naming**: Use nomes descritivos para suas branches.
- **Commits Pequenos**: Faça commits frequentes com mudanças pequenas e descrições claras.
- **Revisões de Código**: Sempre peça por revisões de código antes de mesclar mudanças na branch principal.
```