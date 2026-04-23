#!/usr/bin/env sh

# Gradle wrapper script for Unix/Linux/Mac.

# Check that the current environment supports Gradle.
if ! [ -x "$(command -v java)" ]; then
  echo "Java is not installed or is not in the PATH." >&2
  exit 1
fi

# Define the directory of the wrapper script.
DIR="$(cd "$(dirname "$0")" >/dev/null; pwd)"

# Set the Gradle version to be used.
GRADLE_VERSION="6.8.3"

# Download the Gradle wrapper jar if it doesn't exist.
if [ ! -f "$DIR/gradle-wrapper.jar" ]; then
  echo "Gradle wrapper jar file not found. Downloading..."
  curl -L https://services.gradle.org/distributions/gradle-$GRADLE_VERSION-bin.zip -o "gradle.zip"
  unzip -o gradle.zip -d "$DIR"
  mv "$DIR/gradle-$GRADLE_VERSION" "$DIR/gradle"
  rm gradle.zip
fi

# Execute Gradle using the wrapper jar.
exec java -jar "$DIR/gradle/gradle-wrapper.jar" "$@"