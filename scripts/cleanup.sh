#!/bin/bash

# Cleanup script para DevOps Bootcamp Day 1
echo "🧹 Iniciando limpieza del entorno DevOps Bootcamp..."

# Colores
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

# Variables
APP_NAME="mi-app-devops"
CONTAINER_NAME="mi-app-prod"

echo -e "${BLUE}🛑 Deteniendo contenedores...${NC}"
docker stop ${CONTAINER_NAME} 2>/dev/null || echo "No hay contenedor corriendo"
docker stop mi-app 2>/dev/null || echo "No hay contenedor mi-app corriendo"

echo -e "${BLUE}🗑️  Eliminando contenedores...${NC}"
docker rm ${CONTAINER_NAME} 2>/dev/null || echo "No hay contenedor ${CONTAINER_NAME} para eliminar"
docker rm mi-app 2>/dev/null || echo "No hay contenedor mi-app para eliminar"

echo -e "${BLUE}🖼️  Eliminando imágenes...${NC}"
docker rmi ${APP_NAME}:v1.0 2>/dev/null || echo "No hay imagen v1.0 para eliminar"
docker rmi ${APP_NAME}:v2.0-buggy 2>/dev/null || echo "No hay imagen v2.0-buggy para eliminar"
docker rmi test-app:latest 2>/dev/null || echo "No hay imagen test-app para eliminar"

echo -e "${BLUE}🧽 Limpiando imágenes huérfanas...${NC}"
docker image prune -f

echo -e "${BLUE}📁 Limpiando archivos temporales...${NC}"
rm -f *.log
rm -f .env.local
rm -rf node_modules/.cache 2>/dev/null || true

echo -e "${GREEN}✅ Limpieza completada!${NC}"
echo -e "${YELLOW}💡 Para reinstalar dependencias: npm install${NC}"
echo -e "${YELLOW}💡 Para rebuilding: ./scripts/deploy.sh${NC}"
