FROM ubuntu:14.04
MAINTAINER Qiu Yu <unicell@gmail.com>

RUN apt-get update -q
RUN apt-get install -qy nginx curl

# confd and nginx template
WORKDIR /usr/local/bin
RUN cd /usr/local/bin && \
    curl -fsSL https://github.com/kelseyhightower/confd/releases/download/v0.7.1/confd-0.7.1-linux-amd64 -o confd && \
    chmod a+x confd
RUN mkdir -p /etc/confd/{conf.d,templates}
ADD /nginx.toml /etc/confd/conf.d/nginx.toml
ADD /nginx.tmpl /etc/confd/templates/nginx.tmpl

# nginx tuning
RUN rm /etc/nginx/sites-enabled/default
RUN sed -i '/access_log/a\
    log_format upstreamlog "[$time_local] $remote_addr passed to: $upstream_addr: $request Upstream Response Time: $upstream_response_time Request time: $request_time";' /etc/nginx/nginx.conf

# add confd-watch script
ADD /confd-watch /usr/local/bin/confd-watch
RUN chmod a+x /usr/local/bin/confd-watch

EXPOSE 80
CMD ["/usr/local/bin/confd-watch"]
