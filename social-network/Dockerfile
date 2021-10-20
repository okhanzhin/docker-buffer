FROM bellsoft/liberica-openjdk-centos:8u302-8
RUN mkdir network
COPY . /network
WORKDIR network/
EXPOSE 8080

CMD ["java", "-jar", "webapp-1.0-SNAPSHOT.war"]