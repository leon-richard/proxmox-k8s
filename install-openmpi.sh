#!/bin/bash

# 下载 OpenMPI
cd /tmp
cp /root/openmpi-5.0.5.tar.gz .
tar -zxvf openmpi-5.0.5.tar.gz
cd openmpi-5.0.5/

# 编译、链接和安装 OpenMPI
sudo mkdir -p /opt/openmpi
mkdir build
cd build
../configure --prefix=/opt/openmpi --with-zlib
echo "Configuration completed successfully."

sudo make -j$(nproc)
if [ $? -ne 0 ]; then
    echo "Error: 'make' command failed"
    exit 1
else
    echo "'make' command completed successfully."
fi

sudo make install
if [ $? -ne 0 ]; then
    echo "Error: 'make install' command failed"
    exit 1
else
    echo "'make install' command completed successfully."
fi

# 配置环境变量
echo 'export PATH=/opt/openmpi/bin:$PATH' >> /etc/profile.d/openmpi.sh
echo 'export LD_LIBRARY_PATH=/opt/openmpi/lib:$LD_LIBRARY_PATH' >> /etc/profile.d/openmpi.sh

echo "Environment variables configured successfully."
echo "OpenMPI installation completed successfully."

