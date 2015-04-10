FROM aviata/ubuntu-java8

    RUN date -u +"%Y-%m-%d %H:%M%S?" && wget -q http://mirrors.sonic.net/apache/storm/apache-storm-0.9.4/apache-storm-0.9.4.tar.gz -O tmp.gz && tar -xzf tmp.gz -C /opt

    ENV STORM_HOME /opt/apache-storm-0.9.4
    ENV SUPER_CONFIG /etc/supervisor/supervisord.conf

    RUN date -u +"%Y-%m-%d %H:%M%S?" && groupadd storm; useradd --gid storm --home-dir /home/storm --create-home --shell /bin/bash storm; chown -R storm:storm $STORM_HOME; mkdir /var/log/storm ; chown -R storm:storm /var/log/storm

    RUN date -u +"%Y-%m-%d %H:%M%S?" && rm -rf /usr/bin/storm && ln -s $STORM_HOME/bin/storm /usr/bin/storm

    ADD storm.yaml $STORM_HOME/conf/storm.yaml
    ADD cluster.xml $STORM_HOME/logback/cluster.xml
    ADD config-supervisord.sh /usr/bin/config-supervisord.sh
    ADD start-supervisor.sh /usr/bin/start-supervisor.sh


    RUN date -u +"%Y-%m-%d %H:%M%S?" && mkdir -p "$(dirname "$SUPER_CONFIG")" && echo [supervisord] | tee -a /etc/supervisor/supervisord.conf ; echo nodaemon=true | tee -a /etc/supervisor/supervisord.conf
