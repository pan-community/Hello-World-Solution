# PAN-OS Upgrade / Downgrade Playbook

This playbook is a combination of other repos created locally or as tech library
elements added as submodules.

 * deploy the solution topology (coming soon...)
 * baseline the ngfw (license, sw version, content updates)
 * IronSkillet + Internet gateway NGFW configuration

# Usage

call the main playlist with required variables

NOTE: in the final copy add in all required vars such as desired sw version

```bash

ansible-playbook -i inventory.yml auto-deploy-configure.yml -e 'ip_address
=10.10.10.131' -e 'username=admin' -e 'password=HI THERE!' -e 'authcode
=ABC123' -e 'desired_version=10.0.2'
```