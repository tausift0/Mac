#!/bin/bash

function scp(){
echo "==> Copying MagicFiles..."
sshpass -p alpine scp -o StrictHostKeyChecking=no -P 2222 Desktop/mobileactivationd_patch root@localhost:/var/h/mobileactivationd
}

function bypass(){
echo "==> Bypassing now..."
runcmd () {
    sshpass -p alpine ssh -o StrictHostKeyChecking=no root@localhost -p 2222 "$1" > /dev/null
}

echo "==> Bypassing iCloud lock..."
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
brew install hudochenkov/sshpass/sshpass

clear
echo "**************** Mac iCloud Bypass ****************"
echo
echo "=> By ThemobileStore:"
echo
echo
echo "==> Setting up SSH over USB..."
iproxy 2222 44 2> /dev/null &

runcmd () {
    sshpass -p alpine ssh -o StrictHostKeyChecking=no root@localhost -p 2222 "$1" > /dev/null
}

echo "==> Setting up files..."
runcmd "mount -o rw,union,update / && mv /usr/libexec/mobileactivationd /usr/libexec/oldmobile && mkdir /var/h && exit"

scp

bypass



echo
echo "==> Done! :)"
