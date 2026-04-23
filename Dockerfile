# Use eclipse-temurin:17-jdk for build stage (replaces deprecated openjdk:17-jdk)
FROM eclipse-temurin:17-jdk AS build

# Set the working directory
WORKDIR /app

# Copy the gradle files
COPY gradlew gradlew
COPY gradle gradle
COPY build.gradle build.gradle
COPY settings.gradle settings.gradle

# Copy the source code
COPY src src

# Build the application
RUN chmod +x ./gradlew && ./gradlew build -x test

# Second stage, to create a lighter image
FROM eclipse-temurin:17-jre

# Set working directory
WORKDIR /app

# Copy the jar file from the previous stage
COPY --from=build /app/build/libs/*.jar app.jar

# Expose port 8080
EXPOSE 8080

# Run the application
ENTRYPOINT ["java", "-jar", "app.jar"]