# Tomcat 9 aur Java 8 ka base image
FROM tomcat:9.0-jdk8-openjdk

# Purani default webapps hata do (taaki conflict na ho)
RUN rm -rf /usr/local/tomcat/webapps/*

# Tumhari WAR file ko Tomcat ke webapps folder mein copy karo
COPY target/*.war /usr/local/tomcat/webapps/ROOT.war

# Tomcat start karo
EXPOSE 8080
CMD ["catalina.sh", "run"]
