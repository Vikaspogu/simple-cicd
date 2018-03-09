FROM openjdk:alpine
ADD target/demo-0.0.1-SNAPSHOT.jar demo.jar
ENTRYPOINT ["java", "-jar", "/demo.jar"]
EXPOSE 8080 8778 9779