#!/bin/bash
tar --exclude='/dev' --exclude='/var/lock' --exclude='/var/cache/apt/archives' --exclude='/lib/modules' --exclude='/home' --exclude='/etc/fstab' --exclude='/proc' --exclude='/sys' --exclude='/tmp' --exclude='/run' --exclude='/mnt' --exclude='/media' -zcvf - / --acls --ignore-failed-read -P | ssh linux_backup@192.168.111.100 "cat > /volume1/files/linux_backup/backup_test.tgz"
if [ $? -ne 0 ]
then
    ramble -s "Rsync on ${HOSTNAME} failed!" -b "The Rsync backup script on ${HOSTNAME} failed, please go check it out and fix."
fi
