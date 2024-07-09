FROM nginx

RUN apt-get update && apt-get install -y jq

COPY run.sh /run.sh

# Copy Nginx configuration to a template file
COPY nginx.conf /etc/nginx/nginx.conf.template

CMD ["./run.sh"]
