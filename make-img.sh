#/bin/bash


echo "Navigating to proxmox-k8s directory..."
cd ~/proxmox-k8s || { echo "Failed to change directory"; exit 1; }

echo "Downloading Ubuntu image..."
wget -nc https://cloud-images.ubuntu.com/noble/20241004/noble-server-cloudimg-amd64.img || { echo "Failed to download image"; exit 1; }

echo "Installing qemu and cloud-init in the image..."
virt-customize -v -a noble-server-cloudimg-amd64.img --install qemu-guest-agent --install cloud-initramfs-growroot --truncate /etc/machine-id || { echo "Failed to customize image"; exit 1; }

echo "Installing OpenMPI in the image..."
virt-customize -v -a noble-server-cloudimg-amd64.img --copy-in install-openmpi.sh:/root --run-command "chmod +x /root/install-openmpi.sh && /root/install-openmpi.sh" || { echo "Failed to install OpenMPI"; exit 1; }

echo "Script completed successfully!"
