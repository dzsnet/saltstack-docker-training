FROM ubuntu:22.04

SHELL ["/bin/bash", "-c"]
RUN apt update

ENV HOME=/root
USER root
WORKDIR /root

ENV TZ=Europe/Copenhagen
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN apt update && apt install -y tzdata && rm -rf /var/lib/apt/lists/*

RUN apt update && apt install curl -y
RUN curl -fsSL -o /etc/apt/keyrings/salt-archive-keyring-2023.gpg https://repo.saltproject.io/salt/py3/ubuntu/22.04/amd64/SALT-PROJECT-GPG-PUBKEY-2023.gpg
RUN echo "deb [signed-by=/etc/apt/keyrings/salt-archive-keyring-2023.gpg arch=amd64] https://repo.saltproject.io/salt/py3/ubuntu/22.04/amd64/latest jammy main" | tee /etc/apt/sources.list.d/salt.list
RUN apt update && \
    apt install -y python3 python3-pip mc vim nano wget git unzip netcat iputils-ping dnsutils traceroute nmap jq screen salt-minion salt-master salt-api

RUN apt-get -y install -qq --force-yes cron

RUN python3 -m pip install salt-pepper

RUN printf "#!/bin/bash\nscreen -mdS saltmaster /opt/saltstack/salt/salt-master\nsleep 10\nscreen -mdS saltminion /opt/saltstack/salt/salt-minion\ntail -f /var/log/salt/master /var/log/salt/minion" > /opt/saltservices;chmod +x /opt/saltservices;

#ENTRYPOINT ["tail", "-f", "/dev/null"]
#ENTRYPOINT sleep infinity

ENTRYPOINT ["/opt/saltservices"]