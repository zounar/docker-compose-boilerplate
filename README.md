# Docker-Compose boilerplate

Boilerplate for Docker Compose which solves common use-case problems. See [snippets.md](snippets.md)
for some useful code that you can use in Dockerfiles. To install Docker, see 
[docker installation guide](docker-installation.md).

This project contains 5 Docker containers: `alpine`, `centos`, `debian`, `fedora` and `ubuntu`. 
You can run them one-by-one or all at once and start playing and tinkering with them.

### How to run
**Initialize the project (Linux only):**  
`./init-docker.sh`

**Run (ubuntu) container**  
`docker-compose up -d ubuntu`

**Shell into (ubuntu) container**  
`docker-compose exec ubuntu bash`

**Start tinkering with the container!**  
`echo "Hello, I am $(uname -n) container :]"`

**Beware**: The directory of this project is mapped into the working directory of the container!
Pay attention not do delete or break your own files.

### Edit the Dockerfile
All changes that you do in the containers are irreversibly lost once you remove containers. To keep
them persistent, you need to edit the Dockerfile that is stored in a directory named by the Linux distribution.

After you change the Dockerfile, you need to rebuild and (re)start the container by:  
`docker-compose up --build -d ubuntu`

### Useful commands
**Run single container**  
`docker-compose up -d ubuntu`

**Run all containers**  
`docker-compose up -d`

**Shell into running container**  
`docker-compose exec ubuntu bash`

**Shell into container as root**  
`docker-compose exec -u root ubuntu bash`

**Stop single container**  
`docker-compose stop ubuntu`

**Stop all containers**  
`docker-compose stop`

**Remove single container**  
`docker-compose down ubuntu`

**Remove all containers**  
`docker-compose down`

**Build all containers**  
`docker-compose build` 

**Rebuild all containers**  
`docker-compose build --no-cache --pull`

**Watch logs of single container**  
`docker-compose logs -f ubuntu`
