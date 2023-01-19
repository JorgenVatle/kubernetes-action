FROM alpine:3.11

ARG KUBECTL_VERSION="1.15.10"

RUN apk add py-pip curl
RUN curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
RUN install -o root -g root -m 0755 kubectl /usr/bin/kubectl

COPY entrypoint.sh /entrypoint.sh
COPY .assets .
RUN chmod +x /usr/bin/kubectl
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
