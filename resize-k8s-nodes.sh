#!/bin/bash

# 载入配置文件
source ./config_file

# 输出 num_vm 的值
echo "The value of num_vm is: $num_vm"
echo "The value of template_id is: $template_id"

# 开始resize虚拟机
for ((i=0; i<$num_vm; i++)); do
    vm_name="k8s-$i"
    vm_id=$((6600 + i))  # 假设虚拟机ID从101开始递增
    hex_i=$(printf '%02X' $i)  # 将数字i转换为两位的十六进制数
    mac_address="AA:BB:CC:DD:EE:$hex_i"  # MAC地址

    # resize虚拟机
    echo "正在resize虚拟机 $vm_name MAC地址 $mac_address..."
    qm resize $vm_id scsi0 +64G         # K8S 对 SSD 存储: 至少 40 GB
    qm set $vm_id -memory 10240          # K8S 对 memory：worker节点至少8G

    # 检查启动操作是否成功
    if [ $? -eq 0 ]; then
        echo -e "\033[32mresize虚拟机 $vm_name 成功\033[0m"
    else
        echo -e "\033[31mresize虚拟机 $vm_name 失败\033[0m"
    fi
done

echo -e "\033[32m所有操作完成。\033[0m"


