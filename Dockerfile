# Build stage

FROM maven:3.9.6-eclipse-temurin-21-alpine as build

WORKDIR /app

COPY  pom.xml .

COPY src ./src

RUN mvn clean package -DskipTests



# Runtime stage
FROM eclipse-temurin:21-jre-alpine

LABEL maintainer="harsh-yadav-docker" version="version:0.1"

WORKDIR /app

COPY --from=build /app/target/*.jar app.jar

RUN adduser -D -h /home/harshyadav harshyadav

USER harshyadav

EXPOSE 8081

CMD ["java", "-jar", "app.jar"]

