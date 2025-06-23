# 🚀 DevOps Bootcamp - Day 1 Practice

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

- Acceso a [Google Cloud Shell](https://ssh.cloud.google.com/cloudshell/editor?cloudshell_git_repo=https://github.com/roxsross/devops-bootcamp-day1.git&cloudshell_tutorial=tutorial.md&shellonly=true)
- ¡Ganas de aprender DevOps!

### Instalación

1. **Clona el repositorio:**
   ```bash
   git clone https://github.com/roxsross/devops-bootcamp-day1.git
   cd devops-bootcamp-day1
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
   curl http://localhost:3000/health
   ```

## 🐳 Uso con Docker

### Construir y ejecutar

```bash
# Construir imagen
docker build -t mi-app-devops:v1.0 .

# Ejecutar contenedor
docker run -d -p 3000:3000 --name mi-app mi-app-devops:v1.0

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
curl http://localhost:3000/health
curl http://localhost:3000/api/stats
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

## 🎓 Ejercicios de Aprendizaje

### Nivel Principiante
1. Modifica el mensaje de bienvenida en `public/index.html`
2. Añade un nuevo endpoint `/api/version` que devuelva la versión
3. Cambia el puerto de la aplicación a 8080

### Nivel Intermedio
4. Añade variables de entorno para configuración
5. Implementa logging más detallado
6. Crea un endpoint `/api/team` con información de tu equipo

### Nivel Avanzado
7. Añade persistencia con un archivo JSON
8. Implementa rate limiting básico
9. Crea tests más robustos con assertions

## 🐛 Troubleshooting

### Error: Puerto ya en uso
```bash
# Encuentra el proceso usando el puerto
lsof -i :3000

# O mata todos los procesos Node.js
pkill node
```

### Error: Docker no responde
```bash
# Reinicia Docker (en Cloud Shell)
sudo service docker restart

# O limpia contenedores
docker system prune -f
```

### Error: Permisos en scripts
```bash
# Da permisos de ejecución
chmod +x scripts/*.sh
```

---

**¡Feliz aprendizaje y bienvenido al mundo DevOps!** 🚀

> *"El viaje de mil millas comienza con un solo paso."* - Lao Tzu