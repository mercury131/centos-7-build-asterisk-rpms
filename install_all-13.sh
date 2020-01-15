yum install festival -y
yum install epel-release -y

cp repo/asterisk.repo /etc/yum.repos.d/

yum install asterisk -y

sleep 30
systemctl start asterisk 
systemctl enable asterisk 

rpm -Uvh https://mirror.webtatic.com/yum/el7/webtatic-release.rpm
yum install httpd mariadb mariadb-server mysql-connector-odbc php56w php56w-common  php56w-intl php56w-ldap php56w-mbstring php56w-mysql php56w-opcache php56w-pdo php56w-pear php56w-process php56w-soap php56w-xml -y
mkdir /var/lib/asterisk/sounds && cd /var/lib/asterisk/sounds && wget http://downloads.asterisk.org/pub/telephony/sounds/asterisk-core-sounds-en-wav-current.tar.gz && wget http://downloads.asterisk.org/pub/telephony/sounds/asterisk-extra-sounds-en-wav-current.tar.gz && tar xvf asterisk-core-sounds-en-wav-current.tar.gz && rm -f asterisk-core-sounds-en-wav-current.tar.gz && tar xfz asterisk-extra-sounds-en-wav-current.tar.gz && rm -f asterisk-extra-sounds-en-wav-current.tar.gz && wget http://downloads.asterisk.org/pub/telephony/sounds/asterisk-core-sounds-en-g722-current.tar.gz && wget http://downloads.asterisk.org/pub/telephony/sounds/asterisk-extra-sounds-en-g722-current.tar.gz && tar xfz asterisk-extra-sounds-en-g722-current.tar.gz && rm -f asterisk-extra-sounds-en-g722-current.tar.gz && tar xfz asterisk-core-sounds-en-g722-current.tar.gz && rm -f asterisk-core-sounds-en-g722-current.tar.gz && chown -R asterisk:asterisk /var/lib/asterisk/sounds
cd ~/centos-7-build-asterisk-rpms/
curl -sL https://rpm.nodesource.com/setup_8.x | bash -
yum install -y nodejs
rpm -ivh FreePBX-14-build/RPMS/x86_64/freepbx-14-1.el7.x86_64.rpm
sleep 10
firewall-cmd --zone=public --add-port=80/tcp --permanent
firewall-cmd --zone=public --add-port=443/tcp --permanent
firewall-cmd --reload

amportal a ma listonline
amportal a ma install backup --repos standard, extended
amportal a ma install manager --repos standard, extended
amportal a ma install arimanager --repos standard, extended

fwconsole reload

sed -i 's|Listen 80|Listen 127.0.0.1:8090|g' /etc/httpd/conf/httpd.conf

systemctl restart httpd.service

yum install nginx -y

cp -f nginx/nginx.conf /etc/nginx/nginx.conf
cp -f nginx/conf.d/freepbx.conf /etc/nginx/conf.d/freepbx.conf

systemctl start nginx
systemctl enable nginx

systemctl restart asterisk

read -p "Install https access via let-s-encrypt (y/n)? " -n 1 -r

if [[ $REPLY =~ ^[Yy]$ ]]
then

yum install certbot-nginx -y

read -p "Enter your domain: " DOMAIN

certbot --nginx -d $DOMAIN -d www.$DOMAIN

crontab -l > mycron

echo "15 3 * * * /usr/bin/certbot renew --quiet" >> mycron

crontab mycron

rm mycron

fi