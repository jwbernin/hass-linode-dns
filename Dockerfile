ARG BUILD_FROM
FROM $BUILD_FROM

ENV LANG C.UTF-8

MAINTAINER John Berninger

LABEL Description="This image is used to create and maintain a DNS entry in Linode's DNS similar to how DuckDNS uses DDNS"

RUN apk add --no-cache curl

# Copy data for add-on
COPY run.sh /etc/periodic/daily
RUN chmod a+x /etc/periodic/daily/run.sh

#CMD [ "/run.sh" ]
