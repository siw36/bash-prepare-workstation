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
- awscli
- azure-cli

__Orchestration binaries__
- kubectl
- openshift client (oc)

__Further config__
- vim is set as alias for vi
- vim displays line numbers
- a directory is created in the user home dir (for local binaries like pip or oc)


# Supported Linux systems
- RHEL 7.5
- CentOS 7
- Fedora Server 28
- Debian 9.5
- Ubuntu 18.04

*Note: This script may work for other Linux derivatives. Only the above are tested.*
