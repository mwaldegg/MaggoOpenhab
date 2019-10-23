#!/bin/bash
#Send HMIP Values to MQTT
MQTTHOST="localhost"
KEYLIST="/tmp/hmip2mqtt_keylist"

echo -e "\n"
echo $(date)

cat <<EOF > /tmp/hmip2mqtt_keylist
actualTemperature
humidity
windowState
lowbat
rssiDeviceValue
vaporAmount
moistureDetected
waterlevelDetected
on
smokeDetectorAlarmType
setPointTemperature
valvePosition
valveState
incorrectPositioned
sabotage
EOF

#Read all values:
cd ~
~/.local/bin/hmip_cli.py --list-devices > /tmp/hmvalues

for KEY in $(cat "$KEYLIST"); do
  for ID in $(cat /tmp/hmvalues | grep " $KEY(" | cut -d" " -f1); do
  VALUE=$(cat /tmp/hmvalues| grep $ID | sed -s 's/ /\n/g' | grep -e "^$KEY(" | cut -d "(" -f2 | sed -s 's/)//g')
  #echo "$ID:$KEY:$VALUE"
  TOPIC="/hmip/$ID/$KEY"
  echo "sending <$VALUE> to MQTT topic: $TOPIC"
  /usr/bin/mosquitto_pub -h $MQTTHOST -t "$TOPIC" -m "$VALUE"
  done
done

  echo "#####################################"





