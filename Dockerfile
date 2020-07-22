FROM startext/gitlab-runner-gradle:latest AS build
COPY . /home/gradle/src
WORKDIR /home/gradle/src
RUN gradle clean assemble unzip --no-daemon

FROM openjdk:8-jre-slim
RUN mkdir /app
COPY --from=build /home/gradle/src/build/unpacked/dist/PlayStoreUploader-1.0/* /app/

#ENTRYPOINT ["java", "-Djava.security.egd=file:/dev/./urandom","-jar","/app/PlayStoreUploader.jar"]
