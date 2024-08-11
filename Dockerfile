FROM yourls:1.9.2-apache

ADD https://github.com/timcrockford/302-instead/archive/master.tar.gz         \
    /opt/302-instead.tar.gz
ADD https://github.com/YOURLS/404-if-not-found/archive/master.tar.gz                 \
    /opt/404-if-not-found.tar.gz
ADD https://github.com/dgw/yourls-dont-track-admins/archive/master.tar.gz     \
    /opt/dont-track-admins.tar.gz
ADD https://github.com/YOURLS/force-lowercase/archive/master.tar.gz           \
    /opt/force-lowercase.tar.gz
ADD https://github.com/guessi/yourls-mobile-detect/archive/refs/tags/3.0.0.tar.gz \
    /opt/mobile-detect.tar.gz
ADD https://github.com/YOURLS/dont-log-bots/archive/master.tar.gz             \
    /opt/dont-log-bots.tar.gz
ADD https://github.com/guessi/yourls-dont-log-health-checker/archive/master.tar.gz \
    /opt/dont-log-health-checker.tar.gz
ADD https://github.com/YOURLS/mass-remove-links/archive/master.tar.gz             \
        /opt/mass-remove-links.tar.gz
ADD https://github.com/YOURLS/timezones/archive/master.tar.gz                 \
    /opt/timezones.tar.gz
ADD https://github.com/ozh/yourls-change-password/archive/master.tar.gz                 \
    /opt/yourls-change-password.tar.gz

RUN for i in $(ls /opt/*.tar.gz); do                                          \
    plugin_name="$(basename ${i} '.tar.gz')"                              ; \
    mkdir -p /var/www/html/user/plugins/${plugin_name}                                  ; \
    tar zxvf /opt/${plugin_name}.tar.gz                                     \
      --strip-components=1                                                  \
      -C /var/www/html/user/plugins/${plugin_name}                                      ; \
    done

RUN mkdir -p /var/www/html/user/plugins/qr-code
COPY plugin-qrcode.php /var/www/html/user/plugins/qr-code/plugin.php

RUN rm -rf /opt/*.tar.gz && \
    chown -R www-data:www-data /var/www/html/user/