#!/bin/bash 
##!/usr/bin/env bash 

set -xe  # 有错误就退出


echo "nameserver 8.8.8.8"    >   /etc/resolv.conf  

# ## 设定 阿里dns
# echo "nameserver 223.5.5.5"    >   /etc/resolv.conf  
# echo "nameserver 223.6.6.6"    >>  /etc/resolv.conf

# 跟换阿里源
#grep "archive.ubuntu.com" /etc/apt/sources.list && \
#sed -i 's/archive.ubuntu.com/mirrors.aliyun.com/' /etc/apt/sources.list 

#grep "archive.ubuntu.com" /etc/apt/sources.list && \
#sed -i 's/ports.ubuntu.com/mirrors.aliyun.com/' /etc/apt/sources.list


#### python　源
#mkdir ${HOME}/.pip
#sudo tee ${HOME}/.pip/pip.conf <<-'EOF'
#[global]
#index-url = https://mirrors.aliyun.com/pypi/simple/
#
##(legacy|columns)
#format = columns
#
#[install]
#trusted-host=mirrors.aliyun.com
#EOF

tee ${HOME}/.bash_aliases <<-'EOF'
source /opt/ros/melodic/setup.bash
EOF
