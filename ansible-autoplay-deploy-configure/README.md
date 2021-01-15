# PAN-OS Upgrade / Downgrade Playbook

> THIS IS PROTOTYPE ONLY AND NOT CURRENTLY USED IN THE SKILLET WORKFLOW

This playbook is a combination of other repos created locally or as tech library
elements added as submodules.

 * deploy the solution topology (coming soon...)
 * baseline the ngfw (license, sw version, content updates)
 * IronSkillet + Internet gateway NGFW configuration

# Usage

current run using a python environment
call the main playlist with required variables


```bash

ansible-playbook -i inventory.yml auto-deploy-configure.yml -e 'ip_address
=192.168.55.177' -e 'username=admin' -e 'password=Sec ret Pass word' -e
 'auth_code
=IBADCODE' -e 'desired_version=10.0.3' -e 'force_update_content=yes' -e
 'update_av=yes'

```

Override variables passed into the playbook:

    * ip_address/admin/password: device auth credentials
    * auth_code: VM-series auth code to license the NGFW
    * desired_version: PAN-OS sw version to load
    * force_update_content: always install content updates
    * update_av: install the anti-virus updates
    
