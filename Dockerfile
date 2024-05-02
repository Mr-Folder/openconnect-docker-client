 FROM ubuntu:22.04

RUN apt-get update && apt-get install -y \
  openssh-server \
  openconnect \
  curl

RUN mkdir /var/run/sshd \
  && mkdir /vpn \
  && mkdir -p /etc/openconnect

RUN echo "root:root" | chpasswd
RUN sed -i 's/#PermitRootLogin.*/PermitRootLogin\ yes/' /etc/ssh/sshd_config
RUN sed -i 's/^AllowTcpForwarding no/AllowTcpForwarding yes/' /etc/ssh/sshd_config
RUN sed -i 's/^GatewayPorts no/GatewayPorts yes/' /etc/ssh/sshd_config
RUN sed -i 's/^#PermitTunnel no no/PermitTunnel yes/' /etc/ssh/sshd_config

COPY  entrypoint.sh /
EXPOSE 22

VOLUME ["/vpn", "/etc/openconnect"]

ENTRYPOINT ["/entrypoint.sh"]
