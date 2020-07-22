FROM startext/gitlab-runner-gradle:latest AS build
COPY . /home/gradle/src
WORKDIR /home/gradle/src
RUN gradle clean assemble unzip --no-daemon

FROM okeyja/openjdk-curl
RUN mkdir /app
COPY --from=build /home/gradle/src/build/unpacked/dist/PlayStoreUploader-1.0/* /app/
