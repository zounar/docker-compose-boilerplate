# Docker-Compose boilerplate

Boilerplate for Docker Compose which solves common use-case problems. See [snippets.md](snippets.md)
for some useful code snippets that you can use in Dockerfiles.

### Permission issues
Running containers as root brings problems under Linux. All files created inside the 
container which are mapped using volumes are then mapped onto the host system with 
the same permissions - all files created by container root user are owned by root 
on the host machine. This brings not only security issues, but also complicates the 
file management process as you must handle such files with `sudo`.

#### Solution  
These containers include custom user and group `dc-boilerplate` that is automatically 
created and then used as a default container user. 

The default UID and GID of `dc-boilerplate` user and group is `1000:1000`. In order t
o change it, you can set `DOCKER_UID` and `DOCKER_GID` environment variables that will 
set the values respectively. 

**Using .env file**  
Environment variables can be set, by creating `.env` ([.env-example](.env-example)) file 
in the root of this repository where you set these variables:
```
DOCKER_UID=42
DOCKER_GID=42
```

In order to easily create this file, you can call: `./init-docker.sh`

**Using in-place variables**  
Environment variables can be also set by can prepending the `docker-compose` 
command with such values, eg.: `DOCKER_UID=42 DOCKER_GID=42 docker-compose up`    


### Unified entrypoint
All containers come with `/bin/bash` as an entrypoint.

### Keep container running
Base images often exit right after the start, because there is no default process running
which would keep them busy. This is resolved by the endless wait-loop that is embedded
in all containers:  
`echo 'Container is ready.' ; trap exit TERM ; while sleep 1; do :; done`

If you wan't to suppress this behavior, you can either edit the `CMD` statement in the 
`Dockerfile` or you can define your own command in `docker-compose.yml`, eg.:
```
ubuntu:
    container_name: dc-boilerplate-ubuntu
    command: echo 'Hello world'
    ...
```

```
ubuntu:
    container_name: dc-boilerplate-ubuntu
    command: -c "echo 'Hey!' && echo 'We can chain!'"
    ...
```

### Installation of basic system tools
All containers come with the tools that are used very often in every Linux distribution:  `bash`, `sudo`, `wget`, `curl`, `nano` and `vim`. 

### Useful commands
**Beware**: The root directory of this folder is mapped into the `working_dir` of the container!
Pay attention not do delete or break your own files.

**Run single container**  
To run just a single container, you can call following command (Ubuntu):    
`docker-compose up -d ubuntu`

**Shell into running container**  
Once the container is running, you can shell into it (Ubuntu):  
`docker-compose exec ubuntu bash`

