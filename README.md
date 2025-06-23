# 🚀 DevOps Bootcamp - Day 1 Practice

![](https://media.licdn.com/dms/image/v2/D4D16AQF4ND-cC_uxZg/profile-displaybackgroundimage-shrink_350_1400/profile-displaybackgroundimage-shrink_350_1400/0/1731367727725?e=1753920000&v=beta&t=80SZ4IOx4V_VDcCBli7aFjYuMhzMos9SRFq8GnV8zc4)

[![Docker](https://img.shields.io/badge/Docker-Ready-blue?logo=docker)](https://docker.com)
[![Node.js](https://img.shields.io/badge/Node.js-Worker-green?logo=node.js)](https://nodejs.org)
[![Node.js](https://img.shields.io/badge/Node.js-Result-green?logo=node.js)](https://nodejs.org)
[![Flask](https://img.shields.io/badge/Flask-Vote-lightgrey?logo=flask)](https://flask.palletsprojects.com/)
[![Redis](https://img.shields.io/badge/Redis-Cache-red?logo=redis)](https://redis.io)
[![PostgreSQL](https://img.shields.io/badge/PostgreSQL-Database-blue?logo=postgresql)](https://postgresql.org)
[![Prometheus](https://img.shields.io/badge/Prometheus-Monitoring-orange?logo=prometheus)](https://prometheus.io)
[![Grafana](https://img.shields.io/badge/Grafana-Visualization-orange?logo=grafana)](https://grafana.com)



¡Bienvenido a tu primera experiencia práctica con DevOps! Este repositorio contiene una aplicación web completa diseñada para que aprendas los conceptos fundamentales de DevOps de manera práctica.

## 🎯 Objetivos de Aprendizaje

Al completar este laboratorio habrás experimentado:

- **Desarrollo de aplicaciones** con Node.js y Express
- **Containerización** con Docker
- **Automatización** con scripts de Bash
- **Control de versiones** con Git
- **Monitoreo y observabilidad** básica
- **Pipeline de CI/CD** simulado
- **Gestión de infraestructura** básica

## 🏗️ Estructura del Proyecto

```
devops-bootcamp-day1/
├── app.js                 # Aplicación principal Node.js
├── package.json           # Dependencias y scripts npm
├── Dockerfile            # Imagen de contenedor
├── public/
│   └── index.html        # Frontend de la aplicación
├── scripts/              # Scripts de automatización
│   ├── deploy.sh         # Script de deployment
│   ├── test.sh           # Suite de tests
│   ├── cleanup.sh        # Limpieza del entorno
│   ├── monitor.sh        # Monitoreo en tiempo real
│   ├── system-check.sh   # Verificación del sistema
│   └── full-pipeline.sh  # Pipeline completo CI/CD
├── test.js               # Tests unitarios básicos
└── README.md             # Esta documentación
```

## 🚀 Inicio Rápido

### Prerequisitos
- Acceso a [![Open in Cloud Shell](https://gstatic.com/cloudssh/images/open-btn.svg)](https://ssh.cloud.google.com/cloudshell/editor?cloudshell_git_repo=https://github.com/roxsross/roxs-devops-bootcamp-practica.git&cloudshell_tutorial=TUTORIAL.md&shellonly=true)
- ¡Ganas de aprender DevOps!

### Instalación

1. **Clona el repositorio:**
   ```bash
   git clone https://github.com/roxsross/roxs-devops-bootcamp-practica.git
   cd roxs-devops-bootcamp-practica
   ```

2. **Instala dependencias:**
   ```bash
   npm install
   ```

3. **Ejecuta la aplicación:**
   ```bash
   npm start
   ```

4. **Verifica que funciona:**
   ```bash
   curl http://localhost:4000/health
   ```

## 🐳 Uso con Docker

### Construir y ejecutar

```bash
# Construir imagen
docker build -t mi-app-devops:v1.0 .

# Ejecutar contenedor
docker run -d -p 4000:4000 --name mi-app mi-app-devops:v1.0

# Verificar logs
docker logs mi-app
```

### Usando scripts automatizados

```bash
# Deployment completo
./scripts/deploy.sh

# Ejecutar tests
./scripts/test.sh

# Monitoreo en tiempo real
./scripts/monitor.sh

# Pipeline completo
./scripts/full-pipeline.sh
```

## 🔗 Endpoints de la API

- `GET /` - Página principal de la aplicación
- `GET /health` - Health check de la aplicación
- `GET /api/stats` - Estadísticas y métricas
- `GET /api/error` - Endpoint para simular errores
- `GET /api/slow` - Endpoint con respuesta lenta (2s)

## 📊 Monitoreo

La aplicación incluye métricas básicas:

- Total de requests recibidos
- Número de errores
- Tiempo de uptime
- Uso de memoria del proceso
- Timestamps de todas las operaciones

## 🧪 Testing

```bash
# Tests unitarios
npm test

# Tests de integración
./scripts/test.sh

# Tests de endpoints (con app corriendo)
curl http://localhost:4000/health
curl http://localhost:4000/api/stats
```

## 🛠️ Scripts Disponibles

| Script | Descripción |
|--------|-------------|
| `./scripts/deploy.sh` | Deployment automatizado con Docker |
| `./scripts/test.sh` | Suite completa de tests |
| `./scripts/cleanup.sh` | Limpieza del entorno |
| `./scripts/monitor.sh` | Monitoreo en tiempo real |
| `./scripts/system-check.sh` | Verificación del sistema |
| `./scripts/full-pipeline.sh` | Pipeline completo CI/CD |


---

**¡Feliz aprendizaje y bienvenido al mundo DevOps!** 🚀

> *"El viaje de mil millas comienza con un solo paso."* - Lao Tzu

Roadmap que recomiendo seguir [DevOps](https://roadmap.sh/devops)


## 👨‍💻 Autor

**roxsross** - Instructor DevOps y Cloud

- 🐦 Twitter: [@roxsross](https://twitter.com/roxsross)
- 🔗 LinkedIn: [roxsross](https://linkedin.com/in/roxsross)
- ☕ Ko-fi [roxsross](https://ko-fi.com/roxsross)
- ▶️ Youtube [295devops](https://www.youtube.com/@295devops)
- 📧 Email: roxs@295devops.com


