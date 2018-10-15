# Prepare a new workstation for DevOps infra administration

# About
## This bash script prepares a (fresh) Linux installation for being used in a DevOps environment for administrative purposes
The following will be set up:

__Packages__
- git
- openssh
- openssh-clients
- vim
- wget
- curl
- ansible
- pip

__Cloud clients__
- aws-cli
- azure-cli

__Container related (binaries)__
- kubectl
- openshift client (oc)
- docker (only cli client)

__VMware API__
- pyvmomi

__Further config__
- vim is set as alias for vi
- vim displays line numbers
- a directory is created in the user home dir (for local binaries like pip or oc)


# Supported Linux systems (Still testing)
- RHEL 7.5
- CentOS 7
- Fedora 28 :heavy_check_mark:
- Ubuntu 18.04
- Debian 9.5

*Note: This script may work for other Linux derivatives. Only the above are tested.*
