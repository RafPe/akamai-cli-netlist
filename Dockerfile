#v1
FROM amd64/alpine:latest

ENV AKAMAI_CLI_HOME=/cli

RUN apk add --no-cache --update openssl \
        ca-certificates \
        libc6-compat \
        libstdc++ \
        wget \
        jq \
        bash && \
        rm -rf /var/cache/apk/* && \
    wget --quiet -O /usr/local/bin/akamai https://github.com/akamai/cli/releases/download/1.1.3/akamai-1.1.3-linuxamd64 && \
    chmod +x /usr/local/bin/akamai && \
    echo '[ ! -z "$TERM" -a -r /etc/motd ] && cat /etc/motd' >> /root/.bashrc


RUN mkdir -p /cli/.akamai-cli && \
    echo "[cli]" > /cli/.akamai-cli/config && \
    echo "cache-path            = /cli/.akamai-cli/cache" >> /cli/.akamai-cli/config && \
    echo "config-version        = 1" >> /cli/.akamai-cli/config && \
    echo "enable-cli-statistics = false" >> /cli/.akamai-cli/config && \
    echo "last-ping             = 2018-04-27T18:16:12Z" >> /cli/.akamai-cli/config && \
    echo "client-id             =" >> /cli/.akamai-cli/config && \
    echo "install-in-path       =" >> /cli/.akamai-cli/config && \
    echo "last-upgrade-check    = force" >> /cli/.akamai-cli/config

RUN akamai install https://github.com/apiheat/akamai-cli-netlist --force && \
    rm -rf /cli/.akamai-cli/src/akamai-cli-netlist/.git

RUN echo '                                                               ' >  /etc/motd && \
    echo '   ███╗   ██╗███████╗████████╗██╗     ██╗███████╗████████╗     ' >> /etc/motd && \
    echo '   ████╗  ██║██╔════╝╚══██╔══╝██║     ██║██╔════╝╚══██╔══╝     ' >> /etc/motd && \
    echo '   ██╔██╗ ██║█████╗     ██║   ██║     ██║███████╗   ██║        ' >> /etc/motd && \
    echo '   ██║╚██╗██║██╔══╝     ██║   ██║     ██║╚════██║   ██║        ' >> /etc/motd && \
    echo '   ██║ ╚████║███████╗   ██║   ███████╗██║███████║   ██║        ' >> /etc/motd && \
    echo '   ╚═╝  ╚═══╝╚══════╝   ╚═╝   ╚══════╝╚═╝╚══════╝   ╚═╝        ' >> /etc/motd && \
    echo '===============================================================' >> /etc/motd && \
    echo '=  Welcome to the netlist cli for Akamai                      =' >> /etc/motd && \
    echo '===============================================================' >> /etc/motd && \
    echo '=  Project page:                                              =' >> /etc/motd && \
    echo '=  https://github.com/apiheat/akamai-cli-netlist              =' >> /etc/motd && \
    echo '===============================================================' >> /etc/motd && \
    echo '=  Project version:                                           =' >> /etc/motd && \
    echo "   * $(akamai netlist --version)"                                  >> /etc/motd && \
    echo "   * $(akamai --version)"                                  >> /etc/motd && \
    echo '===============================================================' >> /etc/motd

VOLUME /cli
VOLUME /root/.edgerc

CMD ["/bin/bash"]
