FROM node:22-alpine

LABEL maintainer="DevOps Bootcamp <bootcamp@devops.com>" \
     description="Primera aplicación DevOps - Bootcamp Day 1" \
     version="1.0.0"

WORKDIR /app

COPY package*.json ./

RUN npm ci --only=production && npm cache clean --force

RUN addgroup -g 1001 -S nodejs && \
    adduser -S nextjs -u 1001

COPY --chown=nextjs:nodejs . .

USER nextjs

EXPOSE 3000

CMD ["npm", "start"]
