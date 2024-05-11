#!/bin/bash

# 载入配置文件
source ./config_file

# 输出 num_vm 的值
echo "The value of num_vm is: $num_vm"
echo "The value of template_id is: $template_id"

# 开始克隆虚拟机
for ((i=0; i<$num_vm; i++)); do
    vm_name="k8s-$i"
    vm_id=$((6600 + i))  # 假设虚拟机ID从101开始递增
    hex_i=$(printf '%02X' $i)  # 将数字i转换为两位的十六进制数
    mac_address="AA:BB:CC:DD:EE:$hex_i"  # MAC地址

    # 克隆虚拟机
    echo "正在从模板 $template_id 克隆虚拟机 $vm_name MAC地址 $mac_address..."
    qm clone $template_id $vm_id --name $vm_name --full true

    # 检查克隆操作是否成功
    if [ $? -eq 0 ]; then
        # 设置网络接口和MAC地址
        echo "为虚拟机 $vm_name 设置MAC地址 $mac_address ..."
        qm set $vm_id --net0 virtio=$mac_address,bridge=vmbr0
    else
        echo -e "\033[31m克隆虚拟机 $vm_name 失败\033[0m"
    fi
done

echo -e "\033[32m所有操作完成。\033[0m"