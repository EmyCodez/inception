#!/usr/bin/env bash

# Read passwords from secrets files
DB_PASS=$(cat /run/secrets/db_pass)
DB_ROOT_PASS=$(cat /run/secrets/db_root_pass)

echo >> "$DB_CONF_ROUTE"
echo "[mysqld]" >> "$DB_CONF_ROUTE"
echo "bind-address=0.0.0.0" >> "$DB_CONF_ROUTE"
# allows MYSQL to accept connections from any ip address, this will make the database
# accessible from outside the container or host

mysql_install_db --datadir="$DB_INSTALL"
# this step sets up the directory with system tables and other required file for a 
# functioning database

mysqld_safe &
mysql_pid=$!
# starts MYSQL server in the safe mode and restarts the server if it crashes
# using "$" the server runs in the background
# captures the process ID using "$!" of the MYSQL server and store them in the mysql_pid

until mysqladmin ping >/dev/null 2>&1; do
  echo -n "."; sleep 0.2
done

# using mysqladmin ping to check if the MYSQL server is ready for the connection
# it keeps looping the server printing dots every 0.2 seconds until the server responds

mysql -u root -e "CREATE DATABASE $DB_NAME;
    ALTER USER 'root'@'localhost' IDENTIFIED BY '$DB_ROOT_PASS';
    GRANT ALL ON $DB_NAME.* TO '$DB_USER'@'%' IDENTIFIED BY '$DB_PASS';
    FLUSH PRIVILEGES;"

wait $mysql_pid
