FROM alpine:3

# Set timezone
RUN ln -fs /usr/share/zoneinfo/Europe/Prague /etc/localtime

###### INSTALL SYSTEM PACKAGES
RUN apk add bash sudo wget curl nano vim && \
    # Fix sudo: setrlimit(RLIMIT_CORE): Operation not permitted
    echo "Set disable_coredump false" >> /etc/sudo.conf

###### CLEANUP
RUN rm -rf /tmp/* /var/tmp/*

# Use UID and GID arguments got from docker-compose.yml
ARG UID=1000
ARG GID=1000

###### CREATE GROUP if not exist
RUN id -g $GID >/dev/null 2>&1 || \
    echo "Creating group $GID" && \
    addgroup "dc-boilerplate" -g $GID
###### CREATE USER if not exist and add to sudo
RUN id -u $UID >/dev/null 2>&1 || \
    echo "Creating user $UID" && \
    adduser "dc-boilerplate" -D -u $UID -G $(getent group $GID | cut -d: -f1) -s /bin/bash && \
    echo "dc-boilerplate ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

###### SWITCH USER
USER $UID:$GID

# This command will keep container running
CMD ["/bin/sh", "-c", "echo 'Container is ready.' ; while sleep 1000; do :; done"]