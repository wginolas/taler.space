FROM debian:bookworm

ENV DEBIAN_FRONTEND=noninteractive
RUN apt update && apt install -y wget

RUN echo 'deb [signed-by=/etc/apt/keyrings/taler-systems.gpg] https://deb.taler.net/apt/debian bookworm main' > /etc/apt/sources.list.d/taler.list
RUN wget -O /etc/apt/keyrings/taler-systems.gpg https://taler.net/taler-systems.gpg

RUN apt update && apt install -y taler-exchange taler-harness postgresql-client

COPY run-service.sh /scripts/

ENTRYPOINT ["/scripts/run-service.sh"]
