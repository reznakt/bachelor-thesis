FROM alpine:3.21.2

RUN apk update

RUN apk add --no-cache texlive-full
RUN apk add --no-cache inkscape
RUN apk add --no-cache openjdk17-jre

RUN addgroup -g 1000 user && adduser -D -u 1000 -G user user
