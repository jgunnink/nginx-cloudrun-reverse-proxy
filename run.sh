#!/bin/bash
while true; do
    ACCESS_TOKEN=$(curl -s -H "Metadata-Flavor: Google" \
        "http://metadata/computeMetadata/v1/instance/service-accounts/default/identity?audience=https://hello-3qqsqbdsuq-uc.a.run.app")

    cp /etc/nginx/nginx.conf.template /etc/nginx/nginx.conf
    sed -i "s/___ACCESS_TOKEN___/$ACCESS_TOKEN/g" /etc/nginx/nginx.conf
    echo "Access token replaced"

    if [ -e /var/run/nginx.pid ]; then
      echo "Reloading Nginx with updated token"
      nginx -s reload
    else
      echo "Starting Nginx"
      nginx -c /etc/nginx/nginx.conf
    fi

    echo "Script sleeping before refresh"
    sleep 3300 # Refresh every 55 minutes
done
