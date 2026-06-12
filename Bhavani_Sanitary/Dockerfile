# 1. Build Stage
FROM maven:3.8.5-openjdk-8 AS build
WORKDIR /app

# Sabse pehle pom.xml copy karo aur dependencies download karo
COPY pom.xml .
RUN mvn dependency:go-offline -DskipTests

# Ab poora source code copy karo
COPY src ./src

# Build command - MAVEN_OPTS ko optimize kiya hai
RUN MAVEN_OPTS="-Xmx128m -Xms64m" mvn clean package -DskipTests

# 2. Run Stage
FROM tomcat:9.0-jdk8-openjdk-slim
# Purani files hatao
RUN rm -rf /usr/local/tomcat/webapps/*
# Build hue folder se war uthao
COPY --from=build /app/target/*.war /usr/local/tomcat/webapps/ROOT.war

EXPOSE 8080
CMD ["catalina.sh", "run"]
