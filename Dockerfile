FROM openjdk:11
EXPOSE 8080
WORKDIR /opt/app
COPY target/ashok-it-api.jar /opt/app/ashok-it-api.jar
ENTRYPOINT ["java", "-jar", "/opt/app/ashok-it-api.jar"]