pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'holaa-mundo-node'
        DOCKER_TAG = 'latest'
        CONTAINER_NAME = 'holaa-mundo-node'
        PORT = '3000'
    }

    tools {
        nodejs "Node18"  // Configura una instalación de Node.js en Jenkins
        dockerTool 'dockerTool'
    }

    triggers {
        // Se ejecuta automáticamente cuando hay un push en la rama 'main' o 'master'
        pollSCM('*/5 * * * *')  // Revisa los cambios cada 5 segundos
    }

    stages {

        stage('Verificar cambios en la rama') {
            steps {
                script {
                    // Se verifica si el commit ha sido en la rama main o master
                    def branchName = env.GIT_BRANCH
                    if (!(branchName == 'origin/main' || branchName == 'origin/master')) {
                        echo "No hay cambios en la rama 'main' o 'master'. Deteniendo el pipeline."
                        currentBuild.result = 'SUCCESS'
                        return
                    }
                    echo "Cambios detectados en la rama ${branchName}. Continuando con el pipeline."
                }
            }
        }

        stage('Construir Imagen Docker') {
            steps {
                script {
                    echo "Construyendo imagen Docker para ${DOCKER_IMAGE}:${DOCKER_TAG}"
                    sh 'docker build -t ${DOCKER_IMAGE}:${DOCKER_TAG} .'
                }
            }
        }

        stage('Ejecutar Contenedor Docker') {
            steps {
                script {
                    // Verificar si ya existe el contenedor
                    def containerExists = sh(script: "docker ps -q -f name=${CONTAINER_NAME}", returnStdout: true).trim()
                    if (containerExists) {
                        echo "Deteniendo y eliminando contenedor existente"
                        sh "docker stop ${CONTAINER_NAME}"
                        sh "docker rm ${CONTAINER_NAME}"
                    }
                    echo "Ejecutando nuevo contenedor con la imagen ${DOCKER_IMAGE}:${DOCKER_TAG}"
                    sh "docker run -d --name ${CONTAINER_NAME} -p ${PORT}:${PORT} ${DOCKER_IMAGE}:${DOCKER_TAG}"
                }
            }
        }

        stage('Notificación de éxito') {
            steps {
                script {
                    echo "Despliegue exitoso. El contenedor está corriendo en el puerto ${PORT}."
                }
            }
        }

    }

    post {
        success {
            echo "El pipeline ha terminado con éxito."
        }
        failure {
            echo "El pipeline ha fallado. Revisar los logs para detalles."
        }
    }
}
