# Use an official OpenJDK runtime as a parent image
FROM openjdk:17-jdk AS build

# Set the working directory
WORKDIR /app

# Copy the gradle files
COPY gradlew gradlew
COPY gradle gradle
COPY build.gradle build.gradle
COPY settings.gradle settings.gradle

# Copy the source code
COPY src/src /app/src

# Build the application
RUN ./gradlew build -x test

# Second stage, to create a lighter image
FROM openjdk:17-jre

# Copy the jar file from the previous stage
COPY --from=build /app/build/libs/*.jar app.jar

# Run the application
ENTRYPOINT ["java", "-jar", "app.jar"]
