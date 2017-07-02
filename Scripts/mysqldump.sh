#!/bin/sh

## Create a MySQL babcup user with the following permissions ##
#	CREATE USER 'mysqlbackup'@'localhost' IDENTIFIED BY 'NEW-PASSWD';
#	GRANT RELOAD ON *.* TO 'mysqlbackup'@'localhost';
#	GRANT CREATE, INSERT, DROP, UPDATE ON mysql.backup_progress TO 'mysqlbackup'@'localhost';
#	GRANT CREATE, INSERT, SELECT, DROP, UPDATE ON mysql.backup_history TO 'mysqlbackup'@'localhost';
#	GRANT REPLICATION CLIENT ON *.* TO 'mysqlbackup'@'localhost';
#	GRANT SUPER ON *.* TO 'mysqlbackup'@'localhost';
#	GRANT PROCESS ON *.* TO 'mysqlbackup'@'localhost';
#	GRANT LOCK TABLES, SELECT, CREATE, DROP, FILE ON *.* TO 'mysqlbackup'@'localhost';
#	GRANT CREATE, INSERT, DROP, UPDATE ON mysql.backup_sbt_history TO 'mysqlbackup'@'localhost';

{
START=`date +%s`	
echo "   -----   MySQLdump.sh Started @ `date +'%m_%d_%Y_%I-%M_%p'`   -----   "
### SET SCRIPT VARIABLES ###
DBSERVER=127.0.0.1
USER=mysqlbackup
PASS=gD7NabxTOqcvEXq2
FILE1=information_schema_`date +'%m_%d_%Y_%I-%M_%p'`.sql
FILE2=mysql_`date +'%m_%d_%Y_%I-%M_%p'`.sql
FILE3=performance_schema_`date +'%m_%d_%Y_%I-%M_%p'`.sql
FILE4=postfix_`date +'%m_%d_%Y_%I-%M_%p'`.sql
FILE5=roundcube_`date +'%m_%d_%Y_%I-%M_%p'`.sql
FILE6=whmcs_`date +'%m_%d_%Y_%I-%M_%p'`.sql
DATABASE1=information_schema
DATABASE2=mysql
DATABASE3=performance_schema
DATABASE4=postfix
DATABASE5=roundcube
DATABASE6=whmcs

### CLEANUP MYSQL OLD BACKUPS ###
rm -rf /var/lib/phpMyAdmin/save/*

### DO MYSQL DATABASE BACKUPS ###

## Use this command for a database server on localhost. add other options if need be ##
mysqldump --opt --single-transaction --user=${USER} --password=${PASS} --events --ignore-table=mysql.event ${DATABASE1} > /var/lib/phpMyAdmin/save/${FILE1}
mysqldump --opt --single-transaction --user=${USER} --password=${PASS} --events --ignore-table=mysql.event ${DATABASE2} > /var/lib/phpMyAdmin/save/${FILE2}
mysqldump --opt --single-transaction --user=${USER} --password=${PASS} --events --ignore-table=mysql.event ${DATABASE3} > /var/lib/phpMyAdmin/save/${FILE3}
mysqldump --opt --single-transaction --user=${USER} --password=${PASS} --events --ignore-table=mysql.event ${DATABASE4} > /var/lib/phpMyAdmin/save/${FILE4}
mysqldump --opt --single-transaction --user=${USER} --password=${PASS} --events --ignore-table=mysql.event ${DATABASE5} > /var/lib/phpMyAdmin/save/${FILE5}
mysqldump --opt --single-transaction --user=${USER} --password=${PASS} --events --ignore-table=mysql.event ${DATABASE6} > /var/lib/phpMyAdmin/save/${FILE6}

## use this command for a database server on a separate host ##
#	mysqldump --opt --protocol=TCP --user=${USER} --password=${PASS} --host=${DBSERVER} ${DATABASE} > ${FILE}

## Uncomment if sql file should be gziped ##
#	gzip /var/lib/phpMyAdmin/save/$FILE1
#	gzip /var/lib/phpMyAdmin/save/$FILE2
#	gzip /var/lib/phpMyAdmin/save/$FILE3
#	gzip /var/lib/phpMyAdmin/save/$FILE4
#	gzip /var/lib/phpMyAdmin/save/$FILE5
#	gzip /var/lib/phpMyAdmin/save/$FILE6

END=`date +%s`
RUNTIME=$((END-START))
echo "   -----   MySQLdump.sh Ended @ `date +'%m_%d_%Y_%I-%M_%p'` & Finished in $RUNTIME seconds   -----   "

} 2>&1 | tee /root/Logs/MySQLdump.log
