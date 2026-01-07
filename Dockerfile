## docker file multistage build

## ############################################################
## etapa de construcción 
## ############################################################

## Usamos la imagen jdk y maven para construir nuestro jar
FROM maven:3.8.5-openjdk-17 AS build

# Establecemos el directorio de trabajo dentro del contenedor
WORKDIR /app

# Copiamos el archivo pom.xml y las dependencias primero para aprovechar el cache de Docker
COPY pom.xml .
RUN mvn dependency:go-offline

# Copiamos el código fuente de tu aplicación
COPY src src

# Empaquetamos la aplicación en un archivo JAR
RUN mvn package -DskipTests


## ############################################################
## etapa final 
## ############################################################


# Definimos el SO Linux Alpine con jdk17 incluido
FROM amazoncorretto:17-alpine

# Creamos nuestro directorio de trabajo en el contenedor
WORKDIR /app

# copiamos la aplicación que se encuentra en la capeta del target, y la pegamos en la carpera raiz del contenedsor
# Agregamos una variable o ARGUMENTO ARG que va a tener el siguiente valor JAR_FILE is a build argument you pass when running 'docker build'
COPY --from=build /app/target/*.jar app.jar

# Definimos el puerto por el cual se expondra la aplicación dentro del contenedor
## EXPOSE en un Dockerfile es una instrucción que documenta los puertos en los que la aplicación dentro del contenedor escuchará, 
## pero no publica ni abre esos puertos al exterior por sí sola; sirve como información para Docker y desarrolladores, indicando
## qué puertos son necesarios, y se complementa con el comando -p (publish) al ejecutar el contenedor para hacerlos accesibles desde el host. 
## Es una especie de "nota" para el motor de Docker y los usuarios sobre la red interna, no una directiva de acceso. 
EXPOSE 30400

# Define the command to run your application when the container starts
ENTRYPOINT ["java", "-jar", "app.jar"]


## 1. Ejecutamos el siguiente programa para construir ewl contenedor
## docker build --build-arg JAR_FILE=target/ping.prueba-0.0.1-SNAPSHOT.jar -t ping-prueba-short .
## cAMBIOS
