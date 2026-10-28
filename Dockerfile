FROM alpine:latest

RUN apk add --no-cache lua5.3 lua-filesystem lua-http

COPY updateip.lua /

VOLUME /extip

RUN echo ' */5  *  *  *  * /usr/local/bin/lua5.3 /updateip.lua' >> /etc/crontabs/root

ENTRYPOINT ["/usr/sbin/crond", "-f"]
