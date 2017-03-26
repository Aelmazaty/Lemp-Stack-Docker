
#!/bin/bash
# This script is used to initialize and create wp database and user
# Start mysql
/usr/sbin/mysqld &
sleep 5

# Create the database and user for wordpress
mysql -uroot -e "CREATE DATABASE ${WPDB}"
mysql -uroot -e "GRANT All PRIVILEGES ON ${WPDB}.* TO ${WPUSER} IDENTIFIED BY '${WPPASS}';"
mysql -uroot -e "FLUSH PRIVILEGES;"

# Create admin user
# The password will appear in the log
echo -e "Creating Admin user\n"
ADMIN_UN='admin'
ADMIN_PASS=`pwgen -s 12 1`
mysql -uroot -e "GRANT ALL PRIVILEGES ON *.* TO $ADMIN_UN IDENTIFIED BY '$ADMIN_PASS';"
mysql -uroot -e "FLUSH PRIVILEGES;"
echo -e "DONE .... \n"
echo -e "USERNAME = $ADMIN_UN \n"
echo -e "PASSWORD = $ADMIN_PASS \n"

# Stop and restart mysql in the foreground
mysqladmin shutdown
/usr/sbin/mysqld
