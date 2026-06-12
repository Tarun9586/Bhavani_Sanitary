# 1. Maven ka use karke build karo
FROM maven:3.8.5-openjdk-8 AS build
COPY . .
RUN mvn clean package -DskipTests

# 2. Tomcat par run karo
FROM tomcat:9.0-jdk8-openjdk
# Purani default webapps hata do
RUN rm -rf /usr/local/tomcat/webapps/*
# Build se nikli hui war file ko copy karo
COPY --from=build /target/*.war /usr/local/tomcat/webapps/ROOT.war

EXPOSE 8080
CMD ["catalina.sh", "run"]
