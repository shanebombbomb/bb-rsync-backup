#!/bin/bash
# dependencies
apt-get update
apt-get install rsync openssh-server -y

CRONJOB_RSYNC_DIR="/usr/local/sbin/"
CRONJOB_RSYNC_SCRIPT="bb-rsync-script.sh"
CRONJOB_RSYNC_FULL_SCRIPT_PATH=${CRONJOB_RSYNC_DIR}${CRONJOB_RSYNC_SCRIPT}

# daily at 10PM
CRON_COMMAND_INTERVAL_DAILY="* 21 * * * $CRONJOB_RSYNC_FULL_SCRIPT_PATH"
# weekly at 10PM
CRON_COMMAND_INTERVAL_WEEKLY="* 21 * * 5 $CRONJOB_RSYNC_FULL_SCRIPT_PATH"
# monthly at 10PM
CRON_COMMAND_INTERVAL_MONTHLY="* 21 30 * * $CRONJOB_RSYNC_FULL_SCRIPT_PATH"

# get current running cron file
crontab -l > current_running_cron

cp current_running_cron newcron

# replace CRON_JOB_RSYNC_SCRIPT entries, leave existing stuff
sed -i "/${CRONJOB_RSYNC_SCRIPT}/d" ./newcron

echo "What interval do you wish to run this as?"
echo "1)Daily   2)Weekly   3)Monthly"

read CRONJOB_RUNTIME_INTERVAL

if [ $CRONJOB_RUNTIME_INTERVAL -eq 1 ]
then
   echo "${CRON_COMMAND_INTERVAL_DAILY}" >> newcron
   crontab newcron
elif [ $CRONJOB_RUNTIME_INTERVAL -eq 2 ]
then
   echo "${CRON_COMMAND_INTERVAL_WEEKLY}" >> newcron
   crontab newcron
elif [ $CRONJOB_RUNTIME_INTERVAL -eq 3 ]
then
   echo "${CRON_COMMAND_INTERVAL_MONTHLY}" >> newcron
   crontab newcron
else
   echo "Sorry, invalid command"
fi

# end cleanup
rm current_running_cron
rm newcron
