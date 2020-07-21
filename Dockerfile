FROM startext/gitlab-runner-gradle:latest AS build
COPY . /home/gradle/src
WORKDIR /home/gradle/src
RUN gradle clean assemble --no-daemon --dry-run

FROM openjdk:8-jre-slim
RUN mkdir /app

COPY --from=build /home/gradle/src/build/libs/*.jar /app/PlayStoreUploader.jar

ENTRYPOINT ["java", "-Djava.security.egd=file:/dev/./urandom","-jar","/app/PlayStoreUploader.jar"]
