FROM debian:10-slim
LABEL maintainer="Flyffies"

ENV maintainer="Flyffies"
ENV SLEEP_TIME="300"
# In Seconds
ENV TZ="Etc/UTC"

RUN apt update -y && apt upgrade -y && apt install -y getmail
RUN useradd -ms /bin/bash getmail
USER getmail
RUN mkdir -p ~/.getmail/ && chmod 700 ~/.getmail
RUN mkdir -p ~/maildir/cur && mkdir ~/maildir/new && mkdir ~/maildir/tmp

ADD --chown=getmail:getmail check-dir.sh /home/getmail/check-dir.sh
ADD --chown=getmail:getmail entrypoint.sh /home/getmail/entrypoint.sh

VOLUME ["/home/getmail/.getmail/", "/home/getmail/maildir/"]

WORKDIR /home/getmail/
CMD ["bash", "./entrypoint.sh"]
