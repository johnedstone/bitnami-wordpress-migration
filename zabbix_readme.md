### Configure Zabbix on separate IP (Elastic IP)
* prep: rerun playbook with listen_IP for existing internal IP
* add a 2nd interface
* assign a 2nd Elastic IP
* enable this role in private_vars.yaml: configure_zabbix: yes
