##Construir imagen Docker:
docker build -t hola-mundo-node:latest .

##Ejecutar:
docker run -d --name hola-mundo-node -p 3000:3000 hola-mundo-node:latest