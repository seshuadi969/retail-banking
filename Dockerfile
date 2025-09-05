# Step 1: Build the application
FROM maven:3.9.9-eclipse-temurin-21 AS build
WORKDIR /app
COPY . .
RUN mvn package -DskipTests -Dmaven.clean.failOnError=false

# Step 2: Run the application
FROM eclipse-temurin:21-jdk
WORKDIR /app
COPY --from=build /app/target/*.jar app.jar

# Change the exposed port
EXPOSE 9090

# Run app (Spring Boot will still run on 8080 by default unless overridden)
ENTRYPOINT ["java", "-jar", "app.jar", "--server.port=9090"]

