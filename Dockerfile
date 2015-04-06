FROM aviata/ubuntu

#Storm setup, nimbus and supervisor

#install
if [ "$1" == "storm" ]
then
    RUN date -u +"%Y-%m-%d %H:%M%S?" && wget -q -O -http://mirrors.sonic.net/apache/storm/apache-storm-0.9.4/apache-storm-0.9.4.tar.gz | tar -xzf - - C /opt

    ENV STORM_HOME /opt/apache-storm-0.9.4

    RUN date -u +"%Y-%m-%d %H:%M%S?" && groupadd storm; useradd --gid storm --home-dir /home/storm --create-home --shell /bin/bash storm; chown -R storm:storm $STORM_HOME; mkdir /var/log/storm ; chown -R storm:storm /var/log/storm

    RUN date -u +"%Y-%m-%d %H:%M%S?" && ln -s $STORM_HOME/bin/storm /usr/bin/storm

    ADD storm.yaml $STORM_HOME/conf/storm.yaml
    ADD cluster.xml $STORM_HOME/logback/cluster.xml
    ADD config-supervisord.sh /usr/bin/config-supervisord.sh
    ADD start-supervisor.sh /usr/bin/start-supervisor.sh

    RUN date -u +"%Y-%m-%d %H:%M%S?" && echo [supervisord] | tee -a /etc/supervisor/supervisord.conf ; echo nodaemon=true | tee -a /etc/supervisor/supervisord.conf

    RUN date -u +"%Y-%m-%d %H:%M%S?" && echo [supervisord] | tee -a /etc/supervisor/supervisord.conf ; echo nodaemon=true | tee -a /etc/supervisor/supervisord.conf

fi

if [ "$1" == "nimbus" ]
then
    RUN date -u +"%Y-%m-%d %H:%M%S?" && /usr/bin/config-supervisord.sh nimbus
    RUN date -u +"%Y-%m-%d %H:%M%S?" && /usr/bin/config-supervisord.sh drpc
    
    EXPOSE 6627
    EXPOSE 3772
    EXPOSE 3773

    ADD start-supervisor.sh /usr/bin/start-supervisor.sh
    CMD /usr/bin/start-supervisor.sh
fi

if [ "$1" == "supervisor" ]
    EXPOSE 6700
    EXPOSE 6701
    EXPOSE 6702
    EXPOSE 6703
    EXPOSE 8000

    RUN date -u +"%Y-%m-%d %H:%M%S?" && /usr/bin/config-supervisord.sh supervisor
    RUN date -u +"%Y-%m-%d %H:%M%S?" && /usr/bin/config-supervisord.sh logviewer
    CMD /usr/bin/start-supervisor.sh
fi
