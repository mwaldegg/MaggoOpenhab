#!/bin/bash
#Send HMIP Values to MQTT
MQTTHOST="localhost"

#Read all values:
cd ~
~/.local/bin/hmip_cli.py --list-devices > /tmp/hmvalues


#Tuerkontakte:

#Bad:
ID="3014F711A00000DA498D5292"
TOPIC="/hmip/bath/door"
VALUE=$(cat /tmp/hmvalues| grep $ID | sed -s 's/ /\n/g' | grep windowState | cut -d "(" -f2 | sed -s 's/)//g')

echo "Sending <$VALUE> to: $TOPIC"
/usr/bin/mosquitto_pub -h $MQTTHOST -t "$TOPIC" -m "$VALUE"


#Wohnzimmer:
ID="3014F711A0001558A99D670F"
TOPIC="/hmip/livingroom/door"
VALUE=$(cat /tmp/hmvalues| grep $ID | sed -s 's/ /\n/g' | grep windowState | cut -d "(" -f2 | sed -s 's/)//g')

echo "Sending <$VALUE> to: $TOPIC"
/usr/bin/mosquitto_pub -h $MQTTHOST -t "$TOPIC" -m "$VALUE"

#Eingang:
ID="3014F711A00000DA498D52B3"
TOPIC="/hmip/hallway/door"
VALUE=$(cat /tmp/hmvalues| grep $ID | sed -s 's/ /\n/g' | grep windowState | cut -d "(" -f2 | sed -s 's/)//g')

echo "Sending <$VALUE> to: $TOPIC"
/usr/bin/mosquitto_pub -h $MQTTHOST -t "$TOPIC" -m "$VALUE"	


#Temperaturen:
#Wohnzimmer
ID="3014F711A0000E9A498BAE8A"
temp=$(cat /tmp/hmvalues| grep $ID | sed -s 's/ /\n/g' | grep actualTemperature | cut -d"(" -f2 | sed -s 's/)//g')
hum=$(cat /tmp/hmvalues| grep $ID | sed -s 's/ /\n/g' | grep humidity | cut -d"(" -f2 | sed -s 's/)//g')

TOPIC="/hmip/livingroom/temperature"
VALUE=$temp
echo "Sending <$VALUE> to: $TOPIC"
/usr/bin/mosquitto_pub -h $MQTTHOST -t "$TOPIC" -m "$VALUE"	

TOPIC="/hmip/livingroom/humidity"
VALUE=$hum
echo "Sending <$VALUE> to: $TOPIC"
/usr/bin/mosquitto_pub -h $MQTTHOST -t "$TOPIC" -m "$VALUE"	

#Bad
ID="3014F711A0000A9A498D6A7B"
temp=$(cat /tmp/hmvalues| grep $ID | sed -s 's/ /\n/g' | grep actualTemperature | cut -d"(" -f2 | sed -s 's/)//g')
hum=$(cat /tmp/hmvalues| grep $ID | sed -s 's/ /\n/g' | grep humidity | cut -d"(" -f2 | sed -s 's/)//g')

TOPIC="/hmip/bath/temperature"
VALUE=$temp
echo "Sending <$VALUE> to: $TOPIC"
/usr/bin/mosquitto_pub -h $MQTTHOST -t "$TOPIC" -m "$VALUE"	

TOPIC="/hmip/bath/humidity"
VALUE=$hum
echo "Sending <$VALUE> to: $TOPIC"
/usr/bin/mosquitto_pub -h $MQTTHOST -t "$TOPIC" -m "$VALUE"


#Aussen
ID="3014F711A00010D8A990A2FF"
temp=$(cat /tmp/hmvalues| grep $ID | sed -s 's/ /\n/g' | grep actualTemperature | cut -d"(" -f2 | sed -s 's/)//g')
hum=$(cat /tmp/hmvalues| grep $ID | sed -s 's/ /\n/g' | grep humidity | cut -d"(" -f2 | sed -s 's/)//g')

TOPIC="/hmip/outside/temperature"
VALUE=$temp
echo "Sending <$VALUE> to: $TOPIC"
/usr/bin/mosquitto_pub -h $MQTTHOST -t "$TOPIC" -m "$VALUE"	

TOPIC="/hmip/outside/humidity"
VALUE=$hum
echo "Sending <$VALUE> to: $TOPIC"
/usr/bin/mosquitto_pub -h $MQTTHOST -t "$TOPIC" -m "$VALUE"

