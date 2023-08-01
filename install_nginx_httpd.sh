#!/bin/bash
# iptables -I INPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
# iptables -I INPUT -p tcp --dport 22 -m conntrack --ctstate NEW -j ACCEPT
# iptables -I INPUT --source 192.168.8.0/24 -j ACCEPT
# iptables -I INPUT -p icmp -j ACCEPT
# iptables -I INPUT -i lo -j ACCEPT
# iptables -A INPUT -j DROP
# iptables -P FORWARD DROP
# iptables-save
setenforce 0
systemctl stop firewalld
systemctl disable firewalld
yum install -y nano wget rsync git httpd
yum install php php-mysql php-gd php-xml -y
yum install epel-release -y
# Установка Nginx
yum install nginx -y
git clone https://github.com/Pacanchick/otus_project.git
cd /home/as/otus_project/
# Настройка nginx
\cp default.conf /etc/nginx/conf.d/
\cp nginx.conf /etc/nginx/
systemctl enable --now nginx
systemctl status nginx
# Настройка apache
\cp index.html /var/www/html/
tar -xvf html.tar -C /var/www/
\cp httpd.conf /etc/httpd/conf/
\cp apache_conf.conf /etc/httpd/conf.d/
apachectl configtest
systemctl enable --now httpd
systemctl status httpd
# WordPress
cd ~
mkdir tempWP
cd ~/tempWP
wget https://wordpress.org/latest.tar.gz
tar zxvf ~/tempWP/latest.tar.gz -C /var/www/html
rm -Rf ~/tempWP