rsync -az --delete --backup-dir=_deleted /media/wd/data/backup /media/wd/data/nextcloud 14121@ch-s012.rsync.net: && touch /media/wd/data/backup/rsync.ok
rsync -az --delete --backup-dir=_carawonga /home/carawonga/backup 14121@ch-s012.rsync.net:carawonga && touch /media/wd/data/backup/carawonga.ok
