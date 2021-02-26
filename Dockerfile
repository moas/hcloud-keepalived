FROM osixia/keepalived:stable
MAINTAINER Oscar LASM <lasm.landry@gmail.com>

RUN apk add --no-cache jq

ADD resources/keepalived.conf /container/service/keepalived/assets/keepalived.conf
ADD resources/vars.yaml /container/environment/01-custom
ADD resources/notify.sh /container/service/keepalived/assets/notify.sh
ADD resources/check_http.sh /usr/local/bin/check.sh