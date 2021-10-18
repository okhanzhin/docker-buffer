#FROM maven:3-jdk-8-slim AS build
#RUN mkdir usr/src/project
#COPY . usr/src/project
#WORKDIR usr/src/project
#RUN mvn clean install -DskipTests

FROM bellsoft/liberica-openjdk-centos:8u302-8
RUN mkdir reminder
#COPY --from=build /usr/src/project/ /network
COPY . /network
WORKDIR network/webapp/target/
EXPOSE 8081

CMD ["java", "-jar", "webapp-1.0-SNAPSHOT.jar"]