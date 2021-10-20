FROM bellsoft/liberica-openjdk-centos:8u302-8
RUN mkdir reminder
COPY . /reminder
WORKDIR reminder/

CMD ["java", "-jar", "service-0.0.1-SNAPSHOT.jar"]