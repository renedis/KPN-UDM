#!/bin/bash

# MQTT broker configuration
HOSTNAME="0.0.0.0"            # MQTT broker IP
PORT="1883"                   # MQTT broker port
USER="username"               # MQTT username
PASSWORD="password"           # MQTT password
CLIENT_ID="UDM-SFP"           # MQTT clientID

# Function to publish message to MQTT broker
publish_mqtt() {
    topic="$1"
    message="$2"
    mosquitto_pub -h "$HOSTNAME" -p "$PORT" -u "$USER" -P "$PASSWORD" -i "$CLIENT_ID" -t "$topic" -m "$message"
}

# Function to publish MQTT discovery message for device
publish_device_discovery() {
    device_name="$1"
    device_id="$2"
    topic="homeassistant/sensor/$device_id/config"
    message='{"name":"'${device_name}'","uniq_id":"'${device_id}'","dev_cla":"temperature","dev":"sensor","mf":"UDM","mdl":"'${CLIENT_ID}'","ids":["module_temperature_'${CLIENT_ID}'","laser_output_power_'${CLI>
    publish_mqtt "$topic" "$message"
}

# Function to publish MQTT discovery message for sensor
publish_discovery() {
    sensor_name="$1"
    sensor_type="$2"
    unit_of_measurement="$3"
    unique_id="$4"
    topic="homeassistant/sensor/$CLIENT_ID/${sensor_name}/config"
    message='{"name":"'${sensor_name}'","state_topic":"'${CLIENT_ID}'/'${sensor_name}'","device_class":"'${sensor_type}'","unit_of_measurement":"'${unit_of_measurement}'","unique_id":"'${unique_id}'"}'
    publish_mqtt "$topic" "$message"
}

# Publish MQTT discovery messages for the device
publish_device_discovery "${CLIENT_ID}" "${CLIENT_ID}"

# Publish MQTT discovery messages for each sensor
publish_discovery "module_temperature" "temperature" "°C" "module_temperature_${CLIENT_ID}"
publish_discovery "laser_output_power" "power" "dBm" "laser_output_power_${CLIENT_ID}"
publish_discovery "receiver_signal_power" "power" "dBm" "receiver_signal_power_${CLIENT_ID}"

# Infinite loop to publish data every 10 seconds
while true; do
    # Get module temperature
    module_temp=$(ethtool -m eth9 | grep -m 1 "Module temperature" | awk '{print $4}')
    publish_mqtt "${CLIENT_ID}/module_temperature" "$module_temp"

    # Get laser output power
    laser_power=$(ethtool -m eth9 | grep -m 1 "Laser output power" | awk '{print $8}')
    publish_mqtt "${CLIENT_ID}/laser_output_power" "$laser_power"

    # Get receiver signal average optical power
    receiver_power=$(ethtool -m eth9 | grep -m 1 "Receiver signal average optical power" | awk '{print $10}')
    publish_mqtt "${CLIENT_ID}/receiver_signal_power" "$receiver_power"

    # Sleep for 10 seconds
    sleep 10
done
