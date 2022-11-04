FROM kalilinux/kali-rolling

ARG USER=root
ENV USER ${USER}

# Install apt utils
RUN apt-get update && apt-get install -y --no-install-recommends apt-utils

# Install more Kali tools
RUN DEBIAN_FRONTEND=noninteractive apt-get update -y && apt-get install -y metasploit-framework
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y dirb

# Install basic linux tools
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y iproute2

# Install a VNC server
RUN DEBIAN_FRONTEND=noninteractive apt-get install xfce4 xfce4-goodies -y \
    && apt-get install tightvncserver -y

RUN mkdir -p /root/.vnc
RUN USER= echo -e "#!/bin/bash\nxrdb /root/.Xresources\nstartxfce4 &" > /root/.vnc/xstartup \
    && chmod +x /root/.vnc/xstartup

# Install other tools
RUN apt install -y nano
RUN apt install -y vim
RUN apt install -y locate
RUN apt install -y iputils-ping
RUN apt install -y axel
VOLUME /host
CMD exec /bin/bash -c "trap : TERM INT; sleep infinity & wait"

# Update the locatedb
RUN updatedb

ENTRYPOINT bash
