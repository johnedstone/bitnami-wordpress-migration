## Configure Zabbix on separate IP (Elastic IP)
* prep: rerun playbook with listen_IP value for existing internal IP to separate out the two IPs
* add a secondary ip address to the existing interface, which will be in the same subnet as the first IP, using cli (below)
* set `configure_2nd_ip: yes` in private_vars.yaml and rerun the playbook so that the running OS will add the secondary ip to the existing interface  
* assign a 2nd Elastic IP on the AWS Console to the secondary ip

### References on adding a 2nd IPO
* https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/MultipleIP.html
* https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/MultipleIP.html#MultipleIPReqs
* https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/using-eni.html#AvailableIpPerENI
* https://www.cloudinsidr.com/content/tip-assign-secondary-ip-ec2-instance-aws-vpc/

### Notes on assigning 2nd private ip address
#### Assign a secondary private IPv4 to an existing instance using the command line
* https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/MultipleIP.html#assignIP-existing-cmd

Using boto3/python3:
```
$ cat Pipfile
[[source]]
name = "pypi"
url = "https://pypi.org/simple"
verify_ssl = true

[dev-packages]

[packages]
boto3 = "*"

[requires]
python_version = "3.8"
```


Get network interface id:
```
aws --profile some_profile --output yaml --region us-west-2 ec2 describe-addresses
```

Add secondary private IP:
```
aws --profile some_provile --output yaml --region us-west-2 ec2  assign-private-ip-addresses --network-interface-id eni-from-above --secondary-private-ip-address-count 1 
```

### Configure the operating system on your instance to recognize secondary private IPv4 addresses
Mostly these references only pointed the way.  It took several attempts to work out the details
Check the playbook for the configuration for /etc/network/interfaces.d/secondary-ip

#### References
* https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/MultipleIP.html#StepTwoConfigOS
* [no: this is for another interface: debian](https://aws.amazon.com/premiumsupport/knowledge-center/ec2-ubuntu-secondary-network-interface/)
* [using this](https://www.simplyhosting.cloud/knowledgebase/operating-systems/configuring-an-additional-ip-address-on-linux-server)
* https://community.bitnami.com/t/assigns-second-private-ip-to-ec2-instance-running-bitnami-lamp/72576


## Background reference for installing zabbix server on debian
Not following exactly, as nginx is installed, etc.
* https://computingforgeeks.com/install-and-configure-zabbix-server-lts-on-debian/
