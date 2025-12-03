# Stage 1: Build Angular app
FROM node:18 AS builder

WORKDIR /app

COPY package.json pnpm-lock.yaml ./
RUN npm install -g pnpm @angular/cli
RUN pnpm install

COPY . .
RUN pnpm run build

# Stage 2: Nginx server
FROM nginx:stable

# Видаляємо дефолтний конфіг
RUN rm /etc/nginx/conf.d/default.conf

# Копіюємо наш кастомний nginx.conf
COPY nginx.conf /etc/nginx/conf.d/default.conf

# ❗️ВАЖЛИВО: копіюємо правильну папку з angular.json
COPY --from=builder /app/dist/angular-16-crud /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
