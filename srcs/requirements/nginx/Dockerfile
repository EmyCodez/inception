FROM debian:bookworm

RUN apt-get -y update && apt-get install -y nginx && apt-get upgrade -y openssl

COPY ./requirements/nginx/tools/conf.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/conf.sh

CMD ["conf.sh"]