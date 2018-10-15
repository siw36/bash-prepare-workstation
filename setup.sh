#!/bin/bash

# Detect the host os type
HOSTOS=$(awk -F= '/^NAME/{print $2}' /etc/os-release)

# Set home path
UPATH=$HOME

# Function for loading animation
function loading {
        PID=$1
        i=1
        sp="/-\|" 
        echo -n ' '
        while [ -d /proc/$PID ]
        do      
                printf "\b${sp:i++%${#sp}:1}"
                sleep 0.2
        done
	printf "\n"
}
# Call the loading animation with loading $! after you've sent a command in bg with &

# Ask for sudo password
sudo printf "Starting script...\n"

######################################################################################
# OS SPECIFIC
######################################################################################

case $HOSTOS in
	######################################################################################
	# HOST OS IS FEDORA
	######################################################################################
	'Fedora')
	# Update
	printf "***Update the System\n"
	sudo yum -y -q update &
	loading $!
	printf ">>>Update finished\n\n"
	# Install packages
	printf "***Install packages: git openssh openssh-clients vim ansible wget curl\n"
	sudo yum -y -q install git openssh openssh-clients vim ansible wget curl
	printf ">>>Installation finished\n\n"
	printf "***Install azure-cli: adding azure repo key and repo\n"
	sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
	sudo sh -c 'echo -e "[azure-cli]\nname=Azure CLI\nbaseurl=https://packages.microsoft.com/yumrepos/azure-cli\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/azure-cli.repo'
	sudo yum -y -q install azure-cli
	printf ">>>Installation finished\n\n"
	;;
	######################################################################################
	# HOST OS IS RHEL
	######################################################################################
	'"Red Hat Enterprise Linux Server"')
	# Update
	printf "***Update the System\n"
	sudo yum -y -q update &
	loading $!
	printf ">>>Update finished\n\n"
	# Install packages
	printf "***Install packages: git openssh openssh-clients vim ansible wget curl\n"
	sudo subscription-manager repos --enable rhel-7-server-ansible-2.6-rpms
	sudo yum -y -q install git openssh openssh-clients vim ansible wget curl
	printf ">>>Installation finished\n\n"
	printf "***Install azure-cli: adding azure repo key and repo\n"
	sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
	sudo sh -c 'echo -e "[azure-cli]\nname=Azure CLI\nbaseurl=https://packages.microsoft.com/yumrepos/azure-cli\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/azure-cli.repo'
	sudo yum -y -q install azure-cli
	printf ">>>Installation finished\n\n"
	;;
	######################################################################################
	# HOST OS IS CENTOS
	######################################################################################
	'"CentOS Linux"')
	# Update
	printf "***Update the System\n"
	sudo yum -y -q update &
	loading $!
	printf ">>>Update finished\n\n"
	# Install EPEL
	printf "***Install EPEL repo\n"
	yum -y -q install https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
	printf ">>>Installation finished\n\n"
	# Install packages
	printf "***Install packages: git openssh openssh-clients vim ansible wget curl\n"
	sudo yum -y -q install git openssh openssh-clients vim ansible wget curl
	printf ">>>Installation finished\n\n"
	printf "***Install azure-cli: adding azure repo key and repo\n"
	sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
	sudo sh -c 'echo -e "[azure-cli]\nname=Azure CLI\nbaseurl=https://packages.microsoft.com/yumrepos/azure-cli\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/azure-cli.repo'
	sudo yum -y -q install azure-cli
	printf ">>>Installation finished\n\n"
	;;
	######################################################################################
	# HOST OS IS UBUNTU
	######################################################################################
	'"Ubuntu"')
	# Update
	printf "***Update the System\n"
	sudo apt-get -y -q update &
	loading $!
	printf ">>>Update finished\n\n"
	printf "***Upgrade the System\n"
	sudo apt-get -y -q upgrade &
	loading $!
	printf ">>>Upgrade finished\n\n"
	# Update ubuntu repos
	printf "***Update repos to use main, restricted, universe, multiverse\n"
	echo -e 'deb http://archive.ubuntu.com/ubuntu bionic main restricted universe multiverse\ndeb http://archive.ubuntu.com/ubuntu bionic-security main restricted universe multiverse\ndeb http://archive.ubuntu.com/ubuntu bionic-updates main restricted universe multiverse'  | sudo tee /etc/apt/sources.list
	sudo apt-get update
	printf ">>>Repos updated\n\n"
	# Add ansible repo
	printf "***Add ansible repo\n"
	sudo apt-get -y -q install software-properties-common
	sudo apt-add-repository -y ppa:ansible/ansible
	sudo apt-get update
	printf ">>>Repo added\n\n"
	# Install packages
	printf "***Install packages: python git vim ansible wget curl\n"
	sudo apt-get -y -q install python git vim ansible wget curl
	printf ">>>Installation finished\n\n"
	printf "***Install azure-cli: adding azure repo key and repo\n"
	AZ_REPO=$(lsb_release -cs)
	echo "deb [arch=amd64] https://packages.microsoft.com/repos/azure-cli/ $AZ_REPO main" | sudo tee /etc/apt/sources.list.d/azure-cli.list
	curl -L https://packages.microsoft.com/keys/microsoft.asc | sudo apt-key add -
	sudo apt-get update
	sudo apt-get -y -q install apt-transport-https azure-cli
	printf ">>>Installation finished\n\n"
	;;
	######################################################################################
	# HOST OS IS DEBIAN
	######################################################################################
	'"Debian GNU/Linux"')
	# Update
	printf "***Update the System\n"
	sudo apt-get -y -q update &
	loading $!
	printf ">>>Update finished\n\n"
	printf "***Upgrade the System\n"
	sudo apt-get -y -q upgrade &
	loading $!
	printf ">>>Upgrade finished\n\n"
	# Add ansible repo
	sudo echo 'deb http://ppa.launchpad.net/ansible/ansible/ubuntu trusty main' >> /etc/apt/sources.list
	sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 93C4A3FD7BB9C367
	sudo apt-get update
	# Install packages
	printf "***Install packages: python git vim ansible wget curl\n"
	sudo apt-get -y -q install python git vim ansible wget curl
	printf ">>>Installation finished\n\n"
	printf "***Install azure-cli: adding azure repo key and repo\n"
	AZ_REPO=$(lsb_release -cs)
	echo "deb [arch=amd64] https://packages.microsoft.com/repos/azure-cli/ $AZ_REPO main" | sudo tee /etc/apt/sources.list.d/azure-cli.list
	curl -L https://packages.microsoft.com/keys/microsoft.asc | sudo apt-key add -
	sudo apt-get update
	sudo apt-get -y -q install apt-transport-https azure-cli
	printf ">>>Installation finished\n\n"
	;;
	*)
	echo "Unknown OS"
	exit 1
esac


######################################################################################
# UNIVERSAL
######################################################################################
### SET ALIASES
printf "***Set aliases\n"
echo "alias vi='vim'" >> $UPATH/.bashrc
printf ">>>Aliases set\n\n"

### VIM CONFIG
printf "***Configuring vim\n"
# Check if vimrc is present
if [ ! -f $UPATH/.vimrc ]; then
    touch $UPATH/.vimrc
fi
echo 'set number' >> $UPATH/.vimrc
printf ">>>VIM configured\n\n"

### Setting up local bin dir for user
printf "***Check if $UPATH/.local/bin is present if not create it\n"
if [ ! -d $UPATH/.local/bin ]; then
    mkdir -p $UPATH/.local/bin
fi
echo 'export PATH=~/.local/bin:$PATH' >> $UPATH/.bash_profile
source $UPATH/.bash_profile
printf ">>>Check done\n\n"

### INSTALL PIP
printf "***Install pip (Python package manager)\n"
curl -o /tmp/get-pip.py -O https://bootstrap.pypa.io/get-pip.py
python /tmp/get-pip.py --user
printf ">>>Installation finished\n\n"

### INSTALL VMWARE API CLIENT
printf "***Install pyvmomi (VMware ESXi & vCenter API client)\n"
pip install --upgrade --user pyvmomi
printf ">>>Installation finished\n\n"

### INSTALL DOCKER CLIENT
printf "***Install docker (Docker client without the daemon dockerd)\n"
printf "***This script installs version 18.06.1-ce of docker\n"
printf "***Check: https://download.docker.com/linux/static/stable/x86_64/\n"
wget -O /tmp/docker-client.tar.gz https://download.docker.com/linux/static/stable/x86_64/docker-18.06.1-ce.tgz
tar -zxvf /tmp/docker-client.tar.gz -C /tmp/
mv /tmp/docker/docker $UPATH/.local/bin/docker
printf ">>>Installation finished\n\n"

### INSTALL OPENSHIFT CLIENT
printf "***Install openshift-cli: downloading oc binary from github, placing it in $UPATH/.local/bin\n"
printf "***This script installs version v3.11.0 of oc\n"
printf "***Check: https://github.com/openshift/origin/releases for a newer version\n"
wget -O /tmp/oc-client.tar.gz https://github.com/openshift/origin/releases/download/v3.11.0/openshift-origin-client-tools-v3.11.0-0cbc58b-linux-64bit.tar.gz
tar -zxvf /tmp/oc-client.tar.gz -C /tmp/
mv /tmp/openshift-origin-client-tools*/oc $UPATH/.local/bin/oc
mv /tmp/openshift-origin-client-tools*/kubectl $UPATH/.local/bin/kubectl
printf ">>>Installation finished\n\n"

### INSTALL AWS CLIENT
printf "***Install awscli\n"
$UPATH/.local/bin/pip install awscli --upgrade --user
printf ">>>Installation finished\n\n"

### REFRESH CURRENT BASH SESSION
printf "***Importing new parameters\n"
source $UPATH/.bash_profile
source $UPATH/.bashrc
source $UPATH/.vimrc
printf ">>>Import done\n\n"
printf ">>>Workstation preparation is done...\n"
printf ">>>Start a new shell to apply the new env variables!\n\n"
exit 0

