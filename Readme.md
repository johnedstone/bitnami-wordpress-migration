## Migrating Wordpress to the lates Bitnami 13-May-2021

Either the Bitnami Nginx or the Bitnami Wordpress ami is being used.

*Note: vim is used below.  Feel free to use nano, etc*

#### References
*
*

### Initial setup
```
sudo vim /etc/hostname
sudo shutdown -r now
sudo apt update
sudo apt full-upgrade
sudo shutdown -r now
sudo mkdir /opt/bitnami/apps
sudo chgrp daemon /opt/bitnami/apps
sudo chmod 0775 /opt/bitnami/apps
```
