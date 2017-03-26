#!/bin/bash

# Script to edit the wp-config.php with the database info
# and run nginx and php5-fpm service
WORDPRESS_DIR='/var/www/app'
WORDPRESS_DB=$DB_ENV_WPDB
WORDPRESS_USER=$DB_ENV_WPUSER
WORDPRESS_PASS=$DB_ENV_WPPASS
WORDPRESS_HOST=$DB_PORT_3306_TCP_ADDR

echo 'Check for the wp-config.php'
if [ -f $WORDPRESS_DIR/wp-config.php ]
then
echo 'No need to edit the config file... starting php-fpm'
else
echo 'Editing wp-config.php...'
echo 'Starting the service'
cp $WORDPRESS_DIR/wp-config-sample.php $WORDPRESS_DIR/wp-config.php
sed -i "s/database_name_here/$WORDPRESS_DB/" /var/www/app/wp-config.php
sed -i "s/username_here/$WORDPRESS_USER/" /var/www/app/wp-config.php
sed -i "s/password_here/$WORDPRESS_PASS/" /var/www/app/wp-config.php
sed -i "s/localhost/$WORDPRESS_HOST/" /var/www/app/wp-config.php
fi
sleep 5

#starting php-fpm in foreground

/usr/sbin/php5-fpm -F
