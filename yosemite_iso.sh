#! /bin/bash

echo "This shell script convert OS X Yosemite(10.10) to install iso file"
echo "Copyright 2011-2014 RTX1911"

hdiutil attach /Applications/Install\ OS\ X\ Yosemite.app/Contents/SharedSupport/InstallESD.dmg -noverify -nobrowse -mountpoint /Volumes/install_app
hdiutil convert /Volumes/install_app/BaseSystem.dmg -format UDSP -o /tmp/Yosemite
hdiutil resize -size 8g /tmp/Yosemite.sparseimage
hdiutil attach /tmp/Yosemite.sparseimage -noverify -nobrowse -mountpoint /Volumes/install_build
rm /Volumes/install_build/System/Installation/Packages
cp -rp /Volumes/install_app/Packages /Volumes/install_build/System/Installation/
hdiutil detach /Volumes/install_app
hdiutil detach /Volumes/install_build
hdiutil resize -size `hdiutil resize -limits /tmp/Yosemite.sparseimage | tail -n 1 | awk '{ print $1 }'`b /tmp/Yosemite.sparseimage
hdiutil convert /tmp/Yosemite.sparseimage -format UDTO -o /tmp/Yosemite
rm /tmp/Yosemite.sparseimage
mv /tmp/Yosemite.cdr ~/Desktop/Yosemite.iso

echo "Done!"
