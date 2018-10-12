#!/bin/bash

# Detect the host os type
HOSTOS=$(awk -F= '/^NAME/{print $2}' /etc/os-release)

# Update System
# Install packages
# Set Aliases



case $HOSTOS in
	######################################################################################
	# HOST OS IS CENTOS/FEDORA/RHEL
	######################################################################################
	'"CentOS Linux"'|'Fedora'|'"Red Hat Enterprise Linux Server"')
	# Update
	printf "***Update the System\n"
	sudo yum -y -q update
	printf ">>>Update finished\n\n"
	# Install packages
	printf "***Install packages: git \n"
	sudo yum -y -q install python2 python-simplejson
	printf ">>>Installation finished\n\n"
	exit 0
	;;
	######################################################################################
	# HOST OS IS UBUNTU
	######################################################################################
	'"Ubuntu"')
	# Update
	printf "***Update the System\n"
	apt-get -y -q update && sudo apt-get -y -q upgrade
	printf ">>>Update finished\n\n"
	# Install Python modules
	printf "***Install packages: python python-simplejson\n"
	apt-get -y -q install python2 python-simplejson
	printf ">>>Installation finished\n\n"
	exit 0
	;;
	######################################################################################
	# HOST OS IS DEBIAN
	######################################################################################
	'"Debian GNU/Linux"')
	# Update
	printf "***Update the System\n"
	apt -y -q update && apt -y -q upgrade
	printf ">>>Update finished\n\n"
	# Install Python modules
	printf "***Install packages: python python-simplejson\n"
	apt -y -q install python
	printf ">>>Installation finished\n\n"

	exit 0
	;;
	*)
	echo "Unknown OS"
	exit 1
esac
