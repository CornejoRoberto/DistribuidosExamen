# Dockerfile
FROM nginx:latest

# Copiar tu archivo index.html al directorio predeterminado de Nginx
COPY index.html /usr/share/nginx/html/index.html

# Exponer el puerto 80 para el servidor web
EXPOSE 80

# No se requiere CMD porque Nginx tiene un comando predeterminado para iniciar el servidor
