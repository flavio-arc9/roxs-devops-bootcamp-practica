#!/bin/bash

# System check script para DevOps Bootcamp Day 1
echo "🔍 Ejecutando verificación del sistema..."

# Colores
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "${BLUE}💻 INFORMACIÓN DEL SISTEMA${NC}"
echo "=========================================="
echo "🖥️  SO: $(cat /etc/os-release | grep PRETTY_NAME | cut -d'"' -f2)"
echo "🏗️  Arquitectura: $(uname -m)"
echo "⚡ Kernel: $(uname -r)"
echo "📅 Fecha: $(date)"
echo

echo -e "${BLUE}📊 RECURSOS DEL SISTEMA${NC}"
echo "=========================================="
echo "💾 Memoria:"
free -h
echo
echo "💽 Disco:"
df -h /
echo
echo "⚙️  CPU:"
nproc --all | xargs -I {} echo "Cores disponibles: {}"
top -bn1 | grep "Cpu(s)" | cut -d',' -f1 | cut -d':' -f2 | xargs echo "Uso CPU:"
echo

echo -e "${BLUE}🔧 HERRAMIENTAS INSTALADAS${NC}"
echo "=========================================="

# Función para verificar herramientas
check_tool() {
  local tool=$1
  local cmd=$2
  if command -v $tool > /dev/null 2>&1; then
    local version=$($cmd 2>/dev/null | head -n1)
    echo -e "${GREEN}✅ $tool: $version${NC}"
  else
    echo -e "${RED}❌ $tool: No instalado${NC}"
  fi
}

check_tool "git" "git --version"
check_tool "docker" "docker --version"
check_tool "node" "node --version"
check_tool "npm" "npm --version"
check_tool "curl" "curl --version"
check_tool "wget" "wget --version"
check_tool "python3" "python3 --version"

echo

echo -e "${BLUE}🐳 ESTADO DE DOCKER${NC}"
echo "=========================================="
if systemctl is-active --quiet docker 2>/dev/null || pgrep dockerd > /dev/null; then
  echo -e "${GREEN}✅ Docker daemon está corriendo${NC}"
  echo "📦 Imágenes Docker:"
  docker images --format "table {{.Repository}}\t{{.Tag}}\t{{.Size}}" | head -10
  echo
  echo "🏃 Contenedores activos:"
  docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"
else
  echo -e "${RED}❌ Docker daemon no está corriendo${NC}"
fi

echo

echo -e "${BLUE}🌐 CONECTIVIDAD DE RED${NC}"
echo "=========================================="
echo "🔍 Probando conectividad..."

# Test de conectividad local
if curl -s http://localhost:4000/health > /dev/null 2>&1; then
  echo -e "${GREEN}✅ Aplicación local accesible${NC}"
else
  echo -e "${YELLOW}⚠️  Aplicación local no responde${NC}"
fi

# Test de conectividad externa
if ping -c 1 google.com > /dev/null 2>&1; then
  echo -e "${GREEN}✅ Conectividad externa OK${NC}"
else
  echo -e "${RED}❌ Sin conectividad externa${NC}"
fi

echo

echo -e "${BLUE}📁 ESTRUCTURA DEL PROYECTO${NC}"
echo "=========================================="
if command -v tree > /dev/null 2>&1; then
  tree -L 2 -a
else
  find . -maxdepth 2 -type f | sort
fi

echo
echo -e "${GREEN}🎉 Verificación del sistema completada${NC}"