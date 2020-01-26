# Useful Docker snippets

## Keep the container running
The default behavior of most Docker containers is to stop the container once all it's processes finish. In order to keep the container running, you either need to have a running process (eg. `npm run`), or, if there is no such process that your application offers, you can use this simple snippet in your `Dockerfile` or `docker-compose.yml` to keep it effectively waiting forever. 

The sleep process is very lightweight so you don't need to worry about performance impact at all.

#### Dockerfile
```Dockerfile
CMD ["/bin/sh", "-c", "echo 'Container is ready.' ; while sleep 1000; do :; done"]
```
#### docker-compose.yml
```docker-compose
version: '3.7'
services:
    my_service:
        ...
        command: /bin/sh -c "echo 'Container is ready.' ; while sleep 1000; do :; done"
        ...
```

## Install wait-for-it
This snippet adds `wait-for-it` command as recommended by official [Docker Documentation](https://docs.docker.com/compose/startup-order/). `wait-for-it` documentation can be found on it's [GitHub repository](https://github.com/vishnubob/wait-for-it).


```Dockerfile
RUN wget -q -O /usr/local/bin/wait-for-it https://raw.githubusercontent.com/vishnubob/wait-for-it/master/wait-for-it.sh && \
chmod +x /usr/local/bin/wait-for-it
```

#### Usage
I recommend using following command in your `docker-compose.yml` or in an external entrypoint script that is called at container startup. The reason this should be preffered over using it directly in Dockerfile is the Dockerfile should be kept autonomous, it shouldn't be aware of the port of other service, since the mapping of ports is managed with docker-compose, or the target service may not be run via Docker at all.

Example: this command waits for `db` service that runs at port `5432` (default PostgreSQL port). After the service is running, `Container is ready` message is echoed. The `wait-for-it` has no timeout, thus waiting indefinitely.
```docker-compose
version: '3.7'
services:
    my_service:
        ...
        command: /bin/sh -c "wait-for-it db:5432 -q && echo 'Container is ready.' ; while sleep 1000; do :; done"
        ...
```


## Install Python3.7 in Ubuntu
Following snippet can be added into Ubuntu docker container to install/upgrade to Python3.7 including pip. It also sets
Python3.7 as the default Python3 binary.

```Dockerfile
RUN apt-get install -y python3.7 python3.7-distutils python3.7-dev && \
curl -sL https://bootstrap.pypa.io/get-pip.py | python3.7 && \
ln -sf /usr/bin/python3.7 /usr/bin/python3 && \
ln -sf /usr/bin/python3.7 /usr/local/bin/python3
```