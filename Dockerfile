FROM node

ENV BUCKY_VERSION master
ENV PORT 5999

EXPOSE 5999

RUN wget https://github.com/fcofabricio/BuckyServer/archive/$BUCKY_VERSION.tar.gz -O /opt/BuckyServer.tar.gz && \
    mkdir -p /opt/BuckyServer && \
    tar --strip-components=1 -xzf /opt/BuckyServer.tar.gz -C /opt/BuckyServer

ADD statsd-default.yaml.template /opt/BuckyServer/config/statsd-default.yaml.template

RUN cd /opt/BuckyServer && \
    sed -e "s/{{PORT}}/$PORT/" -e "s/{{STATSD_HOST}}/$STATSD_HOST/"  -e "s/{{STATSD_PORT}}/$STATSD_PORT/" config/statsd-default.yaml.template > config/default.yaml && \
    npm install -g

WORKDIR /opt/BuckyServer

CMD ["node", "start.js"]
