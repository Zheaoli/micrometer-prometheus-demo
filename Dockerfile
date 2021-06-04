FROM maven:3.6.0-jdk-8-slim AS build
COPY settings.xml /usr/share/maven/ref/
COPY micrometer /home/app/micrometer
COPY pom.xml /home/app
RUN mvn -f /home/app/pom.xml -s /usr/share/maven/ref/settings.xml clean package



FROM adoptopenjdk:8u252-b09-jre-openj9-0.20.0

COPY --from=build /home/app/micrometer/target/micrometer-0.0.1-SNAPSHOT.jar /usr/local/lib/application.jar

ENTRYPOINT ["java","-jar","/usr/local/lib/application.jar"]
