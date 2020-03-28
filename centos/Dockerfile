FROM centos:8

# Set timezone
RUN ln -fs /usr/share/zoneinfo/Europe/Prague /etc/localtime

###### INSTALL SYSTEM PACKAGES
RUN yum install -y sudo wget nano vim

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
USER $UID:$GID

# This command will keep container running
CMD ["/bin/sh", "-c", "echo 'Container is ready.' ; while sleep 1000; do :; done"]