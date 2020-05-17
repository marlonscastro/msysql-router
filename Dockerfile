FROM debian:buster-slim


RUN apt-get update && \ 
	apt-get install -y python3

RUN apt-get update && \ 
	apt-get install -y libcurl4 libpython3.7  && \
	apt --fix-broken install && \
	rm -rf /var/lib/apt/lists/*

COPY mysql-router-community_8.0.19-1debian10_amd64.deb /tmp 

RUN dpkg -i /tmp/mysql-router-community_8.0.19-1debian10_amd64.deb && \
  	rm -Rf /tmp/*

RUN mysqlrouter --bootstrap root@node1:3306 --user=mysqlrouter --force

CMD systemctl restart mysqlrouter

ENTRYPOINT ["/bin/bash"]


# docker network create cluster --subnet=192.168.0.0/16
# docker run -d --net=cluster --name=node1 --ip=192.168.0.2 -e MYSQL_ROOT_PASSWORD=16scm4 my8innodb mysqld
# docker run -p 3307:3306 --name node1 -e MYSQL_ROOT_PASSWORD=16scm4 -d my8innodb

# Deploy no Openshift 
# oc new-app https://github.com/marlonscastro/mysql-shell.git --strategy=docker --name mysql-shell
# Depois adiciona um Storage Mount com 1Gi no Deployment Config path::  /var/lib/mysql
