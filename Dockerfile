FROM startext/gitlab-runner-gradle:latest AS build
COPY . /home/gradle/src
WORKDIR /home/gradle/src
RUN gradle clean assemble unzip --no-daemon

FROM okeyja/openjdk-curl
RUN mkdir /app
RUN apt-get install -y curl \
  && curl -sL https://deb.nodesource.com/setup_9.x | bash - \
  && apt-get install -y nodejs \
  && curl -L https://www.npmjs.com/install.sh | sh
COPY --from=build /home/gradle/src/build/unpacked/dist/PlayStoreUploader-1.0/* /app/
