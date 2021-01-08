#! /bin/bash

# NOTE: To install minimal debian environment when selecting software deselect everything except SSH and standard system utilities

read -p "What is the username: " username_variable

# Add sbin to the path
[ ! $(cat $HOME/.bashrc | grep 'PATH=$PATH:/sbin:/usr/sbin') ] && echo 'PATH=$PATH:/sbin:/usr/sbin' >> $HOME/.bashrc
source $HOME/.bashrc




# Make normal user sudo
su -c "\
apt update && apt upgrade \
apt install sudo \
/sbin/adduser $username_variable sudo"




# Add non-free repositories
su -c "\
apt-add-repository contrib \
apt-add-repository non-free \
apt -y update && sudo apt -y upgrade"




clear
read -p "--- If this is the first time the script is run reboot and rerun it, reboot(y/n): " reboot_var
if [ $reboot_var == y ]
    then
        reboot
fi