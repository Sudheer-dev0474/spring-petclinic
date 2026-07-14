FROM maven:33.9.11-eclipse-temurin-25 AS build
WORKDIR /app
COPY . .
RUN mvn package
FROM eclipse-temurin:25.0.3_9-jre-noble AS runtime
WORKDIR /devops
RUN useradd -m -d /usr/share/SUDHEER -s /bin/sh SUDHEER
USER SUDHEER
COPY --from=build /app/target/*.jar /devops/capgemni.jar
EXPOSE 8080
CMD ["java", "-jar", "capgemni.jar"]