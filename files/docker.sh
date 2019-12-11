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

docker run --name tomcat -v ~/pipeline/sample.war:/usr/local/tomcat/webapps/sample.war -dit -p 8081:8080 tomcat

#####################################################################################
# Jacoco related configuration in tomcat container
# cp jacoco jar to tomcat container
docker cp ~/pipeline/org.jacoco.agent-0.7.9-runtime.jar tomcat:/usr/local/tomcat/lib/

# cp updated catalina.sh to tomcat container (add jacoco configuration)
docker cp ~/pipeline/catalina.sh tomcat:/usr/local/tomcat/bin/
docker exec tomcat chmod 755 bin/catalina.sh

docker restart tomcat