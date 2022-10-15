# pull tomcat image from docker hub
FROM tomcat
FROM openjdk:8-jre-slim
#copy war file on the container
COPY spring-petclinic-2.4.2.war app/
WORKDIR app/
RUN pwd
RUN ls -al
ENTRYPOINT [ "java", "-jar", "spring-petclinic-2.4.2.war", "--server.port=8085"]