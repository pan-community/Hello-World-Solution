# Hello World Solution

basic solution leveraging content found in the tech library

### Deploy

 * stand up VM-50 in AWS
 * update to latest 10.0.x and license
 * include content updates
 
### Configure

 * load a basic internet gateway configuration
 
### Assess

 * run a CIS-lite validation
 * use traffic gen from the host to create log data
 
 
## Auto-Install Playbook for Deploy and Configure

This playbook is a combination of other playbooks created locally or as tech
 library elements added as submodules.

 * deploy the solution topology (coming soon...)
 * baseline the ngfw (license, sw version, content updates)
 * IronSkillet + Internet gateway NGFW configuration

### Usage

This runs as part of a python3 virtual environment.

> Users will need to create the python virtual environment and
> install ansible and pan-os-python

Command to run the playbook
```bash

ansible-playbook -i inventory.yml auto-deploy-configure.yml -e 'ip_address
=192.168.55.177' -e 'username=admin' -e 'password=Sec ret Pass word' -e
 'auth_code
=IBADCODE' -e 'desired_version=10.0.3' -e 'force_update_content=yes' -e
 'update_av=yes'

```

Variables passed into the playbook:

    * ip_address/admin/password: device auth credentials
    * auth_code: VM-series auth code to license the NGFW
    * desired_version: PAN-OS sw version to load
    * force_update_content: always install content updates
    * update_av: install the anti-virus updates
    

 
 