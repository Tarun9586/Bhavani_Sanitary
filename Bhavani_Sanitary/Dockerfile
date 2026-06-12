# 1. Build stage
FROM maven:3.8.5-openjdk-8 AS build
WORKDIR /app
COPY pom.xml .
# Dependencies download
RUN mvn dependency:go-offline
COPY src ./src
# Memory optimization: Aggressive GC aur lower heap size
RUN MAVEN_OPTS="-Xmx128m -XX:+UseSerialGC" mvn clean package -DskipTests

# 2. Run stage
FROM tomcat:9.0-jdk8-openjdk-slim
RUN rm -rf /usr/local/tomcat/webapps/*
COPY --from=build /app/target/*.war /usr/local/tomcat/webapps/ROOT.war
EXPOSE 8080
CMD ["catalina.sh", "run"]
