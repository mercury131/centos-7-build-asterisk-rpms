yum install festival -y
yum install epel-release -y
yum install libsrtp libzstd uriparser -y
yum install spandsp libtiff gmime  speex sox gnutls -y
rpm -Uvh http://springdale.math.ias.edu/data/puias/unsupported/7/x86_64//iksemel-1.4-6.sdl7.x86_64.rpm
for i in $(ls RPMS/x86_64/ | grep asterisk); do rpm -ivh RPMS/x86_64/$i; done
systemctl start asterisk
systemctl enable asterisk
rpm -Uvh https://mirror.webtatic.com/yum/el7/webtatic-release.rpm
yum install httpd mariadb mariadb-server mysql-connector-odbc php56w php56w-common  php56w-intl php56w-ldap php56w-mbstring php56w-mysql php56w-opcache php56w-pdo php56w-pear php56w-process php56w-soap php56w-xml -y
mkdir /var/lib/asterisk/sounds && cd /var/lib/asterisk/sounds && wget http://downloads.asterisk.org/pub/telephony/sounds/asterisk-core-sounds-en-wav-current.tar.gz && wget http://downloads.asterisk.org/pub/telephony/sounds/asterisk-extra-sounds-en-wav-current.tar.gz && tar xvf asterisk-core-sounds-en-wav-current.tar.gz && rm -f asterisk-core-sounds-en-wav-current.tar.gz && tar xfz asterisk-extra-sounds-en-wav-current.tar.gz && rm -f asterisk-extra-sounds-en-wav-current.tar.gz && wget http://downloads.asterisk.org/pub/telephony/sounds/asterisk-core-sounds-en-g722-current.tar.gz && wget http://downloads.asterisk.org/pub/telephony/sounds/asterisk-extra-sounds-en-g722-current.tar.gz && tar xfz asterisk-extra-sounds-en-g722-current.tar.gz && rm -f asterisk-extra-sounds-en-g722-current.tar.gz && tar xfz asterisk-core-sounds-en-g722-current.tar.gz && rm -f asterisk-core-sounds-en-g722-current.tar.gz && chown -R asterisk:asterisk /var/lib/asterisk/sounds
rpm -ivh FreePBX-14-build/RPMS/x86_64/freepbx-14-1.el7.x86_64.rpm
