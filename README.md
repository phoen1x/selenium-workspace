# selenium-workspace

My personal **minimalistic Ubuntu Workspace** that can be accessed via VNC.

Useful if

* your co-workers desktop is running Windows or Mac.
* you want to do Selenium testing with Sound.

Adds the following software

* PulseAudio
* Zsh + Oh My-zsh + powerline
* tmux
* vim
* network tools like ping, netstat, mtr,...

to the original [selenium/standalone-firefox-debug](https://hub.docker.com/r/selenium/standalone-firefox-debug/)

## Quick Start

Make sure you have a working [Docker](https://docs.docker.com/engine/installation/) and
[docker-compose](https://docs.docker.com/compose/install/) environment.

```bash
# download project files
git clone https://gitlab.com/phoen1x/selenium-workspace.git
cd selenium-workspace

# start docker container
docker-compose up -d

# Open your favorite VNC viewer
# https://www.realvnc.com/en/connect/download/viewer/
#     host: 127.0.0.1
#     port: 61622
#     password: skylar
xdg-open 'vnc://:skylar@127.0.0.1:61622'

# stop docker container
docker-compose down
```

## Sound in Docker

You should check

* [my manual](http://www.livingfire.de/skylar-the-scholar/en/manual-selenium/)

More information see

* [jessfraz on pulseaudio](https://github.com/jessfraz/dockerfiles/tree/master/pulseaudio)
* [Kirill Malyshev on pulseaudio](http://scorpspot.blogspot.de/2015/10/pulseaudio-server-in-docker-container.html)
