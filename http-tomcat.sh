#!/bin/bash
sudo su -
yum install -y httpd
yum install -y java-1.8.0-openjdk.x86_64
yum install -y tomcat-admin-webapps
yum install -y tomcat-webapps
yum install -y tomcat-docs-webapp
systemctl start httpd
systemctl enable httpd
systemctl start tomcat
systemctl enable tomcat
