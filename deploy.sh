#!/bin/bash

echo "package cas war"
mvnw clean package -X

tomcat=/home/jason/workbench/tools/servers/cas-tomcat-7.0.68
echo "shutdown tomcat"
sh -x $tomcat/bin/shutdown.sh

echo "rm runtime cas war "
rm -rf $tomcat/webapps/cas*

echo "shudown tomcat if not shutdown"
ps -ef|grep $tomcat|awk '{print $2}'|xargs kill 

echo "cp  war to tomcat"
cp target/cas.war $tomcat//webapps/

sh -x $tomcat/bin/startup.sh

tail -200f $tomcat/logs/catalina.out
