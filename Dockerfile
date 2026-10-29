FROM alpine:latest

RUN apk add --no-cache lua5.5 lua-filesystem lua-http

VOLUME /extip

WORKDIR /app

COPY updateip.lua .
#RUN /usr/local/bin/lua /updateip.lua
#RUN echo ' */5  *  *  *  * /usr/local/bin/lua /updateip.lua' >> /etc/crontabs/root

#HEALTHCHECK --interval=30s --timeout=5s --retries=3 \
#  CMD pgrep crond || exit 1

ENTRYPOINT ["lua", "/app/updateip.lua"]
