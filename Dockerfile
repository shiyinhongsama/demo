FROM openjdk:8-alpine3.9

WORKDIR /opt/app

ADD target/demo-0.0.1-SNAPSHOT.jar app.jar

ENTRYPOINT java -jar /opt/app/app.jar