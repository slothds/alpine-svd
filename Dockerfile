FROM       alpine:3.7

LABEL      maintainer="sloth@devils.su"

RUN        apk update && apk upgrade --no-cache && \
           apk add --no-cache bash shadow tzdata supervisor && \
           rm -rf /var/cache/apk/*
RUN        mkdir -p /opt /exec/env.d /exec/init.d && \
           useradd -Uu 10001 -G users -md /opt/home -s /bin/false runner && \
           chown -R runner:runner /exec && chmod -R 775 /exec
RUN        sed -i 's/.*\(nodaemon\=\).*\( ;.*\)/\1true\2/;' /etc/supervisord.conf && \
           sed -i 's/\(logfile\=\).*\( ;.*\)/\1\/dev\/null\2/;' /etc/supervisord.conf && \
           sed -i 's/.*\(pidfile\=\).*\( ;.*\)/\1\/run\/supervisord\.pid\2/;' /etc/supervisord.conf

COPY       rootfs /

ENTRYPOINT ["/entrypoint.sh"]

STOPSIGNAL SIGTERM
