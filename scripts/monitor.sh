#!/bin/bash

# Script de monitoreo para DevOps Bootcamp Day 1
echo "📊 Iniciando monitoreo de la aplicación DevOps Bootcamp..."

# Colores
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

# Variables
APP_URL="http://localhost:4000"
CONTAINER_NAME="mi-app-prod"
MONITOR_INTERVAL=5

# Función para obtener timestamp
timestamp() {
  date '+%Y-%m-%d %H:%M:%S'
}

# Función para verificar salud de la aplicación
check_health() {
  local status_code=$(curl -s -o /dev/null -w "%{http_code}" ${APP_URL}/health 2>/dev/null)
  if [ "$status_code" = "200" ]; then
    echo -e "${GREEN}✅ [$(timestamp)] Aplicación saludable (HTTP $status_code)${NC}"
    return 0
  else
    echo -e "${RED}❌ [$(timestamp)] Aplicación con problemas (HTTP $status_code)${NC}"
    return 1
  fi
}

# Función para obtener métricas
get_metrics() {
  local metrics=$(curl -s ${APP_URL}/api/stats 2>/dev/null)
  if [ $? -eq 0 ]; then
    local requests=$(echo $metrics | grep -o '"totalRequests":[0-9]*' | cut -d':' -f2)
    local errors=$(echo $metrics | grep -o '"totalErrors":[0-9]*' | cut -d':' -f2)
    local uptime=$(echo $metrics | grep -o '"uptime":[0-9]*' | cut -d':' -f2)
    local uptime_seconds=$((uptime / 1000))
    
    echo -e "${BLUE}📈 [$(timestamp)] Total Requests: $requests | Errors: $errors | Uptime: ${uptime_seconds}s${NC}"
  else
    echo -e "${RED}📈 [$(timestamp)] No se pudieron obtener métricas${NC}"
  fi
}

# Función para obtener stats del contenedor
get_container_stats() {
  if docker ps | grep -q ${CONTAINER_NAME}; then
    local stats=$(docker stats ${CONTAINER_NAME} --no-stream --format "table {{.CPUPerc}}\t{{.MemUsage}}" | tail -n 1)
    echo -e "${YELLOW}🐳 [$(timestamp)] Container Stats: $stats${NC}"
  else
    echo -e "${RED}🐳 [$(timestamp)] Contenedor no encontrado${NC}"
  fi
}

# Función para verificar logs de errores
check_error_logs() {
  if docker ps | grep -q ${CONTAINER_NAME}; then
    local error_count=$(docker logs ${CONTAINER_NAME} --since=30s 2>/dev/null | grep -c "ERROR" 2>/dev/null || echo "0")
    if [ "$error_count" > 0 ]; then
      echo -e "${RED}🚨 [$(timestamp)] Se detectaron $error_count errores en los últimos 30s${NC}"
      docker logs ${CONTAINER_NAME} --since=30s 2>/dev/null | grep "ERROR" | tail -3
    fi
  fi
}

echo -e "${BLUE}🎯 Monitoreo iniciado cada $MONITOR_INTERVAL segundos${NC}"
echo -e "${YELLOW}💡 Presiona Ctrl+C para detener${NC}"
echo "=========================================="

# Loop principal de monitoreo
while true; do
  check_health
  get_metrics
  get_container_stats
  check_error_logs
  echo "----------------------------------------"
  sleep $MONITOR_INTERVAL
done
