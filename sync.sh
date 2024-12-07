docker exec mariadb.service sh -c 'mysqldump -uroot -p$MYSQL_ROOT_PASSWORD nextcloud' > /media/wd/data/backup/nextcloud/nextcloud_$(date "+%s").sql && touch /media/wd/data/backup/nextcloud.ok
find /media/wd/data/backup/nextcloud/ -type f -name *.sql -mtime +30 -exec rm -f {} \;
rsync -az --min-size=1 --delete --timeout=1800 --backup-dir=_deleted --exclude backup/services/var/lib/jellyfin /media/wd/data/backup /media/wd/data/nextcloud 14121@ch-s012.rsync.net: && touch /media/wd/data/backup/rsync.ok
rsync -az --min-size=1 --delete --timeout=1800 --backup-dir=_carawonga /home/carawonga/backup 14121@ch-s012.rsync.net:carawonga && touch /media/wd/data/backup/carawonga.ok
