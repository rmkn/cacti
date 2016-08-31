#!/bin/sh

service mysqld start
mysql -u root -e "GRANT ALL PRIVILEGES ON cacti.* TO cactiuser@localhost IDENTIFIED BY 'cactiuser';"
if [ $? -eq 0 ]; then
	mysql -u root -e "FLUSH PRIVILEGES;"
	mysql cacti < /usr/local/src/cacti-${CACTI_VERSION}/cacti.sql

	sed -i -e 's/^#//' /etc/cron.d/cacti
	service crond start
fi

exec "$@"
