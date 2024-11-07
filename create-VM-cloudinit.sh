#!/bin/sh

vm_id=8100
qm create $vm_id --memory 4096 --core 4 --name ubuntu-cloud --net0 virtio,bridge=vmbr0	# 创建VM
qm importdisk $vm_id noble-server-cloudimg-amd64.img local-lvm			# 把image加入到storge
qm set $vm_id --scsihw virtio-scsi-pci --scsi0 local-lvm:vm-$vm_id-disk-0	# 为虚拟机挂载镜像
qm set $vm_id --ide2 local-lvm:cloudinit				# 以CD的形式挂载cloudinit
qm set $vm_id --boot c --bootdisk scsi0					# 设置磁盘为启动盘
qm set $vm_id --serial0 socket --vga serial0				# 挂载串口的鼠标键盘和显示器
qm set $vm_id --agent enabled=1						# enable guest-agent
