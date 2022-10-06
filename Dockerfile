FROM ubuntu:22.04
MAINTAINER Esteban Lorenzano <esteban@lorenzano.eu>
RUN apt-get update
RUN apt-get install -y unzip 
RUN apt-get install -y curl
RUN apt-get install -y gpg

# add pharo-vm
RUN echo 'deb http://download.opensuse.org/repositories/devel:/languages:/pharo:/latest/xUbuntu_22.04/ /' | tee /etc/apt/sources.list.d/devel:languages:pharo:latest.list
RUN curl -fsSL https://download.opensuse.org/repositories/devel:languages:pharo:latest/xUbuntu_22.04/Release.key | gpg --dearmor | tee /etc/apt/trusted.gpg.d/devel_languages_pharo_latest.gpg > /dev/null
RUN apt-get update
RUN apt-get install -y pharo9

# set work environment
USER root
WORKDIR /opt/foliage

# download pharo image
ADD http://files.pharo.org/get-files/100/pharoImage-x86_64.zip ./pharo64.zip
RUN set -eu; \
  unzip pharo64.zip; \
  rm pharo64.zip; \
  mv *.image foliage.image; \
  mv *.changes foliage.changes; \
  true

# install foliage
COPY build.st ./build.st
RUN pharo ./foliage.image st --save --quit build.st; \
  rm build.st; \
  true

# add entrypoint 
COPY entrypoint.sh ./entrypoint.sh
RUN chmod +x entrypoint.sh
ENTRYPOINT [ "/opt/foliage/entrypoint.sh" ]
