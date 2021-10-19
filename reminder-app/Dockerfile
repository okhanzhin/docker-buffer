#FROM maven:3-jdk-8-slim AS build
#RUN mkdir usr/src/project
#COPY . usr/src/project
#WORKDIR usr/src/project
#RUN mvn clean install -DskipTests

FROM bellsoft/liberica-openjdk-centos:8u302-8
RUN mkdir reminder
#COPY --from=build /usr/src/project/ /network
COPY . /reminder
WORKDIR reminder/
EXPOSE 8001

CMD ["java", "-jar", "birthday-reminder-jar-with-dependencies.jar"]