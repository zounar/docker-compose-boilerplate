FROM debian:10

# Disable interactive installations
ARG DEBIAN_FRONTEND=noninteractive

# Set timezone
RUN ln -fs /usr/share/zoneinfo/Europe/Prague /etc/localtime

###### INSTALL SYSTEM PACKAGES
RUN apt-get update && \
    apt-get install -y --no-install-recommends apt-utils && \
    apt-get install -y sudo wget curl nano vim

###### CLEANUP
RUN rm -rf /tmp/* /var/tmp/*

# Use UID and GID arguments got from docker-compose.yml
ARG UID=1000
ARG GID=1000

###### CREATE GROUP if not exist
RUN id -g $GID >/dev/null 2>&1 || \
    echo "Creating group $GID" && \
    groupadd "dc-boilerplate" -g $GID
###### CREATE USER if not exist and add to sudo
RUN id -u $UID >/dev/null 2>&1 || \
    echo "Creating user $UID" && \
    useradd "dc-boilerplate" -u $UID -g $GID -m -s /bin/bash && \
    echo "dc-boilerplate ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

###### SWITCH USER
USER $UID

# This command will keep container running
ENTRYPOINT ["/bin/bash"]
CMD ["-c", "echo 'Container is ready.' ; while sleep 1000; do :; done"]