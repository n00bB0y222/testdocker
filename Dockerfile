FROM kalilinux/kali-rolling

ARG USER=root
ENV USER ${USER}

# Install apt utils
RUN apt-get update && apt-get install -y --no-install-recommends apt-utils
VOLUME /host

