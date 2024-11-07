#!/bin/bash

# 获取所有虚拟机列表，排除标题行
echo "以下虚拟机将被删除："
qm list | tail -n +2 | while read vm_id vm_name rest; do
    if [[ $vm_name == ml-* ]]; then
        echo "$vm_id $vm_name"
    fi
done

# 确认删除
read -p "是否继续? (y/n): " confirm
if [ "$confirm" != "y" ]; then
    echo "删除操作已取消。"
    exit
fi

# 删除虚拟机
qm list | tail -n +2 | while read vm_id vm_name rest; do
    if [[ $vm_name == ml-* ]]; then
        echo "正在删除 $vm_name ..."
        qm destroy $vm_id
    fi
done

echo -e "\033[32m删除操作完成。\033[0m"
