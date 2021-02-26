#!/bin/bash

nc -z 0.0.0.0 80
RET_HTTP=$?

nc -z 0.0.0.0 443
RET_HTTPS=$?

if [ "$RET_HTTP" -ne "0" ] || [ "$RET_HTTPS" -ne "0" ]; then
  exit 1
else
  exit 0
fi
