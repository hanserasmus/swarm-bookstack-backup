#!/bin/bash

# A small script that needs to be copied to each docker swarm node, in order to make proper backups daily of both SQL and your data folder.

# Set the variables
date=$(date +"%Y%m%d-%H:%M:%S")
original_data_path="/mnt/swarm_shared/services/bookstack/" # Enter your own path in here
backup_path="/mnt/swarm_shared/backups/bookstackapp" # Enter your own path in here
db_name="bookstackapp" # Again, change to your db name

# Check to see if the BookstackAPP DB is running on this node and grab the running container ID

running=$(docker ps | grep -i bookstack_db | awk -F' ' '{ print $1 }')

if [[ -z $running ]]; then
	exit 0
else
	docker exec $running /usr/bin/mysqldump $db_name > $backup_path/$db_name-backup-$date.sql
	echo "BookstackApp DB was dumped on $date" >> /var/log/bookstackapp_backups.log
fi

# Back up all the needed data files too, as per https://www.bookstackapp.com/docs/admin/backup-restore/

cd $original_data_path
tar -czvf $backup_path/bookstack-files-backup-$date.tar.gz .env public/uploads storage/uploads
echo "BookstackApp Files were backed up on $date" >> /var/log/bookstackapp_backups.log
