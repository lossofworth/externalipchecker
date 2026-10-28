FROM alpine:latest

RUN apk add --no-cache lua5.3 lua-filesystem lua-http

COPY ipupdater.lua /
COPY main.lua /

ENTRYPOINT ['/main.lua']
