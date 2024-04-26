FROM ubuntu:latest
RUN apt update \
    && apt install -y nginx \
    && rm -rf /var/www/html/*
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
COPY ./html /var/www/html