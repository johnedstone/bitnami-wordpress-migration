### Don't do this: mysql_user_installation  --> dropped root user
Instead consider this: https://docs.bitnami.com/installer/infrastructure/lamp/administration/secure-server/

#### bncert -Did not work
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
