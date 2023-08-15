#!/bin/bash
PATH=$PATH:/usr/local/bin

mysql -e "STOP SLAVE";

DIR=`date +"%Y-%m-%d"`
DATE=`date +"%Y%m%d"`
MYSQL='mysql --skip-column-names'

for s in mysql `$MYSQL -u root -pHovel-080888 -e "SHOW DATABASES LIKE '%\_db'"`;
    do
    mkdir $s;
    for t in `$MYSQL -u root -pHovel-080888 -e "SHOW TABLES FROM $s"`;
        do
            /usr/bin/mysqldump -u root -pHovel-080888 --opt --master-data=2 $s $t | gzip -1 > $s/$t.gz;
        done
    done
