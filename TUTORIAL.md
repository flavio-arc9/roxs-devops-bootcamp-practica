# 🚀 TUTORIAL COMPLETO - Mi Primera Experiencia DevOps by Roxs

## 📖 Guía paso a paso para el Bootcamp DevOps Day 1

> **Dificultad:** Principiante  
> **Requisitos:** Solo una cuenta de Google


## 🎯 ¿Qué vas a lograr hoy?

Al finalizar este tutorial habrás:
- ✅ Desplegado tu primera aplicación web
- ✅ Creado y gestionado contenedores Docker
- ✅ Automatizado procesos con scripts
- ✅ Implementado monitoreo básico
- ✅ Ejecutado un pipeline de CI/CD completo
- ✅ Experimentado el rol completo de un DevOps Engineer

**¡Empecemos!** 🚀

---

## 🌟 PARTE 0: Introducción y Contexto

### ¿Qué es DevOps? (En palabras simples)

DevOps es como ser el **"traductor universal"** entre los desarrolladores que crean aplicaciones y los equipos que las mantienen funcionando en producción. 

**Imagínalo así:**
- **Desarrollador:** "Hice una app genial en mi laptop"
- **Operaciones:** "¿Cómo la pongo en 100 servidores sin que explote?"
- **DevOps Engineer:** "Tranquilos, yo tengo la solución automatizada" 😎

### Lo que harás hoy paso a paso:

1. **Desarrollar** - Modificar una aplicación web
2. **Containerizar** - Empaquetarla para que funcione en cualquier lugar  
3. **Automatizar** - Crear scripts que hagan el trabajo por ti
4. **Monitorear** - Vigilar que todo funcione bien
5. **Desplegar** - Poner la aplicación en "producción"
6. **Gestionar** - Resolver problemas como un pro

---

## 🏗️ PARTE 1: Configurando nuestro entorno 

### Paso 1: Acceder a Cloud Shell

1. **Abre tu navegador** y ve a: [![Open in Cloud Shell](https://gstatic.com/cloudssh/images/open-btn.svg)](https://ssh.cloud.google.com/cloudshell/editor?cloudshell_git_repo=https://github.com/roxsross/roxs-devops-bootcamp-practica.git&cloudshell_tutorial=TUTORIAL.md&shellonly=true)

2. **Autoriza el acceso** cuando Google te lo pida
   - Usa tu cuenta de Gmail personal
   - Acepta los términos y condiciones

3. **¡Boom!** 💥 Ya tienes un entorno Linux completo en tu navegador
   - Es gratis
   - Tiene todas las herramientas preinstaladas
   - No necesitas instalar nada en tu computadora

### Paso 2: Explorar tu nuevo entorno

```bash
# ¿Dónde estoy?

pwd

# ¿Qué hay aquí?

ls -la

# Explora la estructura del proyecto

tree . || find . -type f
```

**🤔 Momento de reflexión:** *¿Te das cuenta? Acabas de acceder a una computadora en la nube desde tu navegador. ¡Eso es infraestructura moderna!*

### Paso 3: Conoce tu "computadora en la nube"

```bash
# ¿Qué sistema operativo tienes?
cat /etc/os-release

# ¿Qué herramientas están disponibles?
echo "🔧 Herramientas DevOps disponibles:"
which git && echo "✅ Git - Control de versiones"
which docker && echo "✅ Docker - Contenedores"  
which node && echo "✅ Node.js - Runtime JavaScript"
which npm && echo "✅ npm - Gestor de paquetes"
which curl && echo "✅ curl - Cliente HTTP"
which python3 && echo "✅ Python - Scripting"

# ¿Cuántos recursos tienes?
echo "💾 Memoria disponible:"
free -h
echo "💽 Espacio en disco:"
df -h
echo "⚙️ CPUs disponibles:"
nproc
```

**💡 Pro tip:** Esta es exactamente la información que un DevOps Engineer verifica cuando accede a un servidor nuevo.

---

## 💻 PARTE 2: Explorando y ejecutando la aplicación 

### Paso 4: Descubre qué tipo de aplicación tienes

```bash
# ¿Qué tipo de aplicación es?

cat package.json

# Ve el código principal

cat app.js

# Revisa la página web

cat public/index.html

```

**🎯 Desafío rápido:** Sin ejecutar nada aún, ¿puedes adivinar qué hace esta aplicación? 🤔

### Paso 5: Instala las dependencias y ejecuta la app

```bash
# Instala las dependencias (como descargar las librerías que necesita)

npm install

# ¿Qué se instaló?

ls node_modules/ | head -5

# Ejecuta la aplicación

echo "🚀 Iniciando aplicación..."

npm start
```

**¡Tu aplicación ya está corriendo!** 🎉

### Paso 6: Prueba tu aplicación (En una nueva terminal)

```bash
# Abre una nueva terminal: Ctrl+Shift+T o usa el botón "+"

# Prueba la página principal

curl http://localhost:4000

# Prueba el health check (muy importante en DevOps)

curl http://localhost:4000/health

# Ve las estadísticas de tu app

curl http://localhost:4000/api/stats

# Simula un error (para ver qué pasa)

curl http://localhost:4000/api/error

# Prueba una respuesta lenta

curl http://localhost:4000/api/slow
```

### Paso 7: Haz tu primera modificación

```bash
# En la terminal donde NO está corriendo la app (Ctrl+C para detenerla si es necesario)

# Modifica el mensaje de bienvenida

sed -i 's/¡Bienvenido a DevOps Bootcamp!/¡Hola [TU NOMBRE], bienvenido a DevOps!/' public/index.html

# Verifica el cambio

grep "Hola" public/index.html

# Reinicia la aplicación

npm start
```

```bash
# En la otra terminal, verifica tu cambio

curl http://localhost:4000 | grep "Hola"
```

**🎉 ¡Felicitaciones!** Acabas de hacer tu primera modificación y despliegue manual.

**🤔 Reflexión:** *¿Te imaginas hacer esto manualmente en 100 servidores? Por eso existe DevOps.*

---

## 🐳 PARTE 3: Containerización con Docker 

### ¿Por qué Docker?

**Problema típico:**
- Desarrollador: "En mi máquina funciona perfectamente"
- Servidor de producción: "Error, error, error" 💥

**Solución Docker:**
- "Empaqueto toda mi aplicación + todas sus dependencias en un contenedor"
- "Ahora funciona igual en mi laptop, en el servidor y en la luna" 🌙

### Paso 8: Inspecciona el Dockerfile

```bash
# Ve cómo se "empaqueta" tu aplicación

cat Dockerfile
```

**Explicación línea por línea:**
```dockerfile
FROM node:18-alpine          # Usa una imagen base con Node.js
WORKDIR /app                 # Directorio de trabajo dentro del contenedor
COPY package*.json ./        # Copia archivos de dependencias
RUN npm ci --only=production # Instala dependencias de producción
COPY . .                     # Copia el resto del código
EXPOSE 4000                  # El contenedor escucha en puerto 4000
CMD ["npm", "start"]         # Comando que ejecuta cuando inicia
```

### Paso 9: Construye tu primera imagen Docker

```bash
# Detén la aplicación si sigue corriendo (Ctrl+C)

# Construye la imagen (esto puede tardar un minuto)

echo "🏗️ Construyendo imagen Docker..."

docker build -t mi-app-devops:v1.0 .

# Ve tu imagen recién creada

docker images mi-app-devops
```

**🎉 ¡Ya tienes tu aplicación empaquetada!**

### Paso 10: Ejecuta tu aplicación en contenedor

```bash
# Ejecuta el contenedor

echo "🚀 Ejecutando contenedor..."

docker run -d -p 4000:4000 --name mi-app mi-app-devops:v1.0

# Verifica que esté corriendo
docker ps

# Prueba que funciona
curl http://localhost:4000/health
```

### Paso 11: Gestiona tu contenedor como un pro

```bash
# Ve los logs de tu aplicación
echo "📋 Logs de la aplicación:"

docker logs mi-app

# Accede DENTRO del contenedor (como SSH)
echo "🔍 Entrando al contenedor..."

docker exec -it mi-app sh

# Dentro del contenedor, explora:

ps aux              # ¿Qué procesos corren?
ls -la             # ¿Qué archivos hay?
cat /etc/os-release # ¿Qué OS tiene?
exit               # Sal del contenedor

# Información del contenedor

docker inspect mi-app --format='{{.State.Status}}'
```

### Paso 12: Simula un problema y resuélvelo

```bash
# "Ups, algo se rompió" - detén el contenedor

docker stop mi-app

# Verifica que no responde

curl http://localhost:4000/health || echo "💥 App no responde"

# ¡Arréglalo rápido! (esto es un rollback)

docker start mi-app

# Verifica que ya funciona

curl http://localhost:4000/health && echo "✅ App restaurada"
```

**💪 ¡Acabas de hacer tu primer incident response!**

---

## 🔄 PARTE 4: Automatización con Scripts 

### ¿Por qué automatizar?

**Humano haciendo despliegue manual:**
- 45 minutos
- 12 pasos
- 3 errores
- 1 café derramado ☕
- Estrés nivel 9000

**Script automatizado:**
- 2 minutos
- 0 errores
- Puedes tomar café tranquilo ☕😌

### Paso 13: Explora los scripts disponibles

```bash
# Ve qué scripts tienes disponibles

ls scripts/

# Inspecciona cada script

echo "🔍 Script de deployment:"
head -20 scripts/deploy.sh

echo "🔍 Script de testing:"
head -20 scripts/test.sh

echo "🔍 Script de limpieza:"
head -10 scripts/cleanup.sh
```

### Paso 14: Haz los scripts ejecutables

```bash
# Dale permisos de ejecución a todos los scripts

chmod +x scripts/*.sh

# Verifica los permisos

ls -la scripts/
```

### Paso 15: Ejecuta tu primer pipeline automatizado

```bash
# Primero, limpia el entorno anterior

docker stop mi-app 2>/dev/null || true
docker rm mi-app 2>/dev/null || true

# Ejecuta el script de testing

echo "🧪 Ejecutando tests..."
./scripts/test.sh

# Si los tests pasan, ejecuta el deployment

echo "🚀 Ejecutando deployment automatizado..."
./scripts/deploy.sh
```

**🎉 ¡Tu primer deployment automatizado!**

### Paso 16: Simula un deployment con bug y rollback

```bash
# Introduce un "bug" intencionalmente

echo 'console.log("🐛 Bug introducido para simular problema");' >> app.js

# Construye nueva versión con bug

docker build -t mi-app-devops:v2.0-buggy .

# Despliega la versión con bug

docker stop mi-app-prod 2>/dev/null || true
docker rm mi-app-prod 2>/dev/null || true
docker run -d -p 4000:4000 --name mi-app-prod mi-app-devops:v2.0-buggy

# ¡Houston, tenemos un problema! Verifica el bug

echo "🐛 Checking for bug..."
docker logs mi-app-prod | grep "Bug introducido"

# ¡Rollback inmediato!

echo "🔄 Ejecutando rollback..."
docker stop mi-app-prod
docker rm mi-app-prod
docker run -d -p 4000:4000 --name mi-app-prod mi-app-devops:v1.0

echo "✅ Rollback completado - Crisis evitada!"
curl http://localhost:4000/health
```

**💪 ¡Acabas de manejar una crisis como un DevOps senior!**

---

## 📊 PARTE 5: Monitoreo y Observabilidad

### ¿Por qué monitorear?

Si tu aplicación fuera un paciente en el hospital, el monitoreo sería:
- 💓 Monitor cardíaco (¿está viva?)
- 🌡️ Termómetro (¿qué tal la temperatura/CPU?)
- 📊 Análisis de sangre (¿cómo están las métricas internas?)

### Paso 17: Monitoreo en tiempo real

```bash
# Inicia el script de monitoreo en background

echo "📊 Iniciando monitoreo..."

./scripts/monitor.sh &

# Nota el Process ID
MONITOR_PID=$!

echo "Monitor corriendo con PID: $MONITOR_PID"

```

### Paso 18: Genera tráfico para ver métricas

```bash
# En otra terminal, genera tráfico

echo "🚦 Generando tráfico de prueba..."

for i in {1..20}; do
  curl -s http://localhost:4000 > /dev/null
  curl -s http://localhost:4000/api/stats > /dev/null
  curl -s http://localhost:4000/health > /dev/null
  echo "Request $i enviado"
  sleep 1
done
```

### Paso 19: Simula problemas y observa las métricas

```bash
# Simula algunos errores

echo "🚨 Simulando errores..."

for i in {1..5}; do
  curl -s http://localhost:4000/api/error > /dev/null
  echo "Error $i simulado"
done

# Simula respuestas lentas

echo "🐌 Simulando respuestas lentas..."
curl -s http://localhost:4000/api/slow > /dev/null &
curl -s http://localhost:4000/api/slow > /dev/null &

# Ve las métricas actuales

echo "📈 Métricas actuales:"
curl -s http://localhost:4000/api/stats | python3 -m json.tool
```

### Paso 20: Analiza logs como un detective

```bash
# Detén el monitor

kill $MONITOR_PID 2>/dev/null || true

# Analiza los logs de la aplicación

echo "🔍 Analizando logs..."

docker logs mi-app-prod --tail 30

# Cuenta errores

echo "❌ Total de errores detectados:"

docker logs mi-app-prod | grep -c "ERROR"

# Ve patrones de acceso

echo "📊 Patrones de acceso:"

docker logs mi-app-prod | grep "GET /" | wc -l | xargs echo "Total requests GET /:"
docker logs mi-app-prod | grep "/health" | wc -l | xargs echo "Health checks:"
docker logs mi-app-prod | grep "/api/stats" | wc -l | xargs echo "Stats requests:"
```

### Paso 21: Métricas de sistema

```bash
# Ve el uso de recursos del contenedor

echo "🐳 Recursos del contenedor:"

docker stats mi-app-prod --no-stream

# Ejecuta un chequeo completo del sistema
./scripts/system-check.sh
```

---

## 🔧 PARTE 6: Gestión de código y colaboración 

### Configuración inicial de Git

```bash
# Configura Git con tu información

git config --global user.name "Tu Nombre Aquí"
git config --global user.email "tu.email@ejemplo.com"

# Ve la configuración

git config --list | grep user
```

### Paso 22: Trabajando con ramas (como un equipo)

```bash
# Ve en qué rama estás
git branch

# Crea una rama para tu feature
git checkout -b feature/mi-primera-mejora

# Haz un cambio significativo

echo "
## 🎯 Mi Primera Mejora DevOps

**Autor:** Tu Nombre  
**Fecha:** $(date)  
**Aprendizajes:**
- Containerización con Docker
- Automatización con scripts
- Monitoreo básico
- Gestión de crisis (rollback)

**Próximos objetivos:**
- Aprender Kubernetes
- Configurar CI/CD con GitHub Actions
- Implementar Infrastructure as Code
" >> MI_EXPERIENCIA.md

# Añade el archivo al control de versiones

git add MI_EXPERIENCIA.md

# Haz commit de tus cambios
git commit -m "feat: documentar mi primera experiencia DevOps

- Añadir documentación personal de aprendizajes
- Incluir próximos objetivos de formación
- Registrar milestone del primer día"

# Ve el historial
git log --oneline -5
```

### Paso 23: Simula colaboración en equipo

```bash
# Simula que eres parte de un equipo trabajando en paralelo

# Hotfix crítico (como si fuera otro compañero)
git checkout -b hotfix/seguridad-critica
echo "// Parche de seguridad aplicado $(date)" >> app.js
git add app.js
git commit -m "hotfix: aplicar parche de seguridad crítico

- Resolver vulnerabilidad detectada en audit
- Aplicar fix inmediato antes de merge a main
- Requiere deployment urgente"

# Nueva feature (como si fuera otro dev)
git checkout main
git checkout -b feature/nuevo-endpoint
echo "
app.get('/api/version', (req, res) => {
  res.json({
    version: '1.1.0',
    buildDate: '$(date)',
    author: 'Tu Nombre',
    environment: process.env.NODE_ENV || 'development'
  });
});" >> app.js

git add app.js
git commit -m "feat: añadir endpoint de información de versión

- Nuevo endpoint GET /api/version
- Incluye versión, fecha de build y autor
- Útil para debugging y monitoring"

# Ve todo el trabajo del equipo
echo "🌳 Árbol de commits del equipo:"
git log --oneline --graph --all -10
```

### Paso 24: Merge y resolución de conflictos

```bash
# Vuelve a main para hacer los merges
git checkout main

# Merge del hotfix (prioridad alta)
git merge hotfix/seguridad-critica

# Merge de la nueva feature
git merge feature/nuevo-endpoint

# Ve el resultado final
git log --oneline -5

# Testa que todo funciona
echo "🧪 Testing después de merge..."
node -c app.js && echo "✅ Sintaxis OK"
```

---

## 🚀 PARTE 7: Pipeline completo de CI/CD 

### ¿Qué es un Pipeline de CI/CD?

**CI (Continuous Integration):**
- Cada vez que alguien hace cambios en el código
- Automáticamente se ejecutan tests
- Si algo se rompe, nadie puede continuar hasta arreglarlo

**CD (Continuous Deployment):**
- Si todos los tests pasan
- Automáticamente se despliega a producción
- Sin intervención humana

**Resultado:** De código en laptop a producción en minutos, no semanas.

### Paso 25: Ejecuta tu primer pipeline completo

```bash
# Rebuild de la aplicación con todos los cambios
docker build -t mi-app-devops:v1.1 .

# Ejecuta el pipeline completo

echo "🏭 Iniciando pipeline completo de CI/CD..."

./scripts/full-pipeline.sh

```

**📋 Lo que está pasando detrás de cámaras:**
1. **Code Quality** - Verifica que el código esté bien
2. **Security Scan** - Busca vulnerabilidades
3. **Build & Test** - Construye y prueba la aplicación
4. **Deploy to Staging** - Despliega en entorno de pruebas
5. **Smoke Tests** - Verificaciones básicas en staging
6. **Production Deploy** - Si todo está bien, va a producción
7. **Health Monitoring** - Vigila que todo funcione

---

## 🎉 PARTE 8: ¡Felicitaciones y próximos pasos!

### Lo que acabas de lograr

**🏆 ¡INCREÍBLE! Has completado tu primera experiencia DevOps.**

En las últimas horas has:

✅ **Desarrollado** una aplicación web desde cero  
✅ **Containerizado** con Docker profesionalmente  
✅ **Automatizado** procesos con scripts de Bash  
✅ **Monitoreado** aplicaciones en tiempo real  
✅ **Gestionado** código con Git como un pro  
✅ **Desplegado** usando pipelines de CI/CD  
✅ **Resuelto** incidents con rollbacks  
✅ **Trabajado** en equipo con branches  


### Recursos para continuar aprendiendo

**🔗 Enlaces esenciales:**
- [DevOps Roadmap](https://roadmap.sh/devops) - Tu guía visual completa
- [Docker Documentation](https://docs.docker.com/) - La biblia de containers
- [Kubernetes Learning Path](https://kubernetes.io/docs/tutorials/) - Siguiente nivel
- [AWS Free Tier](https://aws.amazon.com/free/) - Practica en la nube
- [GitHub Actions](https://docs.github.com/en/actions) - CI/CD moderno

**📚 Libros recomendados:**
- "The Phoenix Project" - Novela DevOps (¡sí, una novela!)
- "The DevOps Handbook" - Manual práctico
- "Site Reliability Engineering" (Google) - SRE practices

**🎓 Certificaciones por las que apuntar:**
- AWS Certified Cloud Practitioner (3-6 meses)
- Kubernetes Administrator (CKA) (6-12 meses)
- HashiCorp Terraform Associate (4-8 meses)

### Tu desafío para esta semana

**🎯 Modifica la aplicación para que incluya:**

1. **Nuevo endpoint `/api/team`** que devuelva información de tu equipo:
   ```javascript
   app.get('/api/team', (req, res) => {
     res.json({
       teamName: "Tu Equipo DevOps",
       members: ["Tu Nombre", "Compañero 1", "Compañero 2"],
       motto: "Deploy fast, break nothing!",
       established: new Date().toISOString()
     });
   });
   ```

2. **Health check más robusto** que verifique "base de datos" (simula con archivo JSON):
   ```javascript
   const fs = require('fs');
   
   app.get('/health/advanced', (req, res) => {
     // Simula check de DB
     const dbStatus = fs.existsSync('./data.json') ? 'connected' : 'disconnected';
     
     res.json({
       status: 'OK',
       database: dbStatus,
       uptime: Date.now() - startTime,
       version: '1.2.0'
     });
   });
   ```

3. **Script de backup** automatizado:
   ```bash
   #!/bin/bash
   # scripts/backup.sh
   
   BACKUP_DIR="./backups/$(date +%Y%m%d-%H%M%S)"
   mkdir -p $BACKUP_DIR
   
   # Backup del código
   tar -czf $BACKUP_DIR/app-backup.tar.gz *.js *.json public/
   
   # Backup de imágenes Docker
   docker save mi-app-devops:latest > $BACKUP_DIR/docker-image.tar
   
   echo "✅ Backup completado en $BACKUP_DIR"
   ```

### Paso final: Limpieza del entorno

```bash
# Si quieres limpiar todo para empezar fresh otro día
./scripts/cleanup.sh

# O mantén todo para seguir experimentando
echo "🎉 ¡Mantén tu entorno para seguir practicando!"
```



