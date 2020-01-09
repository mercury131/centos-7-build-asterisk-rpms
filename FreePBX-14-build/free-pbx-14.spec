Name:       freepbx
Version:    14
Release:    1%{?dist}
Summary:    Binarius package

Group:      System Environment/Base
License:    GPLv3+
Source0:    freepbx-14.0-latest.tgz
Source1:    %{name}.service
Requires:   mysql-connector-odbc
Requires:   mariadb-server
Requires:   mariadb
Requires:   mariadb
Requires:   httpd
Requires:   php56w
Requires:   php56w-pdo
Requires:   php56w-mysql
Requires:   php56w-mbstring
Requires:   php56w-pear
Requires:   php56w-process
Requires:   php56w-xml
Requires:   php56w-opcache
Requires:   php56w-ldap
Requires:   php56w-intl
Requires:   php56w-soap
Requires:   php56w-common
%description
FreePBX package.

%prep
%setup -c %{buildroot}/opt/freepbx-14/ #-q #unpack tarball

%build

%install
rm -rf $RPM_BUILD_ROOT
mkdir -p $RPM_BUILD_ROOT/opt/freepbx-14
cp -rfa * %{buildroot}/opt/


%files
/*


%post
/sbin/ldconfig
/sbin/chkconfig --add freepbx
%service -n freepbx restart "FreePBX daemon"
%systemd_post %{name}.service
sed -i 's/\(^SELINUX=\).*/\SELINUX=disabled/' /etc/sysconfig/selinux
sed -i 's/\(^SELINUX=\).*/\SELINUX=disabled/' /etc/selinux/config
setenforce 0
systemctl enable mariadb.service
systemctl start mariadb
systemctl enable httpd.service
systemctl start httpd.service
chown asterisk. /var/run/asterisk
chown -R asterisk. /etc/asterisk
chown -R asterisk. /var/{lib,log,spool}/asterisk
chown -R asterisk. /usr/lib64/asterisk
chown -R asterisk. /var/www/
sed -i 's/\(^upload_max_filesize = \).*/\120M/' /etc/php.ini
sed -i 's/^\(User\|Group\).*/\1 asterisk/' /etc/httpd/conf/httpd.conf
sed -i 's/AllowOverride None/AllowOverride All/' /etc/httpd/conf/httpd.conf
systemctl restart httpd.service
echo "Configure FreePBX"
cd /opt/freepbx-14/ && ./install -n
fwconsole ma install pm2
AMIPASS=$(cat /etc/asterisk/manager.conf | grep secret | awk ' {print $3 }') && cat /etc/amportal.conf | sed "s/AMPMGRPASS=[^[:space:]]*/AMPMGRPASS=$AMIPASS /g" > /etc/amportal.conf.new && mv /etc/amportal.conf /etc/amportal.conf.old && mv /etc/amportal.conf.new /etc/amportal.conf && chown asterisk:asterisk /etc/amportal.conf && fwconsole stop && fwconsole chown && fwconsole start

%postun
if [ $1 == 1 ];then
   echo "FreePBX is getting upgraded"
   rm /usr/sbin/amportal
   rm -rf /var/lib/asterisk/bin/*
   rm -rf /var/www/html/*
   rm /etc/amportal.conf
   rm /etc/asterisk/amportal.conf
   rm /etc/freepbx.conf
   rm /etc/asterisk/freepbx.conf
   %service asterisk stop
   /sbin/chkconfig --del freepbx
   mysql --user=root --execute="DROP DATABASE asterisk;"
elif [ $1 == 0 ];then
   echo "FreePBX is getting removed/uninstalled"
   rm /usr/sbin/amportal
   rm -rf /var/lib/asterisk/bin/*
   rm -rf /var/www/html/*
   rm /etc/amportal.conf
   rm /etc/asterisk/amportal.conf
   rm /etc/freepbx.conf
   rm /etc/asterisk/freepbx.conf
   rm -f /etc/asterisk/*.conf
   %service asterisk stop
   /sbin/chkconfig --del freepbx
   mysql --user=root --execute="DROP DATABASE asterisk;"
fi
