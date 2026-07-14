FROM maven:3.9.16-eclipse-temurin-11-alpine AS build
WORKDIR /app
COPY . .
RUN mvn package
FROM eclipse-temurin:8u492-b09-jre-noble AS runtime
WORKDIR /devops
RUN useradd -m -d /usr/share/SUDHEER -s /bin/sh SUDHEER
USER SUDHEER
COPY --from=build /app/target/*.jar /devops/capgemni.jar
EXPOSE 8080
CMD ["java", "-jar", "capgemni.jar"]