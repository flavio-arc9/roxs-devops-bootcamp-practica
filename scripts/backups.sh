#!/bin/bash
# scripts/backup.sh
   
BACKUP_DIR="./backups/$(date +%Y%m%d-%H%M%S)"
mkdir -p $BACKUP_DIR

# Backup del código
tar -czf $BACKUP_DIR/app-backup.tar.gz *.js *.json public/

# Backup de imágenes Docker
docker save mi-app-devops:latest > $BACKUP_DIR/docker-image.tar

echo "✅ Backup completado en $BACKUP_DIR"