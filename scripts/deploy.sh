#!/bin/bash

# Deploy script para DevOps Bootcamp Day 1
set -e  # Exit on error

echo "🚀 Iniciando deployment de la aplicación DevOps Bootcamp Day 1..."

# Colores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Variables
APP_NAME="mi-app-devops"
VERSION="v1.0"
CONTAINER_NAME="mi-app-prod"
PORT=4000

echo -e "${BLUE}📦 Paso 1: Construyendo imagen Docker...${NC}"
docker build -t ${APP_NAME}:${VERSION} .

echo -e "${BLUE}🔍 Paso 2: Verificando imagen...${NC}"
docker images | grep ${APP_NAME}

echo -e "${BLUE}🛑 Paso 3: Deteniendo contenedor anterior (si existe)...${NC}"
docker stop ${CONTAINER_NAME} 2>/dev/null || echo "No hay contenedor previo corriendo"
docker rm ${CONTAINER_NAME} 2>/dev/null || echo "No hay contenedor previo para eliminar"

echo -e "${BLUE}🚀 Paso 4: Desplegando nueva versión...${NC}"
docker run -d \
  --name ${CONTAINER_NAME} \
  --restart unless-stopped \
  -p ${PORT}:${PORT} \
  ${APP_NAME}:${VERSION}

echo -e "${BLUE}⏳ Paso 5: Esperando que la aplicación esté lista...${NC}"
sleep 5

echo -e "${BLUE}🏥 Paso 6: Verificando health check...${NC}"
for i in {1..10}; do
  if curl -s http://localhost:${PORT}/health > /dev/null; then
    echo -e "${GREEN}✅ Aplicación desplegada exitosamente!${NC}"
    echo -e "${GREEN}🌐 Accede a: http://localhost:${PORT}${NC}"
    echo -e "${GREEN}🏥 Health check: http://localhost:${PORT}/health${NC}"
    echo -e "${GREEN}📊 Stats: http://localhost:${PORT}/api/stats${NC}"
    exit 0
  fi
  echo "Intento $i/10 - Esperando..."
  sleep 2
done

echo -e "${RED}❌ Error: La aplicación no responde después de 20 segundos${NC}"
echo -e "${YELLOW}📋 Logs del contenedor:${NC}"
docker logs ${CONTAINER_NAME}
exit 1