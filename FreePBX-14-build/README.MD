Build FreePBX

````
cd ~/centos-7-build-asterisk-rpms/FreePBX-14-build/
```

```
rpmbuild -bb free-pbx-14.spec
```


Install FreePBX


```
curl -sL https://rpm.nodesource.com/setup_8.x | bash -
yum install -y nodejs
rpm -Uvh https://mirror.webtatic.com/yum/el7/webtatic-release.rpm
```

```
yum install php56w-common
```

```
rpm -ivh ~/RPMS/x86_64/freepbx-14-1.el7.x86_64.rpm
```
