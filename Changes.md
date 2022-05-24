### List of changes
* 24-May-2022:
    * removed "reduced unneccessary error logging", as it did return an uglier 404 error
    * changed 50x to 502 error_log, to limit scope to only 502
    * added "Server Maintenance" to 502 title tag
* 23-May-2022: Reducing unnecessary error logging
    * return 404 on php-fpm file missing
    * set default poohbear to return 444
    * added tags to playbook
    * removed duplicate task in pre_app_nginx_configuration role
    * added custom 50x.html that should refresh if it is 502

* 27-Mar-2022: Added note about `--dry-run` error when running Ansible with the `--check` parameter to Readme.md in the Ansible error section
* 27-Mar-2022: Added note about the reminder to run `git pull` when you are beginning,  near the top of the Readme.md
* 04-Mar-2022: Updated the initial Lets Encrypt command with the  `--preferred-chain "ISRG Root X1"` parameter, in order to eliminate the "DST Root CA X3" expired root chain in the initial installation command
* 04-Mar-2022: Updated the ansible playbook, which now will update the crontab entries to include the  `--preferred-chain "ISRG Root X1"` parameter 
* Sep 23, 2021: adding command to check W3TC nginx.conf file - *note that app07 is different*
```
sha256sum /opt/bitnami/apps/*/nginx.conf
c8d463dcc6fb12a728833712c83fcff06306fe9684e7cce415da53b4c0e211bd  /opt/bitnami/apps/app01/nginx.conf
c8d463dcc6fb12a728833712c83fcff06306fe9684e7cce415da53b4c0e211bd  /opt/bitnami/apps/app02/nginx.conf
c8d463dcc6fb12a728833712c83fcff06306fe9684e7cce415da53b4c0e211bd  /opt/bitnami/apps/app03/nginx.conf
c8d463dcc6fb12a728833712c83fcff06306fe9684e7cce415da53b4c0e211bd  /opt/bitnami/apps/app04/nginx.conf
c8d463dcc6fb12a728833712c83fcff06306fe9684e7cce415da53b4c0e211bd  /opt/bitnami/apps/app05/nginx.conf
c8d463dcc6fb12a728833712c83fcff06306fe9684e7cce415da53b4c0e211bd  /opt/bitnami/apps/app06/nginx.conf
874886350842768ef3df08f19ddf89997297813d5aae09e9553e85b98e896080  /opt/bitnami/apps/app07/nginx.conf
c8d463dcc6fb12a728833712c83fcff06306fe9684e7cce415da53b4c0e211bd  /opt/bitnami/apps/app08/nginx.conf

```
* Sep 21, 2021: whitelisted JetPack's IPs for xmlrpc.php
* Sep 21, 2021: added files and paths so that W3TC plugin can write to the appropriate file.
To use W3TC, before installing the plugin, add the `define('...');` line
(as you will be prompted to by W3TC) to wp-config.php, then add the plugin and
restart the server: `sudo systemctl restart bitnami.service`
