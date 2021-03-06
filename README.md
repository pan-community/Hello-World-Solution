# Common Design Principles: Hello World Solution

Table of contents:
==================

- [Hello World Solution topology](#hello-world-solution-topology)
- [Prerequisites](#prerequisites)
- [Usage](#usage)
- [Workflow options](#workflow-options)
- [Common Design Principle Stack Concept](#common-design-principle-stack-concept)
- [Tech Library Submodules](#tech-library-submodules)
- [Support Policy](#support-policy)


<br/>

# Hello World Solution topology


This solution contains a suite of pre-built automations to implement an Azure sandbox topology with a VM-series
NGFW and two Ubuntu hosts.

<img width="600" align="center" alt="hello world topology" src="https://gitlab.com/panw-gse/as/hello-world-solution/-/raw/images/solution-topology.png" xmlns="http://www.w3.org/1999/html">

<br/><br/>



Prerequisites
============

The following are required to implement the hello world solution:

* Azure subscription for the topology deployment
* VM-100 authcode activated in the [Palo Alto Networks Customer Support Portal](https://support.paloaltonetworks.com) (VM-50 is NOT supported in Azure)
* [panhandler installed](https://live.paloaltonetworks.com/t5/skillet-tools/install-and-get-started-with-panhandler/ta-p/307916) to run the solution workflow

> The VM-100 authcode will be entered during the [Baseline the NGFW](#baseline-the-ngfw) stage of the workflow. This will automatically license the NGFW
> without requiring manual support portal licensing using the CPU/UUID values.

<br/>

Usage
=====

1. import the Hello World solution repository into panhandler
2. play the 'CDP Hello World Solution' workflow skillet
3. check the boxes for required workflow stages and Submit
4. continue through the work items, inputting information as needed

> The [pahandler install and user guide](https://live.paloaltonetworks.com/t5/skillet-district/ct-p/Skillets) provides instructions
> for installation, importing and updating repositories, and running skillets.

<br/>

Workflow options
================

- [Deploy](#deploy)  
   - [deploy or destroy the topology in Azure](#deploy-or-destroy-the-topology-in-azure)
   - [Baseline the NGFW](#baseline-the-ngfw)
- [Configure](#configure)
  - [Configure the NGFW](#configure-the-ngfw)
- [Exercise](#exercise)
  - coming soon...
- [Assess](#assess)
  - [Assess the NGFW](#assess-the-ngfw)
- [Helper Utilities](#helper-utilities)
   - [load empty NGFW baseline configuration](#load-empty-ngfw-baseline-configuration)
   - [quick view of Azure IP info in panhandler context](#quick-view-of-azure-ip-info-in-panhandler-context)

The solution workflow is organized by stack layers and allows a user to select one or more options. 
Additional non-stack helper utilities are also provided

<br/>

# Deploy

### deploy or destroy the topology in Azure


This workflow stage will authenticate the user to their Azure account, allow them to
select a subscription, and then deploy the topology.

##### User Inputs
The following inputs are required to deploy the topology:

* resource group name: unique name within the subscription that contains all of 
  the topology elements
* region: select a region for the deployment location
* admin username and password: authentications for the NGFW and hosts
* PAN-OS NGFW version: software version used for the deployed image

> recommendation to use the user's last name or unique identifier as a 
> prefix for the resource group name


##### Terraform Deployment Stages

To deploy the topology, choose the 'Validate, Init, and Apply' dropdown option
after entering the user inputs

The user can also Destroy the topology by running the Deploy workflow 
option again and selecting 'Destroy'. Only the resource group name is required to destroy the 
topology although other web form fields are available

The user will click through a series of terraform stages:

    1. Init: initialize a working directory for the configuration files
    2. Validate: validate the configuration files in the working directory
    3. Plan: create the execution to deploy the topology
    4. Apply: apply the changes to reach the desired state based on the plan

> The first three stages (Init, Validate, Plan) take only a few moments 
> requiring the user to click to the next stage of the workflow. The Apply 
> stage can take 10-15 minutes to reach completion.

The public IP addresses assigned by Azure to access the topology devices 
along with the input admin username and password 
are captured at the end of this workflow stage and used to (1) update the 
target IP/user/password info in panhandler and (2) create updated input 
variables for device configuration. An output table with all topology IP addresses
is shown on screen and can be saved or printed for future reference.

> A certificate error may happen during the plan stage if the user is behind 
> a firewall or other device that may decrypt or force the use of other 
> endpoint certificates

<br/>

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

<br/>

# Configure

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

<br/>

# Exercise

coming soon...

<br/>

# Assess

### Assess the NGFW

This option allows the user to demonstrate validation skillets using a 
playlist model. 

Running the assessment will output a report showing a variety of validation 
results based on product security services.

<br/>

# Helper Utilities

These additional workflow items are used outside the standard workflow.

### load empty NGFW baseline configuration

Running this option will import and load an empty configuration as the candidate configuration using the existing administrator credentials.

### quick view of Azure IP info in panhandler context

This option will pull the Azure IP address information cached in the panhandler context. This is useful to view the public and private IP
addresses used in the topology.

<br/>

# Common Design Principle Stack Concept

The Common Design Principles concept is based on a stack model to create an extensible 
framework to mix-and-match solution elements. As an example, the same deployed topology
can be baselined with a required software version and configuration depending on the use
case. As a different example, similar deployments of a topology in separate networks can 
take advantage of the same baseline and configuration elements.

<br/>

<img width="600" align="center" alt="hello world topology" src="https://gitlab.com/panw-gse/as/hello-world-solution/-/raw/images/solution-stack.png" xmlns="http://www.w3.org/1999/html">

<br/><br/>

# Tech Library Submodules

The Common Design Principle concept also promotes solutions created using shareable and 
re-usable content housed in a tech library. Pre-built content is available for each layer
of the solution stack. This content is pulled into the hello world solution as git submodules.

The tech library content can be found at: https://gitlab.com/panw-gse/tech-library

The workflow and playlists skillets utilize the tech library to:

1. simplify solution development by referencing items from the tech library
2. use automations that may be outside a user's core competence
3. easily get source content updates without having to copy-paste content


The hello world solution uses the following tech library components:

* deployment-tools: provide the Azure login and subscription selection
* topology-1-ngfw-2-hosts: terraform templates to deploy the topology
* panos-ansible-upgrade-downgrade: Ansible playbook used to baseline the NGFW
* ironskillet-components: IronSkillet snippets used in the configure playlist
* panos-config-elements: reference snippets to configure the NGFW
* panos-validation-snippets: reference snippets for the assessment report

<br/>

<br/><br/>

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




    

 
 
