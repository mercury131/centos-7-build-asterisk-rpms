#!/bin/bash



function addduty(){


if cat ./extensions_override_freepbx.conf | grep -q "####$1START####" 

then 

echo "Section $1 Already Exists"

else

echo " " >> ./extensions_override_freepbx.conf
echo " " >> ./extensions_override_freepbx.conf
echo "####$1START####" >> ./extensions_override_freepbx.conf

echo "    FIRST DUTY - $2" >> ./extensions_override_freepbx.conf
echo "    SECOND DUTY - $3" >> ./extensions_override_freepbx.conf

echo "####$1END####" >> ./extensions_override_freepbx.conf

echo "Add $1 Section to TEMP Config" 

fi

}

function removeduty(){

if cat ./extensions_override_freepbx.conf | grep -q "####$1START####" 

then

sed -i "/$1START/,/$1END/d" ./extensions_override_freepbx.conf

echo "Section $1 removed from TEMP Config" 

else 

echo "Section $1 is not Exists in TEMP Config" 

fi

}

help () {
  echo -e "\n\n#### Help guide ####"
  echo -e "\nThis Script parse nginx access log and show this information:"
  echo -e "\nUnique IP count\nTop 10 IP by accessing server\nRequests count by CODE"
  echo -e "\n## How to use it ##"
  echo -e "\n./log-analiger.sh /path/to/logfile"
  echo -e "\n## Use delay parameter for waiting ##"
  echo -e "\n./log-analiger.sh /path/to/logfile delay"
}


print () {
echo "#### Current Config:"

cat ./extensions_override_freepbx.conf

}

printorig () {
echo "#### Current Config:"

cat /etc/asterisk/extensions_override_freepbx.conf

}


apply () {
echo "#### Current TEMP Config:"
cat ./extensions_override_freepbx.conf
read -p "Are you sure to apply Temp config (y/n)? " -n 1 -r

if [[ $REPLY =~ ^[Yy]$ ]]
then
    	echo "#### Apply Temp config:"

	cat /etc/asterisk/extensions_override_freepbx.conf
	cp -f ./extensions_override_freepbx.conf /etc/asterisk/extensions_override_freepbx.conf
fi



}


if [ "$1" = "help" ] ; then

help

fi

if [ "$1" = "add" ] ; then

addduty $2 $3 $4

fi

if [ "$1" = "remove" ] ; then

removeduty $2

fi

if [ "$1" = "print" ] ; then

print

fi

if [ "$1" = "printorig" ] ; then

printorig

fi

if [ "$1" = "apply" ] ; then

apply

fi