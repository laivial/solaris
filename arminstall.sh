#!/bin/bash
### ARM (Automatic Ripping Machine Installer Script)
#Pre-Install
sudo apt-get install regionset
sudo regionset /dev/sr0

# Install

## Set up 'arm' user
sudo groupadd arm
sudo useradd -m arm -g arm -G cdrom

## Set up repos:
sudo apt-get install git
sudo add-apt-repository ppa:heyarje/makemkv-beta
sudo add-apt-repository ppa:stebbins/handbrake-releases
sudo add-apt-repository ppa:mc3man/bionic-prop

## Install
sudo apt update
sudo apt install makemkv-bin makemkv-oss handbrake-cli libavcodec-extra abcde flac imagemagick glyrc cdparanoia at python3 python3-pip libcurl4-openssl-dev libssl-dev libdvd-pkg lolcat -y
sudo dpkg-reconfigure libdvd-pkg
sudo apt install default-jre-headless

## Install ARM
cd /opt
sudo mkdir arm
sudo chown arm:arm arm
sudo chmod 775 arm
sudo git clone https://github.com/automatic-ripping-machine/automatic-ripping-machine.git arm
cd arm
# TODO: Remove below line before merging to master
git checkout v2_master
sudo pip3 install -r requirements.txt
sudo ln -s /opt/arm/setup/51-automedia.rules /lib/udev/rules.d/
sudo ln -s /opt/arm/setup/.abcde.conf /home/arm/
cp docs/arm.yaml.sample arm.yaml
sudo mkdir /etc/arm/
sudo ln -s /opt/arm/arm.yaml /etc/arm/

## Set up drive
sudo mkdir -p /mnt/dev/sr0
echo "/dev/sr0  /mnt/dev/sr0  udf,iso9660  user,noauto,exec,utf8  0  0" >> /etc/fstab

## Finished!
clear
lolcat echo "ALL FINISHED! Reboot me now."
