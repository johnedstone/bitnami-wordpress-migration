## Migrating Wordpress to the lates Bitnami 13-May-2021

Either the Bitnami Nginx or the Bitnami Wordpress AMI could be used, as they
are essentially the same.  The Wordpress AMI might have a few more clues, and then
one could just remove the config/files/db for the default Wordpress.

* ![bitnami images](screenshots/nginx_bitnami.png) 

*Note: vim is used below.  Feel free to use nano, etc*

#### References
* https://docs.bitnami.com/aws/how-to/install-wordpress-nginx/
* https://docs.bitnami.com/aws/how-to/generate-install-lets-encrypt-ssl/
* [Let's encyrpt - nginx](https://www.nginx.com/blog/using-free-ssltls-certificates-from-lets-encrypt-with-nginx/)

### Initial setup

Using Approach A: Bitnami installations using system packages
```
test ! -f "/opt/bitnami/common/bin/openssl" && echo "Approach A: Using system packages." || echo "Approach B: Self-contained installation."
Approach A: Using system packages.
```

Initial Setup
```
# replace ip-hostname with your hostname-of-choice
sudo vim /etc/hostname

sudo shutdown -r now

sudo apt update
sudo apt full-upgrade
sudo shutdown -r now

sudo mkdir /opt/bitnami/apps
sudo chown bitnami:daemon /opt/bitnami/apps
sudo chmod 0775 /opt/bitnami/apps
ln -s /opt/bitnami/apps ~/apps

# Setting up each app
mkdir -p /opt/bitnami/apps/<app-name>/
# Migrate files and dirs to app directory
# Migrate db data to new db

# Setting up config
sudo rsync -a /opt/bitnami/nginx/conf/server_blocks/{wordpress,<app-name>}-server-block.conf
# Edit new file: add server name, root, default server
# Disable default wordpress, and delete wordpress files if desired sudo rm -rf /opt/bitnami/wordpress
sudo mv /opt/bitnami/nginx/conf/server_blocks/wordpress-server-block.conf{,.disabled}

# Setting up https config
sudo rsync -a /opt/bitnami/nginx/conf/server_blocks/{wordpress,<app-name>}-https-server-block.conf 
sudo mv /opt/bitnami/nginx/conf/server_blocks/wordpress-https-server-block.conf{,.disabled}
# Edit new file: add server name, root, default server

# Setting up certs


# At some point
sudo find /opt/bitnami/apps/ -type d -exec chown bitnami:daemon {} \; -exec chmod 0775 {} \;
sudo find /opt/bitnami/apps/ -type f -exec chown bitnami:daemon {} \; -exec chmod 0664 {} \;

# Switch IPs, not DNS
```
