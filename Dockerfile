FROM nginx:1.25-alpine
COPY dist/angular-16-crud-example /usr/share/nginx/html
COPY nginx.conf /etc/nginx/nginx.conf
