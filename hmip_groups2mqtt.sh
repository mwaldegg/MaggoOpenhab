#!/bin/bash
#Send HMIP Values to MQTT
MQTTHOST="localhost"
KEYLIST="/tmp/hmip2mqtt_keylist_groups"

echo -e "\n"
echo $(date)

cat <<EOF > /tmp/hmip2mqtt_keylist_groups
active
silent
ventilationRecommended
EOF

cat <<EOF > /tmp/hmip2mqtt_gropuplist
SECURITY_ZONE INTERNAL
SECURITY_ZONE EXTERNAL
EOF

#Read all values:
cd ~
~/.local/bin/hmip_cli.py --list-groups | sed -s 's/\([^ ]\+\) \+\([^ ]\+\) \+\(.*\)/\1_\2 \3/' > /tmp/hmgroups

  for KEY in $(cat "$KEYLIST"); do
  for ID in $(cat /tmp/hmgroups | grep "$KEY(" | cut -d" " -f1); do
  VALUE=$(cat /tmp/hmgroups | grep $ID | sed -s 's/ /\n/g' | grep "$KEY(" | cut -d "(" -f2 | sed -s 's/)//g')
  #echo "$ID:$KEY:$VALUE"
  TOPIC="/hmip/$ID/$KEY"
  echo "sending <$VALUE> to MQTT topic: $TOPIC"
  /usr/bin/mosquitto_pub -h $MQTTHOST -t "$TOPIC" -m "$VALUE"
  done
  done
  
  echo "#####################################"





