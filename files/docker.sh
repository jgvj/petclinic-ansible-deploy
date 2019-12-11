#!/usr/bin/env bash
. /etc/profile

if docker images | grep tomcat ; then
echo "tomcat is existed and skip pull tomcat"
else
docker pull tomcat
fi

if docker ps -a | grep -i tomcat ; then
docker rm -f tomcat
fi

docker run --name tomcat -v ~/pipeline/petclinic.war:/usr/local/tomcat/webapps/petclinic.war -dit -p 8081:8080 tomcat
