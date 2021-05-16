## Migrating Wordpress to the lates Bitnami 13-May-2021

Using the Bitnami Wordpress Nginx AMI

* ![bitnami images](screenshots/nginx_bitnami.png) 

*Note: vim is used below.  Feel free to use nano, etc*

#### References
* https://docs.bitnami.com/aws/how-to/install-wordpress-nginx/
* https://docs.bitnami.com/aws/how-to/generate-install-lets-encrypt-ssl/
* https://docs.bitnami.com/general/how-to/generate-install-lets-encrypt-ssl/#altern
* [Let's encyrpt - nginx - *Avoid with bitnami as it tried to install nginx*](https://www.nginx.com/blog/using-free-ssltls-certificates-from-lets-encrypt-with-nginx/)

### Initial setup

* Using Approach A: Bitnami installations using system packages
```
test ! -f "/opt/bitnami/common/bin/openssl" && echo "Approach A: Using system packages." || echo "Approach B: Self-contained installation."
Approach A: Using system packages.
```

* Run setup script
```
export DB_PASSWD="xxxx"
bash ./setup_scritp
```
