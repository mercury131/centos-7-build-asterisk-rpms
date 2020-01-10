# This repo contains spec files and etc for build Asterisk 14 RPM for Centos 7
How to build asterisk rpms on Centos 7

Build part
```
yum update -y
```
```
yum install -y wget git redhat-lsb-core wget rpmdevtools rpm-build createrepo yum-utils openssl-devel zlib-devel pcre-devel gcc
```
```
yum -y groupinstall core base "Development Tools"
```
```
yum -y install  ncurses-devel sox newt-devel libxml2-devel libtiff-devel \
  audiofile-devel gtk2-devel subversion kernel-devel git crontabs cronie \
  cronie-anacron wget vim uuid-devel sqlite-devel net-tools gnutls-devel python-devel texinfo \
  libuuid-devel
```
```
yum install -y gmime-devel iksemel-devel jansson-devel libcap-devel libedit-devel gsm-devel libical-devel libogg-devel libvorbis-devel libxslt-devel neon-devel net-snmp-devel pam-devel popt-devel spandsp-devel speex-devel libsrtp-devel uriparser-devel
```
```
cd centos-7-build-asterisk-rpms/
```
```
mkdir -p /root/rpmbuild/SOURCES/ && cd /root/rpmbuild/SOURCES/ && wget http://downloads.digium.com/pub/asterisk/releases/asterisk-14.6.1.tar.gz && cd /root/centos-7-build-asterisk-rpms/
```
```
cp /root/centos-7-build-asterisk-rpms/* /root/rpmbuild/SOURCES/
```
Download and install iksemel for FreePBX 14
```
 rpm -Uvh http://springdale.math.ias.edu/data/puias/unsupported/7/x86_64//iksemel-1.4-6.sdl7.x86_64.rpm
 rpm -Uvh http://springdale.math.ias.edu/data/puias/unsupported/7/x86_64//iksemel-devel-1.4-6.sdl7.x86_64.rpm
```
OR install iksemel from this repo
```
rpm -i iksemel-1.4-6.sdl7.x86_64.rpm

rpm -i iksemel-devel-1.4-6.sdl7.x86_64.rpm
```
```
rpmbuild -bb asterisk.spec
```

# install after build
```
yum install festival -y
yum install epel-release -y
yum install libsrtp libzstd uriparser -y
yum install spandsp libtiff gmime  speex sox gnutls -y
rpm -Uvh http://springdale.math.ias.edu/data/puias/unsupported/7/x86_64//iksemel-1.4-6.sdl7.x86_64.rpm
rpm -ivh asterisk-*
```
