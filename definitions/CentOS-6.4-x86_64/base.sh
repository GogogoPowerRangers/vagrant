# Base install

sed -i "s/^.*requiretty/#Defaults requiretty/" /etc/sudoers

yum -y install gcc make gcc-c++ kernel-devel-`uname -r` zlib-devel openssl-devel readline-devel sqlite-devel perl wget dkms nfs-utils

# APM as a service
yum groupinstall -y "Development Tools"
yum install -y unzip rsync ruby-devel zip
yum install -y sqlite-devel java-1.7.0-openjdk

# EPEL repository for nginx and node.js
wget http://download.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm
rpm -ivh epel-release-6-8.noarch.rpm
sudo yum install -y nginx nodejs

# Make ssh faster by not waiting on DNS
echo "UseDNS no" >> /etc/ssh/sshd_config
