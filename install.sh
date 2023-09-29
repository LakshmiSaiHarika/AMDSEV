#!/bin/bash

[ -e /etc/os-release ] && . /etc/os-release

# This will install all the dependent packages for qemu and ovmf to run
if [ "$ID" = "debian" ] || [ "$ID_LIKE" = "debian" ]; then
	apt-get -y install qemu ovmf
else

	#dnf install @virt edk2-ovmf -y
	dnf install qemu-kvm edk2-ovmf -y
        
fi

if [ "$ID" = "debian" ] || [ "$ID_LIKE" = "debian" ]; then
	dpkg -i linux/host/linux-image-*.deb
else
	#dnf install -y linux/host/kernel-*.rpm
	dnf install -y linux/kernel-[0-9]*host*.rpm
fi

cp kvm.conf /etc/modprobe.d/

echo
echo "Reboot the host and select the SNP Host kernel"
echo
