#!/bin/bash -x

HOME_PATH=/home
OS_NAME=$(grep ^NAME /etc/os-release |awk -F= '{print$2}')

if [[ "${OS_NAME}" =~ "Amazon"* ]] || \
    [[ "${OS_NAME}" =~ "CentOS"* ]] || \
    [[ "${OS_NAME}" =~ "RedHat"* ]]; then
  sudo adduser ansible
else
  sudo adduser ansible --disabled-password --gecos ""
fi

sudo mkdir ${HOME_PATH}/ansible/.ssh
cat << EOF > ~ansible/.ssh/authorized_keys
xxxxxxxxCHAVEPUBLICAxxxxxxxxxX
EOF
chown ansible. ${HOME_PATH}/ansible/.ssh
chown ansible. ${HOME_PATH}/ansible/.ssh/authorized_keys
chmod 600 ${HOME_PATH}/ansible/.ssh/authorized_keys
chmod 700 ${HOME_PATH}/ansible/.ssh
sudo bash -c 'echo "ansible ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers'

# File to ansible wait
touch /tmp/userdata_ok.txt
