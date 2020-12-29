#!/usr/bin/env bash
123

curl http://mirrors.aliyun.com/repo/Centos-7.repo -o /etc/yum.repos.d/CentOS-Base.repo
yum install -y epel-release
yum install -y git python-pip ansible

mkdir -p ~/.pip
cat << EOF > ~/.pip/pip.conf
[global]
trusted-host =  mirrors.aliyun.com
index-url = http://mirrors.aliyun.com/pypi/simple/
EOF

if [[ ! -d /tmp/kubez-ansible ]]; then
    git clone https://github.com/yingjuncao/kubez-ansible /tmp/kubez-ansible
    cp -r /tmp/kubez-ansible/etc/kubez/ /etc/
fi

pip install /tmp/kubez-ansible/

kubez-ansible bootstrap-servers && \
kubez-ansible deploy && \
kubez-ansible post-deploy

kubectl get node
