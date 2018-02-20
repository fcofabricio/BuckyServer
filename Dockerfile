FROM node

ENV BUCKY_VERSION master
ENV PORT 5999
EXPOSE 5999

RUN wget https://github.com/fcofabricio/BuckyServer/archive/$BUCKY_VERSION.tar.gz -O /opt/BuckyServer.tar.gz && \
    mkdir -p /opt/BuckyServer && \
    tar --strip-components=1 -xzf /opt/BuckyServer.tar.gz -C /opt/BuckyServer

RUN cd /opt/BuckyServer && npm install -g

ADD default.yaml.template /opt/BuckyServer/config/default.yaml.template

ADD serve /opt/BuckyServer/serve
RUN chmod +x /opt/BuckyServer/serve

WORKDIR /opt/BuckyServer

CMD ["./serve"]
