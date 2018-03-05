FROM nginx:1.7
MAINTAINER Andy Zhang <andizzle.zhang@gmail.com>

RUN DEBIAN_FRONTEND=noninteractive \
    apt-get update -qq && \
    apt-get -y install wget zip runit && \
    rm -rf /var/lib/apt/lists/*

ENV CT_URL https://releases.hashicorp.com/consul-template/0.6.5/consul-template_0.6.5_linux_amd64.zip
RUN wget -qO- -O tmp.zip ${CT_URL} && unzip tmp.zip -d /usr/local/bin && rm tmp.zip

ADD nginx.service /etc/service/nginx/run
ADD consul-template.service /etc/service/consul-template/run

RUN rm -v /etc/nginx/conf.d/*
ADD nginx.conf /etc/consul-templates/nginx.conf

CMD ["/usr/bin/runsvdir", "/etc/service"]
