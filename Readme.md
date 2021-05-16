## Migrating Wordpress to the lates Bitnami 13-May-2021

Either the Bitnami Nginx or the Bitnami Wordpress AMI could be used, as they
are essentially the same.  The Wordpress AMI might have a few more clues, and then
one could just remove the config/files/db for the default Wordpress.

* ![bitnami images](screenshots/nginx_bitnami.png) 

*Note: vim is used below.  Feel free to use nano, etc*

#### References
* https://docs.bitnami.com/aws/how-to/install-wordpress-nginx/
* https://docs.bitnami.com/aws/how-to/generate-install-lets-encrypt-ssl/
* [Let's encyrpt - nginx - avoid with bitnami as it tried to install nginx](https://www.nginx.com/blog/using-free-ssltls-certificates-from-lets-encrypt-with-nginx/)

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
# and drop default bitnami_wordpress database

# Setting up https config
sudo rsync -a /opt/bitnami/nginx/conf/server_blocks/{wordpress,<app-name>}-https-server-block.conf 
sudo mv /opt/bitnami/nginx/conf/server_blocks/wordpress-https-server-block.conf{,.disabled}
# Edit new file: add server name, root, default server

# Setting up certs


# At some point
sudo find /opt/bitnami/apps/ -type d -exec chown bitnami:daemon {} \; -exec chmod 0775 {} \;
sudo find /opt/bitnami/apps/ -type f -exec chown bitnami:daemon {} \; -exec chmod 0664 {} \;

# Switch IPs, not DNS, using Elastic IPs
```

#### Alternate approach - lego -worked
* Reference: https://docs.bitnami.com/general/how-to/generate-install-lets-encrypt-ssl/#altern

```
cd /tmp
curl -Ls https://api.github.com/repos/xenolf/lego/releases/latest | grep browser_download_url | grep linux_amd64 | cut -d '"' -f 4 | wget -i -
tar xf lego_vX.Y.Z_linux_amd64.tar.gz
sudo mkdir -p /opt/bitnami/letsencrypt
sudo mv lego /opt/bitnami/letsencrypt/lego

sudo /opt/bitnami/letsencrypt/lego --tls --path /opt/bitnami/letsencrypt --domains "www.xyz.net"  --email "johndoe@johndoe.com" run

# Example from reference
sudo ln -sf /opt/bitnami/letsencrypt/certificates/DOMAIN.key /opt/bitnami/nginx/conf/bitnami/certs/DOMAIN.key
sudo ln -sf /opt/bitnami/letsencrypt/certificates/DOMAIN.crt /opt/bitnami/nginx/conf/bitnami/certs/DOMAIN.crt
sudo chown -R root:root /opt/bitnami/nginx/conf/bitnami/certs/
sudo chmod -R 0600 /opt/bitnami/nginx/conf/bitnami/certs/
```

#### bncert -Did not work
* Reference: https://docs.bitnami.com/aws/how-to/understand-bncert/

```
# Did not work - currently only supported on Apache
wget -O bncert-linux-x64.run https://downloads.bitnami.com/files/bncert/latest/bncert-linux-x64.run
sudo mkdir /opt/bitnami/bncert
sudo mv bncert-linux-x64.run /opt/bitnami/bncert/
sudo chmod +x /opt/bitnami/bncert/bncert-linux-x64.run
sudo ln -s /opt/bitnami/bncert/bncert-linux-x64.run /opt/bitnami/bncert-tool
```
