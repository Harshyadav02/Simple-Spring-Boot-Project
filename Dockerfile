# Build stage
FROM maven:3.9.2-eclipse-temurin-17-alpine as build
WORKDIR /app
COPY . /app/
RUN ./mvnw clean package -DskipTests


FROM openjdk:21
WORKDIR /app
COPY --from=build /app/target/*.jar app.jar
EXPOSE 8081
ENTRYPOINT ["java", "-jar", "app.jar"]

