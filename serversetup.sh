#!/bin/bash

editsshd () {
    sed -i "s/^#*\($1\).*/\1 $2/" /etc/ssh/sshd_config
}

addadmin () {
    local admin=$1 key=$2 home=/home/$1
    useradd --create-home --shell /bin/bash --user-group --groups admin,www-data,docker $admin
    mkdir $home/.ssh
    echo "ssh-rsa $key" >> $home/.ssh/authorized_keys
    chown -R $admin.$admin $home/.ssh
    chmod 700 $home/.ssh
    chmod 600 $home/.ssh/authorized_keys
}

addgroup admin
addgroup docker
addadmin lex "AAAAB3NzaC1yc2EAAAADAQABAAABAQDc6XeE2csNR9AkFXspZytXQnLHW71gXeuAQByLQH/EGY37xP6bpFkf6muxdDayIZYcmRYptJDJjIouq4Aen9GVst1jG4pf1Tm0xcMnPID/OqkYMYub4T28fJ/YbIl9uW/sJ4nz7Xn51o01S4iNQ3/fXhKTOM0QLlmRjaq1T6NIiK4L3Ei9p4H+o1OkqeLCUz9xPlWKcI62KDIaiA04hox83i3i/TKpB0HuMsEjMKbIaIIamGIzVzKOckrVrfRlOehMm+66d0PmE24Fim/n24UV9jzYJC18XWUzOwORhKzZUa6kq117iJIlPY+hZ38JuvjmG+xTyOXRbTnReSVFeNS3"

editsshd PermitRootLogin no
editsshd PasswordAuthentication no
editsshd PubkeyAuthentication yes

sed -i "s/^\(%admin.*\)ALL$/\1 NOPASSWD: ALL/" /etc/sudoers

service ssh restart

apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
echo 'deb https://apt.dockerproject.org/repo ubuntu-xenial main' > /etc/apt/sources.list.d/docker.list

apt-get update
apt-get upgrade
apt-get install linux-image-extra-$(uname -r) docker-engine python3-pip
