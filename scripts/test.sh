#!/bin/bash

# Script de testing para DevOps Bootcamp Day 1
set -e

echo "🧪 Ejecutando tests para DevOps Bootcamp Day 1..."

# Colores
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

# Variables
APP_URL="http://localhost:3000"
TESTS_PASSED=0
TESTS_FAILED=0

# Función para test
run_test() {
  local test_name="$1"
  local test_command="$2"
  local expected_status="$3"
  
  echo -e "${BLUE}🔍 Testing: ${test_name}${NC}"
  
  if eval "$test_command"; then
    echo -e "${GREEN}✅ PASS: ${test_name}${NC}"
    ((TESTS_PASSED++))
  else
    echo -e "${RED}❌ FAIL: ${test_name}${NC}"
    ((TESTS_FAILED++))
  fi
  echo
}

echo -e "${YELLOW}📋 Iniciando suite de tests...${NC}"
echo

# Test 1: Verificar que Node.js está instalado
run_test "Node.js instalado" "node --version > /dev/null 2>&1"

# Test 2: Verificar que npm está instalado  
run_test "npm instalado" "npm --version > /dev/null 2>&1"

# Test 3: Verificar que Docker está instalado
run_test "Docker instalado" "docker --version > /dev/null 2>&1"

# Test 4: Verificar dependencias del proyecto
run_test "Dependencias instaladas" "test -d node_modules && test -f node_modules/express/package.json"

# Test 5: Verificar archivos principales
run_test "Archivo app.js existe" "test -f app.js"
run_test "Archivo package.json existe" "test -f package.json"
run_test "Dockerfile existe" "test -f Dockerfile"

# Test 6: Sintaxis de JavaScript
run_test "Sintaxis JavaScript válida" "node -c app.js"

# Test 7: Test de construcción de Docker
run_test "Docker build exitoso" "docker build -t test-app:latest . > /dev/null 2>&1"

# Si hay una aplicación corriendo, hacer tests de endpoints
if curl -s ${APP_URL}/health > /dev/null 2>&1; then
  echo -e "${BLUE}🌐 Aplicación detectada corriendo, ejecutando tests de endpoints...${NC}"
  
  # Test de endpoint principal
  run_test "Endpoint principal responde" "curl -s ${APP_URL} | grep -q 'DevOps Bootcamp'"
  
  # Test de health check
  run_test "Health check responde OK" "curl -s ${APP_URL}/health | grep -q '\"status\":\"OK\"'"
  
  # Test de stats
  run_test "Stats endpoint responde" "curl -s ${APP_URL}/api/stats | grep -q 'totalRequests'"
  
  # Test de código de respuesta
  run_test "Status code 200 en /" "test \$(curl -s -o /dev/null -w '%{http_code}' ${APP_URL}) -eq 200"
  
  # Test de endpoint de error
  run_test "Error endpoint responde 500" "test \$(curl -s -o /dev/null -w '%{http_code}' ${APP_URL}/api/error) -eq 500"
  
else
  echo -e "${YELLOW}⚠️  No se detectó aplicación corriendo, saltando tests de endpoints${NC}"
fi

# Cleanup de imagen de test
docker rmi test-app:latest > /dev/null 2>&1 || true

# Resumen
echo "===========================================" 
echo -e "${BLUE}📊 RESUMEN DE TESTS${NC}"
echo "==========================================="
echo -e "${GREEN}✅ Tests passed: ${TESTS_PASSED}${NC}"
echo -e "${RED}❌ Tests failed: ${TESTS_FAILED}${NC}"
echo "Total tests: $((TESTS_PASSED + TESTS_FAILED))"

if [ $TESTS_FAILED -eq 0 ]; then
  echo -e "${GREEN}🎉 ¡Todos los tests pasaron! Tu aplicación está lista.${NC}"
  exit 0
else
  echo -e "${RED}💥 Algunos tests fallaron. Revisa los errores arriba.${NC}"
  exit 1
fi