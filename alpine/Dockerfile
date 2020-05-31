FROM alpine:3

# Set default timezone and install system packages
RUN ln -fs /usr/share/zoneinfo/UTC /etc/localtime && \
    apk add --no-cache bash sudo wget curl nano vim && \
    # Fix sudo: setrlimit(RLIMIT_CORE): Operation not permitted
    echo "Set disable_coredump false" >> /etc/sudo.conf

# Specify the working directory
WORKDIR /usr/src/app

# Remove temporary files
RUN rm -rf /tmp/* /var/tmp/*

# Use UID and GID arguments got from docker-compose.yml
ARG UID=1000
ARG GID=1000

# Create user group if not exist
RUN getent group $GID >/dev/null || \
    echo "Creating group $GID" && \
    addgroup "dc-boilerplate" -g $GID
# Create user if not exist and add to sudo
RUN getent passwd $UID >/dev/null || \
    echo "Creating user $UID" && \
    adduser "dc-boilerplate" -D -u $UID -G $(getent group $GID | cut -d: -f1) -s /bin/bash && \
    echo "dc-boilerplate ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Switch to the newly created user
USER $UID

# Set the default command to keep container running
CMD ["/bin/bash", "-c", "echo 'Container is ready.' ; trap exit TERM ; while sleep 1; do :; done"]