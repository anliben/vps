# Use a versão slim do Debian para uma imagem mais leve
FROM debian:10-slim

# Configurações básicas
MAINTAINER anliben <contato@evolars.com.br>

# Atualizações e instalações iniciais
RUN apt-get update && \
    apt-get install -y \
    sudo \
    locales \
    tzdata \
    && rm -rf /var/lib/apt/lists/*

# Configura locale e timezone
ENV LANG=C.UTF-8
ENV TZ=America/Sao_Paulo

# Cria usuário e configura permissões
RUN useradd -m -s /bin/bash anliben \
    && usermod -aG sudo anliben \
    && echo "anliben ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/anliben

# Configura diretório home do usuário
WORKDIR /home/anliben
USER anliben

# Comando padrão para iniciar o container
CMD ["bash"]