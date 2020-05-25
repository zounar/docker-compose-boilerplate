FROM debian:10

# Disable interactive installations
ARG DEBIAN_FRONTEND=noninteractive

# Set default timezone and install system packages
RUN ln -fs /usr/share/zoneinfo/UTC /etc/localtime && \
    apt-get update && \
    apt-get install -y --no-install-recommends apt-utils && \
    apt-get install -y sudo wget curl nano vim

# Remove temporary files
RUN rm -rf /tmp/* /var/tmp/*

# Specify the working directory
WORKDIR /usr/src/app

# Use UID and GID arguments got from docker-compose.yml
ARG UID=1000
ARG GID=1000

# Create user group if not exist
RUN getent group $GID >/dev/null || \
    echo "Creating group $GID" && \
    groupadd "dc-boilerplate" -g $GID
# Create user if not exist and add to sudo
RUN getent passwd $UID >/dev/null || \
    echo "Creating user $UID" && \
    useradd "dc-boilerplate" -u $UID -g $GID -m -s /bin/bash && \
    echo "dc-boilerplate ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Switch to the newly created user
USER $UID

# Set the default command to keep container running
CMD ["/bin/bash", "-c", "echo 'Container is ready.' ; trap exit TERM ; while sleep 1; do :; done"]