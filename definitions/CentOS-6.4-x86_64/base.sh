# Base install

sed -i "s/^.*requiretty/#Defaults requiretty/" /etc/sudoers

cat > /etc/yum.repos.d/epel.repo << EOM
[epel]
name=epel
baseurl=http://download.fedoraproject.org/pub/epel/6/\$basearch
enabled=1
gpgcheck=0
EOM

yum -y install gcc make gcc-c++ kernel-devel-`uname -r` zlib-devel openssl-devel readline-devel sqlite-devel perl wget dkms nfs-utils

# APM as a service
yum groupinstall -y "Development Tools"
yum install -y unzip rsync ruby-devel zip
yum install -y sqlite-devel java-1.7.0-openjdk

# EPEL repository for nginx and node.js
mkdir /home/vagrant/temp
cd /home/vagrant/temp
wget http://mirrors.cat.pdx.edu/epel/6/i386/epel-release-6-8.noarch.rpm
sudo yum install -y epel-release-6-8.noarch.rpm 
sudo yum install nginx nodejs

# Make ssh faster by not waiting on DNS
echo "UseDNS no" >> /etc/ssh/sshd_config
