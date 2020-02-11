FROM  bitnami/tomcat:latest
COPY WebApp.war /opt/bitnami/tomcat/webapps/
