#!/bin/bash

# Check if subnet is provided as an argument
if [ -z "$1" ]; then
    echo "Usage: $0 <subnet>"
    echo "Example: $0 192.168.1.0/24"
    exit 1
fi

SUBNET=$1

# Extract the base IP and range from the subnet
IFS='/' read -r BASE RANGE <<< "$SUBNET"

# Function to convert IP to integer
ip_to_int() {
    local IP=$1
    local A B C D
    IFS='.' read -r A B C D <<< "$IP"
    echo "$((A * 256 ** 3 + B * 256 ** 2 + C * 256 + D))"
}

# Function to convert integer to IP
int_to_ip() {
    local INT=$1
    local A=$((INT >> 24 & 255))
    local B=$((INT >> 16 & 255))
    local C=$((INT >> 8 & 255))
    local D=$((INT & 255))
    echo "$A.$B.$C.$D"
}

# Get the start and end IP addresses
START_IP=$(ip_to_int "$BASE")
END_IP=$((START_IP + 2 ** (32 - RANGE) - 1))

# Ping each IP address in the range
for ((IP_INT=START_IP; IP_INT<=END_IP; IP_INT++)); do
    IP=$(int_to_ip "$IP_INT")
    ping -c 1 -W 1 "$IP" &> /dev/null
    if [ $? -eq 0 ]; then
        echo "Host $IP is up"
    else
        echo "Host $IP is down"
    fi
done
