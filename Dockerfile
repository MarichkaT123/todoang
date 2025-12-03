# Stage 1: Build Angular app
FROM node:18 AS builder
WORKDIR /app

COPY package.json pnpm-lock.yaml ./
RUN npm install -g pnpm@10
RUN pnpm install

COPY . .
RUN pnpm run build

# Stage 2: Run Nginx
FROM nginx:1.25-alpine

COPY ./nginx.conf /etc/nginx/conf.d/default.conf
COPY --from=builder /app/dist /usr/share/nginx/html

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]

