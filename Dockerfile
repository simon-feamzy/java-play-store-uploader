FROM startext/gitlab-runner-gradle:latest AS build
COPY . /home/gradle/src
WORKDIR /home/gradle/src
RUN gradle clean PlayStoreUploader --no-daemon
RUN ls -la /home/gradle/src/

FROM openjdk:8-jre-slim
RUN mkdir /app
RUN ls
COPY --from=build /home/gradle/src/build/libs/*-standalone.jar /app/PlayStoreUploader.jar

ENTRYPOINT ["java", "-Djava.security.egd=file:/dev/./urandom","-jar","/app/PlayStoreUploader.jar"]
