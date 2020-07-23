FROM startext/gitlab-runner-gradle:latest AS build
COPY . /home/gradle/src
WORKDIR /home/gradle/src
RUN gradle clean assemble unzip --no-daemon
RUN ls -la /home/gradle/src/build/unpacked/dist/PlayStoreUploader-1.0

FROM okeyja/openjdk-curl
RUN mkdir /app
RUN mkdir /app/bin
RUN mkdir /app/lib
RUN apt-get install -y curl \
  && curl -sL https://deb.nodesource.com/setup_9.x | bash - \
  && apt-get install -y nodejs \
  && curl -L https://www.npmjs.com/install.sh | sh
COPY --from=build /home/gradle/src/build/unpacked/dist/PlayStoreUploader-1.0/bin /app/bin/
COPY --from=build /home/gradle/src/build/unpacked/dist/PlayStoreUploader-1.0/lib /app/lib/
RUN ls -s /app/
