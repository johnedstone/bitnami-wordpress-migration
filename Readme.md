## Migrating Wordpress to the lates Bitnami 13-May-2021

Using the Wordpress with Nginx and SSL Certified by Bitnami 5.7.1-3r05 on Debian 10 AMI

* ![bitnami images](screenshots/nginx_bitnami_2.png) 

*Note: vim is used below.  Feel free to use nano, etc*

#### References
* https://docs.bitnami.com/aws/how-to/install-wordpress-nginx/
* https://docs.bitnami.com/aws/how-to/generate-install-lets-encrypt-ssl/
* https://docs.bitnami.com/general/how-to/generate-install-lets-encrypt-ssl/#alternative-approach
* https://docs.bitnami.com/installer/infrastructure/lamp/administration/secure-server/
* [Let's encyrpt - nginx - *Avoid with bitnami as it tried to install nginx*](https://www.nginx.com/blog/using-free-ssltls-certificates-from-lets-encrypt-with-nginx/)

### Using Approach A: Bitnami installations using system packages
Do this check just to make sure your image is using the system packages

```
test ! -f "/opt/bitnami/common/bin/openssl" && echo "Approach A: Using system packages." || echo "Approach B: Self-contained installation."
Approach A: Using system packages.
```

### Initial setup
Do the following on a new image.
After this, there is no need to run these commands

```
sudo echo "my-custom-hostname" > /etc/hostname
sudo shutdown -r now
sudo apt update
sudo apt full-upgrade
sudo apt install -y git python-apt python3-pymysql python3-pip
sudo apt autoremove
sudo apt autoclean
sudo pip3 install ansible 
/usr/local/bin/ansible-galaxy collection install community.mysql

cd /home/bitnami && git clone  https://github.com/johnedstone/bitnami-wordpress-migration.git

mkdir -p /home/bitnami/configurations/bitnami-wordpress-migration
touch /home/bitnami/configurations/bitnami-wordpress-migration/private_vars.yaml
```

### Use ansible to set up your first application
First update `/home/bitnami/configurations/bitnami-wordpress-migration/private_vars.yaml` with your private information.
This file will not be in the github respository as it's contains private information.
You can use multiple applications in the private_vars.yaml file.

See `sample_private_vars_yaml` in this repository.

```
cd /home/bitnami/bitnami-wordpress-migration/playbooks
/usr/local/bin/ansible-playbook --check --diff --flush-cache -i inventory.ini playbook.yaml

# If this check runs as expected, then ...
/usr/local/bin/ansible-playbook --diff --flush-cache -i inventory.ini playbook.yaml
```

After successful initial installation:
```
sudo shutdown -r now
```

### Wordpress files
* copy over your wordpress files
* push data into database

### Lets Encyrpt
* Let's Encrypt here is configured using --tls which means the DNS entry must be correct
* Ths playbook uses this approach: [Reference](https://docs.bitnami.com/general/how-to/generate-install-lets-encrypt-ssl/#alternative-approach)
* This playbook will install lego and the cronjobs to renew the Let's Encrypt certs 
* To update lego, simply remove `/opt/bitnami/letsencrypt/lego` and rerun the playbook.
* `private_vars.yaml` allows one to use the server certs or Let's Encrypt certs
* The Let's Encrypt certs must be manually installed the first time for each domain as described below:

```
sudo /opt/bitnami/letsencrypt/lego --tls --path /opt/bitnami/letsencrypt --domains "www.xyz.net"  --email "johndoe@johndoe.com" run
sudo ln -sf /opt/bitnami/letsencrypt/certificates/www.xyz.net.key /opt/bitnami/nginx/conf/bitnami/certs/www.xyz.net.key
sudo ln -sf /opt/bitnami/letsencrypt/certificates/www.xyz.net.crt /opt/bitnami/nginx/conf/bitnami/certs/www.xyz.net.crt
sudo chown -R root:root /opt/bitnami/nginx/conf/bitnami/certs/
sudo chmod -R 0600 /opt/bitnami/nginx/conf/bitnami/certs/

```

### Switching IPs
* If one is using Elastic IPs that would be preferred over changing DNS entires
### Things not to do

**These approaches failed**

#### Don't do this: mysql_user_installation  --> dropped root user
Instead consider this: https://docs.bitnami.com/installer/infrastructure/lamp/administration/secure-server/

##### bncert -Did not work
*Did not work - currently only supported on _Apache_*
* Reference: https://docs.bitnami.com/aws/how-to/understand-bncert/

```
# Did not work - currently only supported on Apache
wget -O bncert-linux-x64.run https://downloads.bitnami.com/files/bncert/latest/bncert-linux-x64.run
sudo mkdir /opt/bitnami/bncert
sudo mv bncert-linux-x64.run /opt/bitnami/bncert/
sudo chmod +x /opt/bitnami/bncert/bncert-linux-x64.run
sudo ln -s /opt/bitnami/bncert/bncert-linux-x64.run /opt/bitnami/bncert-tool
```

#### nginx lets-encrypt: did not work

* [Let's encyrpt - nginx - *Avoid with bitnami as it tried to install nginx*](https://www.nginx.com/blog/using-free-ssltls-certificates-from-lets-encrypt-with-nginx/)
