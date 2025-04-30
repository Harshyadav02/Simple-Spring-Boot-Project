# FOR BUILD

FROM maven:3.9.6-eclipse-temurin-21-alpine as build

WORKDIR /app

COPY pom.xml .

RUN mvn dependency:go-offline # pre-downloads all dependencies based on pom.xml

COPY src ./src

RUN mvn clean package -DskipTests   # build the project


FROM eclipse-temurin:21-jre-alpine       

LABEL 	org.opencontainers.image.title="Java Web App" \
 	org.opencontainers.image.description="This image contains a basic GET request" \
	org.opencontainers.image.authors="harsh<harshyadav@gmail.com>" \
	org.opencontainers.image.version="v1.00" \
	org.opencontainers.image.source="https://github.com/harshyadav02/Simple-Spring-Boot-Project"


WORKDIR /app  

COPY --from=build /app/target/*.jar app.jar

RUN adduser -D -h /home/harshyadav/ harshyadav  # Add user with home dir

USER harshyadav

EXPOSE 8081

ENTRYPOINT ["java","-jar", "app.jar"]




