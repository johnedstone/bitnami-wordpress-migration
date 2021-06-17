### Configure Zabbix on separate IP (Elastic IP)
* prep: rerun playbook with listen_IP for existing internal IP
* add a 2nd interface
* assign a 2nd Elastic IP
* enable this role in private_vars.yaml: configure_zabbix: yes

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

#### Configure the operating system on your instance to recognize secondary private IPv4 addresses
* https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/MultipleIP.html#StepTwoConfigOS
* [no: this is for another interface: debian](https://aws.amazon.com/premiumsupport/knowledge-center/ec2-ubuntu-secondary-network-interface/)
* [using this](https://www.simplyhosting.cloud/knowledgebase/operating-systems/configuring-an-additional-ip-address-on-linux-server)

**Note: for Secondary IP in same subnet**
```
shell> cat /etc/network/interfaces.d/51-ens5.cfg
auto ens5:1
iface ens5:1 inet static 
   address <example: 172.31.27.160>
   netmask <example: 255.255.240.0>
   broadcast <example: 172.31.31.255>
   network <first ip, see https://www.ipaddressguide.com/cidr, example: 172.31.16.0>
   gateway <see ip route show>
```



### Background reference for installing zabbix server on debian
Not following exactly, as nginx is installed, etc.
* https://computingforgeeks.com/install-and-configure-zabbix-server-lts-on-debian/
