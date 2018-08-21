#!/bin/sh
rpm --import https://www.elrepo.org/RPM-GPG-KEY-elrepo.org
rpm -Uvh http://www.elrepo.org/elrepo-release-7.0-3.el7.elrepo.noarch.rpm 
yum --disablerepo="*" --enablerepo="elrepo-kernel" list available
yum --enablerepo=elrepo-kernel install kernel-ml -y
sed -i 's/GRUB_DEFAULT=saved/GRUB_DEFAULT=0/g' /etc/default/grub
sed -i '/GRUB_DEFAULT=0/a GRUB_SAVEDEFAULT=true' /etc/default/grub
echo "List Grub No."
awk -F\' '$1=="menuentry " {print i++ " : " $2}' /etc/grub2.cfg
grub2-set-default 0
grub2-editenv list
grub2-mkconfig -o /boot/grub2/grub.cfg
echo ""
echo "Finally, reboot your machine to apply the latest kernel"
echo "and run following command to check the kernel version: uname -sr"