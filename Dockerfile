FROM ubuntu:22.04
RUN apt update && apt install -y nginx
COPY app/ /var/www/html
CMD ["nginx", "-g", "daemon off;"]

