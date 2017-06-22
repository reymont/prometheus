FROM index.alauda.cn/library/centos
LABEL maintainer "The Prometheus Authors <prometheus-developers@googlegroups.com>"

COPY prometheus                             /bin/prometheus
COPY client_get_post_server                 /bin/client_get_post_server
COPY startup.sh                              /opt/startup.sh
COPY promtool                               /bin/promtool
COPY documentation/examples/prometheus.yml  /etc/prometheus/prometheus.yml
COPY console_libraries/                     /usr/share/prometheus/console_libraries/
COPY consoles/                              /usr/share/prometheus/consoles/

RUN ln -s /usr/share/prometheus/console_libraries /usr/share/prometheus/consoles/ /etc/prometheus/

EXPOSE     9090
VOLUME     [ "/prometheus" ]
WORKDIR    /prometheus
ENTRYPOINT [ "/opt/startup.sh" ]

CMD        [ "-config.file=/etc/prometheus/prometheus.yml", \
             "-storage.local.path=/prometheus", \
             "-web.console.libraries=/usr/share/prometheus/console_libraries", \
             "-web.console.templates=/usr/share/prometheus/consoles" ]
