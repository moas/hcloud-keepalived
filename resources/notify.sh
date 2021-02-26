#!/bin/bash

# for ANY state transition.
# "notify" script is called AFTER the
# notify_* script(s) and is executed
# with 3 arguments provided by keepalived
# (ie don't include parameters in the notify line).
# arguments
# $1 = "GROUP"|"INSTANCE"
# $2 = name of group or instance
# $3 = target state of transition
#     ("MASTER"|"BACKUP"|"FAULT")

TYPE=$1
NAME=$2
STATE=$3

SERVER_ID=$(curl -H "Authorization: Bearer $API_TOKEN" "https://api.hetzner.cloud/v1/servers?name=$HOSTNAME" | jq '.servers[0].id')

FLOATING_IP_ID=$(curl -H "Authorization: Bearer $API_TOKEN" "https://api.hetzner.cloud/v1/floating_ips" | jq ".floating_ips[] | select(.ip==\"$VIRTUAL_IP\")" | jq '.id')


function unassignIP() {
    curl \
      -X POST \
      -H "Authorization: Bearer $API_TOKEN" \
      "https://api.hetzner.cloud/v1/floating_ips/$1/actions/unassign"
    return $?
}

function assignIP() {
    curl \
      -X POST \
      -H "Authorization: Bearer $API_TOKEN" \
      -H "Content-Type: application/json" \
      -d "{\"server\":$1}" \
      "https://api.hetzner.cloud/v1/floating_ips/$2/actions/assign"
    return $?
}


case $STATE in
    "MASTER")
      unassignIP "$FLOATING_IP_ID"
      assignIP "$SERVER_ID" "$FLOATING_IP_ID"
      echo "I'm the MASTER! Whup whup." > /proc/1/fd/1
      exit 0
    ;;
    "BACKUP")
        echo "Ok, i'm just a backup, great." > /proc/1/fd/1
        exit 0
    ;;
    "FAULT")  echo "Fault, what ?" > /proc/1/fd/1
        exit 0
    ;;
    *)  echo "Unknown state" > /proc/1/fd/1
        exit 1
    ;;
esac