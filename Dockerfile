FROM alpine:latest

RUN apk add --no-cache lua5.3 lua-filesystem lua-http

VOLUME /extip

COPY updateip.lua .

RUN echo ' */5  *  *  *  * /usr/bin/lua5.3 /updateip.lua' >> /etc/crontabs/root

HEALTHCHECK --interval=30s --timeout=5s --retries=3 \
  CMD pgrep crond || exit 1

ENTRYPOINT ["crond", "-f"]
#ENTRYPOINT ["/bin/sh"]
