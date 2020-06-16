FROM fedora:31

# Set system locale to UTF 8
ENV LANG=C.UTF-8 LC_ALL=C.UTF-8 LC_CTYPE=C.UTF-8

# Set default timezone and install system packages
RUN ln -fs /usr/share/zoneinfo/UTC /etc/localtime && \
    dnf install --refresh -y wget nano vim && \
    dnf clean all

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

# Create the working directory
RUN mkdir -p /usr/src/app && \
    chown $UID:$GID /usr/src/app
# Specify the working directory
WORKDIR /usr/src/app

# Switch to the newly created user
USER $UID

# Set the default command to keep container running
CMD ["/bin/bash", "-c", "echo 'Container is ready.' ; trap exit TERM ; while sleep 1; do :; done"]