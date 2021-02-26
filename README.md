**A docker image to run Keepalived.**

> Image based on osixia/keepalived:stable

## Extends Environment Variables List

- **API_TOKEN**: Hcloud API Token
- **HOSTNAME**: Cloud instance name
- **VIRTUAL_IP**: Your virtual IP

## Keepalived check script

The script check if port 80 and 443 is opened. If you want to
override them, you can mount your script to **/usr/local/bin/check.sh**