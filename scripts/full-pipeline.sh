#!/bin/bash

# Pipeline completo de CI/CD para DevOps Bootcamp Day 1
set -e

echo "🚀 Ejecutando pipeline completo de CI/CD..."

# Colores
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
NC='\033[0m'

# Variables
START_TIME=$(date +%s)
PIPELINE_ID="pipeline-$(date +%Y%m%d-%H%M%S)"

echo -e "${PURPLE}===========================================${NC}"
echo -e "${PURPLE}🏭 DEVOPS BOOTCAMP CI/CD PIPELINE${NC}"
echo -e "${PURPLE}Pipeline ID: $PIPELINE_ID${NC}"
echo -e "${PURPLE}===========================================${NC}"

# Stage 1: Code Quality & Testing
echo -e "${BLUE}📋 STAGE 1: CODE QUALITY & TESTING${NC}"
echo "-------------------------------------------"

echo "🧪 Ejecutando tests unitarios..."
if ! ./scripts/test.sh; then
  echo -e "${RED}❌ Tests fallaron. Pipeline abortado.${NC}"
  exit 1
fi

echo "🔍 Verificando estructura del código..."
if [ ! -f "app.js" ] || [ ! -f "package.json" ] || [ ! -f "Dockerfile" ]; then
  echo -e "${RED}❌ Archivos esenciales faltantes${NC}"
  exit 1
fi

echo "✅ Verificando sintaxis JavaScript..."
node -c app.js

echo -e "${GREEN}✅ Stage 1 completado${NC}"
echo

# Stage 2: Build & Security Scan
echo -e "${BLUE}📦 STAGE 2: BUILD & SECURITY SCAN${NC}"
echo "-------------------------------------------"

echo "🏗️  Construyendo imagen Docker..."
docker build -t mi-app-devops:pipeline-${PIPELINE_ID} .

echo "🔒 Ejecutando security scan básico..."
# Simulamos un security scan básico
if docker run --rm -i hadolint/hadolint < Dockerfile > /dev/null 2>&1; then
  echo -e "${GREEN}✅ Security scan passed${NC}"
else
  echo -e "${YELLOW}⚠️  Security scan warnings (continuando...)${NC}"
fi

echo "📊 Analizando tamaño de imagen..."
IMAGE_SIZE=$(docker images mi-app-devops:pipeline-${PIPELINE_ID} --format "{{.Size}}")
echo "Image size: $IMAGE_SIZE"

echo -e "${GREEN}✅ Stage 2 completado${NC}"
echo

# Stage 3: Deploy to Staging
echo -e "${BLUE}🎭 STAGE 3: DEPLOY TO STAGING${NC}"
echo "-------------------------------------------"

echo "🚀 Desplegando a staging..."
docker stop mi-app-staging 2>/dev/null || true
docker rm mi-app-staging 2>/dev/null || true

docker run -d \
  --name mi-app-staging \
  -p 3001:3000 \
  mi-app-devops:pipeline-${PIPELINE_ID}

echo "⏳ Esperando que staging esté listo..."
sleep 8

echo "🧪 Ejecutando smoke tests en staging..."
STAGING_URL="http://localhost:3001"

# Smoke tests
for endpoint in "/" "/health" "/api/stats"; do
  echo "Testing $endpoint..."
  if curl -f -s ${STAGING_URL}${endpoint} > /dev/null; then
    echo -e "${GREEN}✅ $endpoint OK${NC}"
  else
    echo -e "${RED}❌ $endpoint FAILED${NC}"
    echo "Pipeline abortado - Staging tests fallaron"
    exit 1
  fi
done

echo -e "${GREEN}✅ Stage 3 completado${NC}"
echo

# Stage 4: Production Deployment
echo -e "${BLUE}🏭 STAGE 4: PRODUCTION DEPLOYMENT${NC}"
echo "-------------------------------------------"

echo "🎯 Desplegando a producción..."

# Blue-Green deployment simulation
echo "🔄 Implementando Blue-Green deployment..."

# Green (nueva versión)
docker stop mi-app-prod 2>/dev/null || true
docker rm mi-app-prod 2>/dev/null || true

docker run -d \
  --name mi-app-prod \
  --restart unless-stopped \
  -p 3000:3000 \
  mi-app-devops:pipeline-${PIPELINE_ID}

echo "⏳ Verificando deployment en producción..."
sleep 5

# Health checks en producción
PROD_URL="http://localhost:3000"
for i in {1..5}; do
  if curl -f -s ${PROD_URL}/health > /dev/null; then
    echo -e "${GREEN}✅ Producción saludable${NC}"
    break
  fi
  if [ $i -eq 5 ]; then
    echo -e "${RED}❌ Health check falló en producción${NC}"
    exit 1
  fi
  echo "Intento $i/5..."
  sleep 2
done

echo -e "${GREEN}✅ Stage 4 completado${NC}"
echo

# Stage 5: Post-Deployment
echo -e "${BLUE}🔍 STAGE 5: POST-DEPLOYMENT MONITORING${NC}"
echo "-------------------------------------------"

echo "📊 Verificando métricas post-deployment..."

# Generar algo de tráfico para métricas
echo "🚦 Generando tráfico de prueba..."
for i in {1..10}; do
  curl -s ${PROD_URL} > /dev/null &
  curl -s ${PROD_URL}/health > /dev/null &
  curl -s ${PROD_URL}/api/stats > /dev/null &
done
wait

sleep 3

# Verificar métricas
METRICS=$(curl -s ${PROD_URL}/api/stats)
REQUESTS=$(echo $METRICS | grep -o '"totalRequests":[0-9]*' | cut -d':' -f2)
ERRORS=$(echo $METRICS | grep -o '"totalErrors":[0-9]*' | cut -d':' -f2)

echo "📈 Total requests: $REQUESTS"
echo "❌ Total errors: $ERRORS"

if [ "$ERRORS" -gt 5 ]; then
  echo -e "${RED}❌ Demasiados errores detectados${NC}"
  exit 1
fi

echo "🧹 Limpiando recursos temporales..."
docker stop mi-app-staging 2>/dev/null || true
docker rm mi-app-staging 2>/dev/null || true
docker rmi mi-app-devops:pipeline-${PIPELINE_ID} 2>/dev/null || true

echo -e "${GREEN}✅ Stage 5 completado${NC}"

# Pipeline Summary
END_TIME=$(date +%s)
DURATION=$((END_TIME - START_TIME))

echo
echo -e "${PURPLE}===========================================${NC}"
echo -e "${PURPLE}🎉 PIPELINE COMPLETADO EXITOSAMENTE${NC}"
echo -e "${PURPLE}===========================================${NC}"
echo -e "${GREEN}Pipeline ID: $PIPELINE_ID${NC}"
echo -e "${GREEN}Duración total: ${DURATION}s${NC}"
echo -e "${GREEN}Aplicación desplegada en: ${PROD_URL}${NC}"
echo -e "${GREEN}Health check: ${PROD_URL}/health${NC}"
echo -e "${GREEN}Métricas: ${PROD_URL}/api/stats${NC}"
echo

echo -e "${BLUE}📋 RESUMEN DE STAGES:${NC}"
echo "✅ Code Quality & Testing"
echo "✅ Build & Security Scan"  
echo "✅ Deploy to Staging"
echo "✅ Production Deployment"
echo "✅ Post-Deployment Monitoring"

echo
echo -e "${YELLOW}🎯 ¡Felicitaciones! Has completado tu primer pipeline de CI/CD${NC}"