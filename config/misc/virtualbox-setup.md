## Linux VBox Config
### Setup Virtual Machine
- Create a VM - `VirtualBox App -> Machine -> New -> Setup everything and insert a Linux ISO`
- Setup network - `VirtualBox App -> Linux VM(Setup Before) -> Settings -> Network -> Adapter 1 -> Advanced -> Port forwarding -> Add(+) -> Name(SSH), Protocol(TCP), Host IP(127.0.0.1), Host port(64400(Random Port)), Guest IP(10.0.2.15), Guest Port(22) -> Ok`
- Setup Shared Folder - `VirtualBox App -> Linux VM(Setup Before) -> Settings -> Shared Folders -> Add(+) -> Path(Select on Host), Auto-Mount(On), Mount Point(/media/shared)

### Setup Shared Folders in the VM
- Create the folder on the path where the shared direcotry will be mounted - (Terminal in the VM)`sudo mkdir /media/shared`
- Mount and run VBox Guest CD
	* Linux VM Running Window -> Devices -> Insert Guest ISO
	* Mount the guest ISO -> (Terminal in the VM)`sudo mkdir /media/guest && sudo mount /dev/cdrom /media/guest`
	* Run the Guest ISO -> (Terminal in the VM)`cd /media/shared && ./VBoxLinuxAdditions.run && sudo adduser user vboxsf`
- Reboot -> (Terminal in the VM)`sudo reboot now`

### Usage
- SSH into VM - `ssh -p \<selected host port\> 127.0.0.1`