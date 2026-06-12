# 1. Build stage (Memory optimized)
FROM maven:3.8.5-openjdk-8 AS build
WORKDIR /app
COPY pom.xml .
RUN mvn dependency:go-offline
COPY src ./src
# Yahan set karo memory limit
RUN MAVEN_OPTS="-Xmx256m" mvn clean package -DskipTests

# 2. Run stage (Tomcat)
FROM tomcat:9.0-jdk8-openjdk-slim
RUN rm -rf /usr/local/tomcat/webapps/*
# Build se sirf WAR file copy karo
COPY --from=build /app/target/*.war /usr/local/tomcat/webapps/ROOT.war

EXPOSE 8080
CMD ["catalina.sh", "run"]
