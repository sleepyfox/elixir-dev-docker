FROM elixir:1.12-alpine

RUN apk update && apk add git

# Set group and user IDs for docker user
ARG GID=1000
ARG UID=1000
ARG USER=me

# Create the group and user
RUN addgroup -g $GID $USER
RUN adduser -D -u $UID -G $USER $USER
USER $USER

WORKDIR /var/app
