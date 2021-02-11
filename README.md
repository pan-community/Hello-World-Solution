# Common Design Principles: Hello World Solution

This solution contains a suite of pre-built automations to implement an Azure sandbox topology with a 
NGFW and two Ubuntu hosts.

<img width="800" align="center" alt="hello world topology" src="https://gitlab.com/panw-gse/as/hello-world-solution/-/raw/images/solution-topology.png" xmlns="http://www.w3.org/1999/html">



Common Design Principles is based on a stack model to create an extensible 
framework to mix-and-match solution elements 

### Deploy

     * Stand up the NGFW + 2 Ubuntu hosts in Azure
     * Baseline the NGFW: licensing, content updates, software upgrades
 
### Configure

     * configure the NGFW as a 3-zone/interface gateway
     * coming soon: Ubuntu host routing configuration

### Exercise

     * coming soon: traffic generation from Ubuntu hosts

### Assess

     * validation report using a small set of compliance checks
 

## Prerequisites

The following are required to use the hello world solution:

    * Azure subscription
    * VM-100 authcode (VM-50 is NOT supported in Azure)
    * panhandler installed to run the solution workflow

## Usage

1. Import the Hello World solution project
2. play the workflow skillet
3. check the boxes for required workflow stages and Submit

#### Azure Deploy with Terraform

This workflow stage will authenticate the user to their Azure account and 
select the subscription to be used for the toplogy deployment.

##### Terraform Stages
Once authenticated, a terraform template is used to implement the topology 
in Azure. 
The user will click through a series of terraform stages:

    1. Init: initialize a working directory for the configuration files
    2. Validate: validate the configuration files in the working directory
    3. Plan: create the execution to deploy the topology
    4. Apply: apply the changes to reach the desired state based on the plan

> The first three stages (Init, Validate, Plan) take only a few moments 
> requiring the user to click to the next stage of the workflow. The Apply 
> stage can take 10-15 minutes to reach completion.

> The user can also Destroy the topology by running the Deploy workflow 
> option again. Only the resource group name is required to destroy the 
> topology although other web form fields are available

> A certificate error may happen during the plan stage if the user is behind 
> a firewall or other device that may decrypt or force the user of other 
> endpoint certificates

##### User Inputs
The following inputs are required to deploy the topology:

* resource group name: unique name within the subscription that contains all of 
  the topology elements
  
    * region: select a region for the deployment location
    * admin username and password: authentications for the NGFW and hosts
    * PAN-OS NGFW version: software version used for the deployed image

> recommendation to use the user's last name or unique identifier as a 
> prefix for the resource group name

> the public IP addresses assigned by Azure to access the topology devices 
> along with the input admin username and password 
> are captured in this stage of the workflow and used to (1) update the 
> target IP/user/password info in panhandler and (2) create updated input 
> variables for device configuration

### Baseline the NGFW

This stage uses an Ansible playbook to license the firewall, apply 
content/anti-virus updates, then upgrade the software to the latest version 
if required.

##### User Inputs
The following inputs are required to baseline the NGFW:

    * auth-code: activated VM-series auth-code used for licensing
    * desired sw version: target software version for the topology
    * content updates: set as 'yes' to ensure content updates are applied

> The auth-code must be activated in the Customer Support Portal and should 
> be a VM-100 series or greater. VM-50 is not supported in Azure

> Applying the auth-code will soft reboot the NGFW. The playbook will 
> continue to reconnect during this time

### Configure the NGFW

This stage will use a configuration skillet playlist to reference existing 
snippets based on recommended practices and reference topologies.

1. Configure a subset of IronSkillet snippets to harden the device, set 
   update schedules, and configure security profiles and groups
   
2. Configure sandbox/demo elements such as idle timeout that replace 
   recommended IronSkillet configuration with demo friendly modifications
   
3. Configure interfaces, zones, routing, and security policies specific to 
   the topology that reference IronSkillet configured elements
   
> As part of the workflow, the IP address information applied in the 
> Terraform templates are captured and parsed to pre-populate the IP address 
> information for the NGFW configuration.

### Assess the NGFW

This option allows the user to demonstrate validation skillets using a 
playlist model. 

Running the assessment will output a report showing a variety of validation 
results based on product security services.

## Solution Submodules

The Common Design Principle model is based on the idea of shareable and 
re-usable content housed in a tech library. This content is pulled into the 
hello world solution as git submodules.

The tech library content can be found at: https://gitlab.com/panw-gse/tech-library


    * deployment-tools: provide the Azure login and subscription selection
    * topology-1-ngfw-2-hosts: terraform templates to deploy the topology
    * panos-ansible-upgrade-downgrade: Ansible playbook used to baseline the NGFW
    * ironskillet-components: IronSkillet snippets used in the configure playlist
    * panos-config-elements: reference snippets to configure the NGFW
    * panos-validation-snippets: reference snippets for the assessment report

The workflow and playlists skillets reference various elements within the 
submodules to:

1. simplify solution development by referencing items from the tech library
2. use automations that may be outside a user's core competence
3. easily get source content updates without having to copy-paste content

## Support Policy
The code and templates in the repo are released under an as-is, best effort,
support policy. These scripts should be seen as community supported and
Palo Alto Networks will contribute our expertise as and when possible.
We do not provide technical support or help in using or troubleshooting the
components of the project through our normal support options such as
Palo Alto Networks support teams, or ASC (Authorized Support Centers)
partners and backline support options. The underlying product used
(the VM-Series firewall) by the scripts or templates are still supported,
but the support is only for the product functionality and not for help in
deploying or using the template or script itself. Unless explicitly tagged,
all projects or work posted in our GitHub repository
(at https://github.com/PaloAltoNetworks) or sites other than our official
Downloads page on https://support.paloaltonetworks.com are provided under
the best effort policy.




    

 
 
