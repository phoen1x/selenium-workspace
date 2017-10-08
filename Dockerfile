FROM selenium/standalone-firefox-debug:3.5.3

USER root

# add utilities
RUN     apt-get update \
    &&  apt-get -y install aptitude python-software-properties software-properties-common \
    &&  add-apt-repository -y "deb http://archive.canonical.com/ $(lsb_release -sc) partner" \
    &&  apt-add-repository multiverse \
    &&  apt-get -y install curl git zsh vim tmux net-tools iputils-ping mtr

# add pulseaudio
RUN     apt-get -y install \
                        alsa-utils \
                        libasound2 \
                        libasound2-plugins \
                        pulseaudio \
                        pulseaudio-module-zeroconf \
                        pulseaudio-utils \
                        --no-install-recommends
COPY ./etc/pulse    /etc/pulse
RUN     usermod -aG audio,pulse,pulse-access seluser

# add pulseaudio gui
RUN     apt-get -y install pavucontrol

# add flash
RUN     apt-get update \
    &&  apt-get -y install adobe-flashplugin

# add Codecs/Fonts/Extras
RUN     apt-get -y install  gstreamer1.0-fluendo-mp3 gstreamer1.0-plugins-bad \
                            gstreamer1.0-plugins-ugly totem-plugins-extra gstreamer-tools \
                            ubuntu-restricted-extras

# setup zsh
COPY    ./home/seluser/.zshrc /home/seluser/.zshrc
RUN     chsh -s /usr/local/bin/bash seluser \
    &&  git clone git://github.com/robbyrussell/oh-my-zsh.git /home/seluser/.oh-my-zsh \
    &&  chown seluser:seluser /home/seluser/.oh-my-zsh -R \
    &&  chown seluser:seluser /home/seluser/.zshrc

# setup powerline
RUN     apt-get -y install python-pip git \
    &&  pip install git+https://github.com/powerline/powerline \
    &&  git clone https://github.com/powerline/powerline.git /tmp/powerline \
    &&  rsync -avzP /tmp/powerline/powerline /usr/share \
    &&  git clone https://github.com/powerline/fonts.git --depth=1 /tmp/powerline_font \
    &&  cd /tmp/powerline_font \
    &&  ./install.sh \
    &&  rsync -avzP /root/.local/share/fonts/* /usr/share/fonts  \
    &&  fc-cache -vf \
    &&  rm -r /tmp/powerline /tmp/powerline_font

# setup xterm
COPY    ./home/seluser/.Xresources /home/seluser/.Xresources
RUN     apt-get -y install x11-xserver-utils \
    &&  chown seluser:seluser /home/seluser/.Xresources

# setup tmux
COPY    ./home/seluser/.tmux.conf /home/seluser/.tmux.conf
RUN     chown seluser:seluser /home/seluser/.tmux.conf

# setup vim
COPY    ./home/seluser/.vimrc /home/seluser/.vimrc
RUN     chown seluser:seluser /home/seluser/.vimrc

# change vnc password
RUN     x11vnc -storepasswd skylar /home/seluser/.vnc/passwd

# custom startup script
COPY ./opt/bin/entry_point.sh /opt/bin/entry_point.sh
RUN     chmod a+x /opt/bin/entry_point.sh

# add supervisor to restart services when crashed
RUN     apt-get -y install  supervisor \
    &&  mkdir -p /var/log/supervisor
COPY ./etc/supervisor/conf.d/supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY ./opt/bin/supervisor_pulseaudio.sh /opt/bin/supervisor_pulseaudio.sh
COPY ./opt/bin/supervisor_pavucontrol.sh /opt/bin/supervisor_pavucontrol.sh
COPY ./opt/bin/supervisor_xterm.sh /opt/bin/supervisor_xterm.sh

USER seluser
