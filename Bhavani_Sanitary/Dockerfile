# 1. Build stage (Minimal memory usage)
FROM maven:3.8.5-openjdk-8 AS build
WORKDIR /app
# Sirf pom.xml copy karo pehle
COPY pom.xml .
# Dependencies download karo (is se RAM kam use hogi)
RUN mvn dependency:go-offline
# Baaki source code copy karo
COPY src ./src
# Build command
RUN mvn clean package -DskipTests

# 2. Run stage (Tomcat)
FROM tomcat:9.0-jdk8-openjdk-slim
RUN rm -rf /usr/local/tomcat/webapps/*
COPY --from=build /app/target/*.war /usr/local/tomcat/webapps/ROOT.war

EXPOSE 8080
CMD ["catalina.sh", "run"]
