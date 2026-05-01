# ========== СТАДИЯ 1: СБОРКА ПРИЛОЖЕНИЯ ==========
FROM node:alpine AS builder
WORKDIR /app
COPY app/package*.json ./
RUN npm ci
COPY app/ .
RUN npm run build

# ========== СТАДИЯ 2: ПРОДАКШН-ОБРАЗ С NGINX ==========
FROM nginx:alpine
COPY --from=builder /app/build /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]