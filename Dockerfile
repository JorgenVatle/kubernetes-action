FROM alpine:3.11

WORKDIR /root

ARG KUBECTL_VERSION="v1.28.2"

RUN apk add py-pip curl
RUN apk add gettext

RUN export RELEASE=${KUBECTL_VERSION="$(curl -L -s https://dl.k8s.io/release/stable.txt)"} \
      && echo "Installing Kubectl $RELEASE" \
      && curl -LO --verbose "https://dl.k8s.io/release/$RELEASE/bin/linux/amd64/kubectl"
RUN install -o root -g root -m 0755 kubectl /usr/bin/kubectl

COPY .assets .assets
COPY entrypoint.sh .

RUN chmod +x /usr/bin/kubectl
RUN chmod +x ./entrypoint.sh

ENTRYPOINT ["/root/entrypoint.sh"]