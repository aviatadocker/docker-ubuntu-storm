sed -i -e "s/%zookeeper%/$ZK_PORT_2181_TCP_ADDR/g" $STORM_HOME/conf/storm.yaml
sed -i -e "s/%nimbus%/$NIMBUS_PORT_6627_TCP_ADDR/g" $STORM_HOME/conf/storm.yaml
echo "storm.local.hostname: `hostname -i`" >> $STORM_HOME/conf/storm.yaml
# I'm not sure what this line was for
#/usr/sbin/sshd && supervisord
#$1 should be storm or nimbus
/usr/bin/storm $1
