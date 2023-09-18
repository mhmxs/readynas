docker exec mariadb.service sh -c 'mysqldump -uroot -p$MYSQL_ROOT_PASSWORD nextcloud' > /media/wd/data/backup/nextcloud/nextcloud_$(date "+%s").sql && touch /media/wd/data/backup/nextcloud.ok 
