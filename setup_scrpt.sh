HOSTNAME=${NEW_HOSTNAME:?'First run: export NEW_HOSTHAME=xxxxxx.  Exiting'}
DB_PASSWD=${DB_PASSWD:?'First run: export DB_PASSWD=xxxxxx.  Exiting'}
APP_NAME=${APP_NAME:?'First run: export APP_NAME=xxxxxx.  Exiting'}

sudo apt update
sudo apt install -y git rsync nmap
sudo apt full-upgrade -y

echo $HOSTNAME | sudo tee /etc/hostname

sudo mkdir /opt/bitnami/apps
sudo chown bitnami:daemon /opt/bitnami/apps
sudo chmod 0775 /opt/bitnami/apps
ln -s /opt/bitnami/apps ~/apps
mkdir /opt/bitnami/apps/$APP_NAME

mkdir /opt/bitnami/apps/wordpress_orig
sudo rsync /opt/bitname/wordpress/wp-conf.php /opt/bitname/apps/wordpress_org/
sudo rm -rf /opt/bitname/wordress

sudo find /opt/bitnami/apps/ -type d -exec chown bitnami:daemon {} \; -exec chmod 0775 {} \;
sudo find /opt/bitnami/apps/ -type f -exec chown bitnami:daemon {} \; -exec chmod 0664 {} \;

sudo mkdir /opt/bitnami/nginx/conf/server_blocks/disabled
sudo rsync /opt/bitnami/nginx/conf/server_blocks/wordpress-server-block.conf /opt/bitnami/nginx/conf/server_blocks/disabled/wordpress-server-block.conf.disabled
sudo rsync /opt/bitnami/nginx/conf/server_blocks/wordpress-https-server-block.conf /opt/bitnami/nginx/conf/server_blocks/disabled/wordpress-https-server-block.conf.disabled

# secure db
# drop wordpress db
# set up sample configurations
# set up sample hello world
# set up certs
