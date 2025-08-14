FROM debian:bookworm

USER root

RUN apt-get update && apt-get install -y \
    mariadb-server \
    mariadb-client

COPY ./requirements/mariadb/tools/docker_entry.sh /usr/local/bin/

CMD ["/usr/local/bin/docker_entry.sh"]