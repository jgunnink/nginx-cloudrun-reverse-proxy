FROM nginx

RUN apt-get update && apt-get install -y jq

COPY run.sh /run.sh

# Copy Nginx configuration
COPY nginx.conf /etc/nginx/nginx.conf

CMD ["./run.sh"]
