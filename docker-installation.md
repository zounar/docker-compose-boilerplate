## Docker installation (Linux)

### 1. Install Docker CE

```
cd /tmp
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
sudo usermod -aG docker $USER
rm get-docker.sh
```

### 2. Install Docker Compose

Installing Docker Compose via system package manager is not recommended as you
might get very old version of Docker Compose. 

Install Docker Compose by downloading binary:
```
sudo curl -L https://github.com/docker/compose/releases/download/1.25.5/docker-compose-Linux-x86_64 -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
```

### 3. Reboot

Your user needs docker group in order to access Docker CE. You've added a docker group in step 1., but in order to take effects, you have to reboot.


&nbsp;
&nbsp;

## Docker installation (Windows 10 Pro)

1. Get installer from official website - https://download.docker.com/win/stable/Docker%20Desktop%20Installer.exe
2. Run `Docker Desktop Installer.exe`
3. During installation, untick Use Windows containers instead of Linux containers
4. After installation, start Docker for Desktop and reboot if necessary (you might be prompted for rebooting)
5. Docker will ask you to share your drive, click accept (This might occur after running your first docker project)

If you encounter any weird bugs when running docker instances using Docker for Desktop, consider restarting Docker for Desktop, it often solves the problem.