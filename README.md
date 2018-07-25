### rsync backup

Notes on different using rsync with various triggers to move files from one server to another over ssh with the end goal of writing a script that we can use to backup our local linux boxes to our NAS.

### Installing rsync and ssh
Rysnc and SSH must both be installed/enabled on each server (the send and recieving), for the command to work.

When using Ubuntu you can run these commands to install rsync and ssh:

```
sudo apt-get install rsync
```

```
sudo apt-get install openssh-server
```

### Prerequisites
Another requirement for successfully copying a directory between servers using rsync is to make sure that you "own" the destination folder.

You can use the ```chown``` command to change ownership from root to your user.

The command looks like this:

```
chown -R 'username' /path to destination folder
```

In my instance the command looks like this:

```
chown -R bombbomb /home/remoteuser/backup/
```
bombbomb is my user on the destination server and /home/remoteuser/backup/ is my destination path.
