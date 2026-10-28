FROM alpine:latest

RUN apk add --no-cache lua5.3 lua-filesystem lua-http

COPY updateip.lua /

VOLUME /extip

RUN /usr/local/bin/lua /updateip.lua
RUN echo ' */5  *  *  *  * /usr/local/bin/lua /updateip.lua' >> /etc/crontabs/root

HEALTHCHECK --interval=30s --timeout=5s --retries=3 \
  CMD pgrep crond || exit 1

ENTRYPOINT ["/usr/sbin/crond", "-f"]
