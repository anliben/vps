FROM debian:10-slim

# Configurações básicas
MAINTAINER anliben <contato@evolars.com.br>

# Instalação do SSH
RUN apt-get update && \
    apt-get install -y \
    openssh-server \
    sudo \
    locales \
    tzdata \
    && mkdir /var/run/sshd \
    && echo 'root:senha123' | chpasswd \
    && sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config \
    && rm -rf /var/lib/apt/lists/*

# Configurações de ambiente
ENV LANG=C.UTF-8
ENV TZ=America/Sao_Paulo

# Cria usuário e configura permissões
RUN useradd -m -s /bin/bash anliben \
    && usermod -aG sudo anliben \
    && echo "anliben:senha123" | chpasswd \
    && echo "anliben ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/anliben

# Exposição da porta SSH
EXPOSE 22

# Comando para iniciar o SSH
CMD ["/usr/sbin/sshd", "-D"]