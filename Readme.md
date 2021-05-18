## Migrating Wordpress to the lates Bitnami 13-May-2021

Using the Wordpress with Nginx and SSL Certified by Bitnami 5.7.1-3r05 on Debian 10 AMI

* ![bitnami images](screenshots/nginx_bitnami.png) 

*Note: vim is used below.  Feel free to use nano, etc*

#### References
* https://docs.bitnami.com/aws/how-to/install-wordpress-nginx/
* https://docs.bitnami.com/aws/how-to/generate-install-lets-encrypt-ssl/
* https://docs.bitnami.com/general/how-to/generate-install-lets-encrypt-ssl/#altern
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
After that, there is no need to run these commands

```
sudo apt install -y git python-apt python3-pymysql python3-pip
sudo pip3 install ansible 
/usr/local/bin/ansible-galaxy collection install community.mysql

cd /home/bitnami && git clone git@github.com:johnedstone/bitnami-wordpress-migration.git
cd /home/bitnami/bitnami-wordpress-migration && git config user.name "yourname"
cd /home/bitnami/bitnami-wordpress-migration && git config user.email "youremail@email.com"

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
```
