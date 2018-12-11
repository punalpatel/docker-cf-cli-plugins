FROM golang:1.8-alpine3.6
RUN apk update
RUN apk upgrade

RUN apk --no-cache add jq bash git

ADD https://cli.run.pivotal.io/stable?release=linux64-binary /tmp/cf-cli.tgz
RUN mkdir -p /usr/local/bin && tar -xzf /tmp/cf-cli.tgz -C /usr/local/bin && cf --version && rm -f /tmp/cf-cli.tgz
RUN git clone https://github.com/cloudfoundry-incubator/app-autoscaler-cli-plugin.git && cd app-autoscaler-cli-plugin && source .envrc && git submodule update --init --recursive && ./scripts/build && cf install-plugin ascli
