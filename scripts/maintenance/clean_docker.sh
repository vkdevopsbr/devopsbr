#!/bin/bash

# Limpar Docker
docker system prune -a -f --volumes

echo "Docker limpo!"