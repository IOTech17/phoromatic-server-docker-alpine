FROM php:alpine

RUN apk upgrade \
    && apk add --no-cache git php83 php83-simplexml php83-dom php83-gd php83-sqlite3 php83-curl php83-zip php83-bz2 php83-sockets php83-cli wget linux-headers

RUN docker-php-ext-install sockets

WORKDIR /home/pts

RUN git clone https://github.com/phoronix-test-suite/phoronix-test-suite .

COPY ./phoronix-test-suite.xml /home/pts/.phoronix-test-suite/user-config.xml

RUN /home/pts/install-sh

COPY ./phoronix-test-suite.xml /etc/

#RUN apt-get remove --purge -y --allow-remove-essential apt git && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

EXPOSE 15000

CMD ["/usr/bin/phoronix-test-suite","start-phoromatic-server"]
