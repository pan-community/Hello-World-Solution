# Copyright (c) 2020, Palo Alto Networks
#
# Permission to use, copy, modify, and/or distribute this software for any
# purpose with or without fee is hereby granted, provided that the above
# copyright notice and this permission notice appear in all copies.
#
# THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
# WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
# MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
# ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
# WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
# ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
# OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.

# Author: Scott Shoaf < sshoaf@paloaltonetworks.com >

'''
autorun.py

run the ansible auto-deploy-configure playbook to:
. license, content update, and sw update the sandbox NGFW
. configure the NGFW as a 2-zone gateway based on IronSkillet

This software is provided without support, warranty, or guarantee.
Use at your own risk.
'''

from subprocess import Popen

import click


@click.command()
@click.option("-ip", "--TARGET_IP", help="IP address of the target device", type=str, default="192.168.1.1")
@click.option("-port", "--TARGET_PORT", help="Port to communicate to device (443)", type=int, default=443)
@click.option("-u", "--TARGET_USERNAME", help="Firewall Username (admin)", type=str, default="admin")
@click.option("-p", "--TARGET_PASSWORD", help="Firewall Password (Paloalto1)", type=str, default="Paloalto1")
@click.option("-a", "--auth_code", help="licensing auth code for NGFW", type=str, default='1BADCODE')
@click.option("-v", "--desired_version", help="desired software version (10.0.3)", type=str, default='10.0.3')
@click.option("-c", "--force_content_update", help="force content update (yes)", type=str, default='yes')
@click.option("-av", "--update_av", help="update antivirus content (yes)", type=str, default='yes')
def cli(target_ip, target_port, target_username, target_password,
        auth_code, desired_version, force_content_update, update_av):
    print(f'configuring device {target_ip} as user {target_username}\n')

    # ansible command line entry with extra vars
    playbook_cmd = f'ansible-playbook -i inventory.yml auto-deploy-configure.ansible.yml' \
                   f' -e ip_address={target_ip}' \
                   f' -e username={target_username}' \
                   f' -e port={target_port}' \
                   f' -e password={target_password}' \
                   f' -e auth_code={auth_code}' \
                   f' -e desired_version={desired_version}' \
                   f' -e force_update_content={force_content_update}' \
                   f' -e update_av={update_av}'

    # run the playbook and wait until complete
    run_playbook = Popen(playbook_cmd, shell=True)
    run_playbook.wait()


if __name__ == '__main__':
    cli()
