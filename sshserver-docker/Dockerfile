FROM debian:10
RUN apt-get update && apt-get install -y openssh-server
RUN mkdir /var/run/sshd


COPY docker-entrypoint.sh /
RUN chmod +rx /docker-entrypoint.sh

EXPOSE 22

ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

VOLUME [ "/data" ]

WORKDIR /data/

ENTRYPOINT [ "/docker-entrypoint.sh" ]

