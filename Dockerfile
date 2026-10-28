FROM alpine:latest

RUN apk add --no-cache lua5.3 lua-filesystem lua-http

COPY updateip.lua /
COPY main.lua /

VOLUME /extip

ENTRYPOINT ['/main.lua']
