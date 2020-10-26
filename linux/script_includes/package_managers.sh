# Includes the code for package managers configuration for main configurations script

### Config for APT ###
if [ $pm_var == apt ]; then
    # Variables
    inst=install
    rmc=purge
    up=upgrade

    # Update
    sudo apt -y update && sudo apt -y upgrade

    # Install any dependencies
    sudo apt -y install curl

    # VS code
    curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
    sudo install -o root -g root -m 644 packages.microsoft.gpg /etc/apt/trusted.gpg.d/
    sudo sh -c 'echo "deb [arch=amd64 signed-by=/etc/apt/trusted.gpg.d/packages.microsoft.gpg] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'

    sudo apt-get install apt-transport-https
    sudo apt-get update
    sudo apt-get install code

    # Apps(might not install becuase apt requires all of them to be in repos, otherwise it fails)
    sudo apt-get install -y $apps_list

    # Removing
    if [ $removeSshd_var == y ]; then
        sudo apt-get --purge remove openssh-server
    fi
fi

## Config for DNF ##
if [ $pm_var == dnf ]; then
    # Variables
    inst=install
    rmc=remove
    up=update

    # Update
    sudo dnf -y update

    # RPM Fusion
    sudo dnf install -y https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
    sudo dnf -y update

    # VS code
    sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
    sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'
    sudo dnf -y update
    sudo dnf install -y code

    # Apps
    sudo dnf install -y $apps_list

    # Removing
    if [ $removeSshd_var == y ]; then
        sudo chkconfig sshd off
        sudo service sshd stop
        sudo dnf erase openssh-server
    fi
fi