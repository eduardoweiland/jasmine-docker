#!/bin/bash

/usr/bin/mysqld_safe &
 sleep 10s

 mysqladmin -u root password mysqlpsswd
 mysqladmin -u root -pmysqlpsswd reload
 mysqladmin -u root -pmysqlpsswd create jasmine
 echo "GRANT ALL ON jasmine.* TO jasmine@localhost IDENTIFIED BY 'jasmine'; flush privileges; " | mysql -u root -pmysqlpsswd

 # install JASMINE
 wget -O jasmine.zip https://github.com/eduardoweiland/jasmine/archive/master.zip
 unzip jasmine.zip jasmine-master/*
 mv jasmine-master /var/www/jasmine
 cd /var/www/jasmine && curl -sS https://getcomposer.org/installer | php && php composer.phar install --no-interaction --no-dev
 /var/www/jasmine/bin/cake migrations migrate
 
 # cron para atualizar dados
 echo "*/5 * * * * www-data /usr/bin/php /var/www/jasmine/bin/cake query" | tee /etc/crontab

 rm -R /var/www/html
 # mod_rewrite
 ln -s /etc/apache2/mods-available/rewrite.load /etc/apache2/mods-enabled/rewrite.load
 #to fix error relate to ip address of container apache2
 echo "ServerName localhost" | tee /etc/apache2/conf-available/fqdn.conf
 ln -s /etc/apache2/conf-available/fqdn.conf /etc/apache2/conf-enabled/fqdn.conf

killall mysqld
sleep 10s
