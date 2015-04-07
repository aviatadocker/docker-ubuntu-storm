FROM aviata/ubuntu

EXPOSE 6700
EXPOSE 6701
EXPOSE 6702
EXPOSE 6703
EXPOSE 8000

RUN date -u +"%Y-%m-%d %H:%M%S?" && /usr/bin/config-supervisord.sh supervisor
RUN date -u +"%Y-%m-%d %H:%M%S?" && /usr/bin/config-supervisord.sh logviewer
CMD /usr/bin/start-supervisor.sh
