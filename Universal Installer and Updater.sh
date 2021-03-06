#!/bin/zsh

################################################################################
#                                                                              #
# Title:    Universal Installer and Updater                                    #
# Version:  2022.06.03                                                         #
# Author:   github.com/itjimbo                                                 #
#                                                                              #
################################################################################

# List of applications this script can install/update:

# Adobe Acrobat DC (DO NOT USE. STILL IN TESTING.)
# Adobe Acrobat Reader DC (DO NOT USE. STILL IN TESTING.)
# Adobe Creative Cloud (DO NOT USE. STILL IN TESTING.)
# Android Studio (DO NOT USE. STILL IN TESTING)
# AppCleaner
# Appium Inspector
# Appium Server GUI
# Atom
# Beyond Compare
# Citrix Workspace (DO NOT USE. STILL IN TESTING.)
# Craft Manager
# Docker
# Eclipse - Eclipse IDE For Enterprise Java And Web Developers
# Figma
# FileZilla
# Google Chrome
# JetBrains AppCode
# JetBrains DataGrip
# JetBrains IntelliJ IDEA CE
# JetBrains PyCharm CE
# JetBrains RubyMine
# JetBrains WebStorm
# Microsoft Excel
# Microsoft OneDrive
# Microsoft Outlook
# Microsoft PowerPoint
# Microsoft Teams
# Microsoft Visual Studio Code
# Microsoft Word
# Miro
# Mozilla Firefox
# OpenVPN Connect
# pgAdmin
# Postman
# Python 3
# Sketch
# Slack
# Sourcetree
# Support App
# Wireshark
# VMwareFusion (DO NOT USE. STILL IN TESTING.)

################################################################################
#                         ADD APPS BETWEEN HERE...                             #
################################################################################

function AdobeAcrobatDC() {
  appName="Adobe Acrobat"
  appHomeDirectory="/Applications/Adobe Acrobat DC"
  installerType="pkg.dmg"
  latestVersionLink=$(curl -s https://helpx.adobe.com/acrobat/release-note/release-notes-acrobat-reader.html | grep -w "<td><a" | head -1 | cut -d '"' -f2 | sed 's/[^ -~]//g')
  latestVersionFull=$(curl -fs "${latestVersionLink}" | grep ".dmg" | head -1 | grep -Eo '[0-9]*' | tail -1 | sed 's/[^ -~]//g')
  latestVersion=$(echo ${latestVersionFull} | sed 's/./&./2' | sed 's/./&./6' | sed 's/[^ -~]//g')
  armDownloadURL=""
  intelDownloadURL=""
  universalDownloadURL="https://trials.adobe.com/AdobeProducts/APRO/Acrobat_HelpX/osx10/Acrobat_DC_Web_WWMUI.dmg"
  appIcon="ACP_App"
  plistVersionString="CFBundleShortVersionString"
  officialTeamIdentifier="JQ525L2MZD"
  volumeName="Acrobat DC"
  pkgNameInVolume="Acrobat DC Installer"
  pkgSubfoldersInVolume="Acrobat DC"
  checksumAvailable="FALSE"
  armChecksum=$()
  intelChecksum=$()
  universalChecksum=$()
}

#------------------------------------------------------------------------------#

function AdobeAcrobatReaderDC() {
  appName="Adobe Acrobat Reader DC"
  appHomeDirectory="/Applications"
  installerType="pkg.dmg"
  latestVersionLink=$(curl -fs https://helpx.adobe.com/acrobat/release-note/release-notes-acrobat-reader.html | grep -w "<td><a" | head -1 | cut -d '"' -f2 | sed 's/[^ -~]//g')
  latestVersionFull=$(curl -fs "${latestVersionLink}" | grep ".dmg" | tail -1 | grep -Eo '[0-9]*' | tail -1 | sed 's/[^ -~]//g')
  latestVersion=$(echo ${latestVersionFull} | sed 's/./&./2' | sed 's/./&./6' | sed 's/[^ -~]//g')
  armDownloadURL=""
  intelDownloadURL=""
  universalDownloadURL="https://ardownload2.adobe.com/pub/adobe/reader/mac/AcrobatDC/${latestVersionFull}/AcroRdrDC_${latestVersionFull}_MUI.dmg"
  appIcon="ACP_App"
  plistVersionString="CFBundleShortVersionString"
  officialTeamIdentifier="JQ525L2MZD"
  volumeName="AcroRdrDC_${latestVersionFull}_MUI"
  pkgNameInVolume="AcroRdrDC_${latestVersionFull}_MUI"
  checksumAvailable="FALSE"
  armChecksum=$()
  intelChecksum=$()
  universalChecksum=$()
}

#------------------------------------------------------------------------------#

# https://ccmdl.adobe.com/AdobeProducts/KCCC/CCD/5_7_1/macarm64/ACCCx5_7_1_1.dmg
# https://ccmdl.adobe.com/AdobeProducts/KCCC/CCD/5_7_1/osx10/ACCCx5_7_1_1.dmg
function AdobeCreativeCloud() {
  appName="Creative Cloud"
  appHomeDirectory="/Applications/Utilities/Adobe Creative Cloud/ACC"
  installerType="pkg.dmg"
  latestVersionMainFull=$(curl -fs "https://helpx.adobe.com/download-install/kb/creative-cloud-desktop-app-download.html" | grep -o "https*.*macarm64.*dmg" | cut -d '"' -f1 | head -1 | grep -Eo '[0-9]+[_0-9]*' | head -1 | sed 's/[^ -~]//g')
  latestVersionFull=$(curl -fs "https://helpx.adobe.com/download-install/kb/creative-cloud-desktop-app-download.html" | grep -o "https*.*macarm64.*dmg" | cut -d '"' -f1 | head -1 | grep -Eo '[0-9]+[_0-9]*' | tail -1 | sed 's/[^ -~]//g')
  latestVersion=$(echo ${latestVersionFull} | tr '_' '.' | sed 's/[^ -~]//g')
  armDownloadURL=$(curl -fs "https://helpx.adobe.com/download-install/kb/creative-cloud-desktop-app-download.html" | grep -o "https*.*macarm64.*dmg" | cut -d '"' -f1 | head -1)
  intelDownloadURL=$(curl -fs "https://helpx.adobe.com/download-install/kb/creative-cloud-desktop-app-download.html" | grep -o "https*.*osx10.*dmg" | cut -d '"' -f1 | head -1)
  universalDownloadURL=""
  appIcon="CreativeCloudApp"
  plistVersionString="CFBundleShortVersionString"
  officialTeamIdentifier="JQ525L2MZD"
  volumeName="Creative Cloud"
  pkgNameInVolume="Install"
  checksumAvailable="FALSE"
  armChecksum=$()
  intelChecksum=$()
  universalChecksum=$()
}

# MUST INSTALL WITH:
# /Volumes/Creative\ Cloud/Install.app/Contents/MacOS/Install --mode=silent
#
# AND FIGMA WITH:
# /Applications/Figma.app/Contents/MacOS/DynamicUniversalApp

#------------------------------------------------------------------------------#

# DO NOT USE. STILL IN TESTING.
function AndroidStudio() {
  appName="Android Studio"
  appHomeDirectory="/Applications"
  installerType="dmg"
  latestVersion=$(curl "https://developer.android.com/studio#downloads" | grep "mac.dmg" | grep -Eo '[0-9]+[.0-9]*' | head -1 | sed 's/[^ -~]//g')
  armDownloadURL="https://redirector.gvt1.com/edgedl/android/studio/install/${latestVersion}/android-studio-${latestVersion}-mac_arm.dmg"
  intelDownloadURL="https://redirector.gvt1.com/edgedl/android/studio/install/${latestVersion}/android-studio-${latestVersion}-mac.dmg"
  universalDownloadURL=""
  appIcon="studio"
  plistVersionString="CFBundleShortVersionString"
  officialTeamIdentifier="EQHXZ8M8AV"
  volumeName=$(hdiutil info | grep "Android Studio" | sed 's/^.*Volumes\///')
  pkgNameInVolume=""
  checksumAvailable="TRUE"
  armChecksum=$()
  intelChecksum=$()
  universalChecksum=$()
}

#------------------------------------------------------------------------------#

function AppCleaner() {
  appName="AppCleaner"
  appHomeDirectory="/Applications"
  installerType="zip"
  latestVersion=$(curl -s "https://freemacsoft.net/appcleaner/" | grep "Version" | grep -Eo "[0-9]+[.0-9]*" | head -1 | sed 's/[^ -~]//g')
  armDownloadURL=""
  intelDownloadURL=""
  universalDownloadURL="https://freemacsoft.net/downloads/AppCleaner_${latestVersion}.zip"
  appIcon="AppCleaner"
  plistVersionString="CFBundleShortVersionString"
  #downloadURL=$(curl -fs https://freemacsoft.net/appcleaner/Updates.xml | xpath '//rss/channel/*/enclosure/@url' 2>/dev/null | tr " " "\n" | sort | tail -1 | cut -d '"' -f 2)
  officialTeamIdentifier="X85ZX835W9"
  volumeName=""
  pkgNameInVolume=""
  checksumAvailable="FALSE"
  armChecksum=$()
  intelChecksum=$()
  universalChecksum=$()
}

#------------------------------------------------------------------------------#

function AppiumInspector() {
  appName="Appium Inspector"
  appHomeDirectory="/Applications"
  installerType="dmg"
  latestVersion=$(curl -fs "https://github.com/appium/appium-inspector/releases" | grep "mac.zip" | sed -e 's/.*Appium-Inspector-\(.*\)-universal-mac.zip.*/\1/' | head -1 | sed 's/[^ -~]//g')
  armDownloadURL=""
  intelDownloadURL=""
  universalDownloadURL="https://github.com/appium/appium-inspector/releases/download/v${latestVersion}/Appium-Inspector-mac-${latestVersion}.dmg"
  appIcon="icon"
  plistVersionString="CFBundleShortVersionString"
  officialTeamIdentifier="UY52UFTVTM"
  volumeName="Appium Inspector ${latestVersion}-universal"
  pkgNameInVolume=""
  checksumAvailable="FALSE"
  armChecksum=$()
  intelChecksum=$()
  universalChecksum=$()
}

#------------------------------------------------------------------------------#

function AppiumServerGUI() {
  appName="Appium Server GUI"
  appHomeDirectory="/Applications"
  installerType="dmg"
  latestVersion=$(curl -fs "https://github.com/appium/appium-desktop/releases" | grep "mac.zip" | sed -e 's/.*Appium-Server-GUI-\(.*\)-mac.zip.*/\1/' | head -1 | sed 's/[^ -~]//g')
  armDownloadURL=""
  intelDownloadURL=""
  universalDownloadURL="https://github.com/appium/appium-desktop/releases/download/v${latestVersion}/Appium-Server-GUI-mac-${latestVersion}.dmg"
  appIcon="icon"
  plistVersionString="CFBundleShortVersionString"
  officialTeamIdentifier="UY52UFTVTM"
  volumeName="Appium Server GUI ${latestVersion}"
  pkgNameInVolume=""
  checksumAvailable="FALSE"
  armChecksum=$()
  intelChecksum=$()
  universalChecksum=$()
}

#------------------------------------------------------------------------------#

function Atom() {
  appName="Atom"
  appHomeDirectory="/Applications"
  installerType="zip"
  latestVersion=$(curl -fsL "https://atom.io/" | grep '"version"' | grep -Eo "[0-9]+[.0-9]*" | sed 's/[^ -~]//g')
  armDownloadURL=""
  intelDownloadURL=""
  universalDownloadURL="https://atom-installer.github.com/v${latestVersion}/atom-mac.zip"
  appIcon="atom"
  plistVersionString="CFBundleShortVersionString"
  officialTeamIdentifier="VEKTX9H2N7"
  volumeName=""
  pkgNameInVolume=""
  checksumAvailable="FALSE"
  armChecksum=$()
  intelChecksum=$()
  universalChecksum=$()
}

#------------------------------------------------------------------------------#

function BeyondCompare() {
  appName="Beyond Compare"
  appHomeDirectory="/Applications"
  installerType="zip"
  latestVersionNumber=$(curl -fs "https://www.scootersoftware.com/download.php" | grep "Current Version" | grep -Eo '[0-9]+[.0-9]*' | head -1 | sed 's/[^ -~]//g')
  latestBuildNumber=$(curl -fs "https://www.scootersoftware.com/download.php" | grep "Current Version" | grep -Eo '[0-9]+[.0-9]*' | head -2 | tail -1 | sed 's/[^ -~]//g')
  latestVersion="${latestVersionNumber}.${latestBuildNumber}"
  armDownloadURL=""
  intelDownloadURL=""
  universalDownloadURL="https://www.scootersoftware.com/BCompareOSX-${latestVersion}.zip"
  appIcon="Beyond Compare"
  plistVersionString="CFBundleShortVersionString"
  officialTeamIdentifier="BS29TEJF86"
  volumeName=""
  pkgNameInVolume=""
  checksumAvailable="FALSE"
  armChecksum=$()
  intelChecksum=$()
  universalChecksum=$()
}

#------------------------------------------------------------------------------#

# DO NOT USE. STILL IN TESTING.
function CitrixWorkspace() {
  appName="Citrix Workspace"
  appHomeDirectory="/Applications"
  installerType="pkg.dmg"
  latestVersion=$(curl "https://www.citrix.com/downloads/workspace-app/mac/workspace-app-for-mac-latest.html" | grep "<p>Version" | grep -Eo '[0-9]+[.0-9]*' | head -1 | sed 's/[^ -~]//g')
  downloadURL=$(curl -s -L "https://www.citrix.com/downloads/workspace-app/mac/workspace-app-for-mac-latest.html#ctx-dl-eula-external" | grep "dmg?" | sed "s/.*rel=.\(.*\)..id=.*/\1/" | sed "s/\/\//https:\/\//g")
  appIcon="025_Receiver_Combo_Mac"
  plistVersionString="CitrixVersionString"
  officialTeamIdentifier="S272Y5R93J"
  volumeName="Citrix Workspace"
  pkgNameInVolume="Install Citrix Workspace"
  checksumAvailable="TRUE"
  armChecksum=$()
  intelChecksum=$(curl -s "https://www.citrix.com/downloads/workspace-app/mac/workspace-app-for-mac-latest.html" | grep "SHA-256" | sed "s/<li>SHA-256 - //g" | sed "s/<\/li>//g" | sed 's/ //g' | sed 's/[^ -~]//g')
  universalChecksum=$()
}

#------------------------------------------------------------------------------#

function CraftManager() {
  appName="CraftManager"
  appHomeDirectory="/Applications"
  installerType="zip"
  latestVersion=$(curl https://craft-assets.invisionapp.com/CraftManager/production/appcast.xml | grep "Version" | head -1 | grep -Eo '[0-9]+[.0-9]*' | sed 's/[^ -~]//g')
  armDownloadURL=""
  intelDownloadURL=""
  universalDownloadURL="https://craft-assets.invisionapp.com/CraftManager/production/CraftManager.zip"
  appIcon="app"
  plistVersionString="CFBundleShortVersionString"
  officialTeamIdentifier="VRXQSNCL5W"
  volumeName=""
  pkgNameInVolume=""
  checksumAvailable="FALSE"
  armChecksum=$()
  intelChecksum=$()
  universalChecksum=$()
}

#------------------------------------------------------------------------------#

# Docker uses a custom function (quitAppDocker) to quit the app.
function Docker() {
  appName="Docker"
  appHomeDirectory="/Applications"
  installerType="dmg"
  latestVersion=$(curl "https://docs.docker.com/desktop/release-notes/" | grep "docker-desktop" | grep -Eo "[0-9]+[.0-9]*" | head -3 | tail -1 | sed 's/[^ -~]//g')
  armDownloadURL="https://desktop.docker.com/mac/main/arm64/Docker.dmg"
  intelDownloadURL="https://desktop.docker.com/mac/main/amd64/Docker.dmg"
  universalDownloadURL=""
  appIcon="AppIcon"
  plistVersionString="CFBundleShortVersionString"
  officialTeamIdentifier="9BNSXJN65R"
  volumeName="Docker"
  pkgNameInVolume=""
  checksumAvailable="FALSE"
  armChecksum=$()
  intelChecksum=$()
  universalChecksum=$()
}

#------------------------------------------------------------------------------#

function EclipseIDEForEnterpriseJavaAndWebDevelopers() {
  appName="Eclipse"
  appHomeDirectory="/Applications"
  installerType="dmg"
  latestStableRelease=$(curl -fs "https://www.eclipse.org/downloads/" | grep "&#8209;" | sed "s/&#8209;/-/g" | tail -1 | grep -Eo "[0-9]+[-0-9]*" | tail -2 | head -1 | sed 's/[^ -~]//g')
  latestVersion=$(curl -fs "https://www.eclipse.org/downloads/packages/" | grep "Eclipse ${latestStableRelease}" | grep -Eo "[0-9]+[.0-9]*" | tail -1 | sed 's/[^ -~]//g')
  armDownloadURL="https://mirrors.jevincanders.net/eclipse/technology/epp/downloads/release/${latestStableRelease}/R/eclipse-jee-${latestStableRelease}-R-macosx-cocoa-aarch64.dmg"
  intelDownloadURL="https://mirrors.jevincanders.net/eclipse/technology/epp/downloads/release/${latestStableRelease}/R/eclipse-jee-${latestStableRelease}-R-macosx-cocoa-x86_64.dmg"
  universalDownloadURL=""
  appIcon="Eclipse"
  plistVersionString="CFBundleShortVersionString"
  officialTeamIdentifier="JCDTMS22B4"
  volumeName="Eclipse"
  pkgNameInVolume=""
  checksumAvailable="FALSE"
  armChecksum=$()
  intelChecksum=$()
  universalChecksum=$()
}

#------------------------------------------------------------------------------#

# Figma uses a custom installer in this script. Check the 'determineInstaller' and 'installLatestFromFigmaZip' functions.
# Figma uses this installer: https://github.com/figma/dynamic-universal-app
function Figma() {
  appName="Figma"
  appHomeDirectory="/Applications"
  installerType="Figma.zip"
  latestVersion=$(curl -fsL https://desktop.figma.com/mac/RELEASE.json | awk -F '"' '{ print $8 }' | sed 's/[^ -~]//g')
  armDownloadURL=""
  intelDownloadURL=""
  universalDownloadURL="https://desktop.figma.com/mac-installer/Figma.zip"
  appIcon="electron"
  plistVersionString="CFBundleShortVersionString"
  officialTeamIdentifier="T8RA8NE3B7"
  volumeName=""
  pkgNameInVolume=""
  checksumAvailable="FALSE"
  armChecksum=$()
  intelChecksum=$()
  universalChecksum=$()
}

#------------------------------------------------------------------------------#

function FileZilla() {
  appName="FileZilla"
  appHomeDirectory="/Applications"
  installerType="app.tar.bz2"
  latestVersion=$(curl -fs "https://filezilla-project.org/download.php/" | grep "latest stable version" | grep -Eo '[0-9]+[.0-9]*' | sed 's/[^ -~]//g')
  armDownloadURL=""
  intelDownloadURL=""
  getUniversalDownloadURL=$(curl -fs "https://filezilla-project.org/download.php/download.php?show_all=1" | grep "macosx" | grep -Eo '".*?"' | head -1 | tr -d '"' | sed 's/[^ -~]//g')
  universalDownloadURL="${getUniversalDownloadURL}"
  appIcon="FileZilla"
  plistVersionString="CFBundleShortVersionString"
  officialTeamIdentifier="5VPGKXL75N"
  volumeName=""
  pkgNameInVolume=""
  checksumAvailable="TRUE"
  armChecksum=$()
  intelChecksum=$()
  universalChecksum=$(curl -fs "https://filezilla-project.org/download.php/download.php?details=FileZilla_${latestVersion}_macosx-x86.app.tar.bz2" | grep "SHA-512" | grep -Eo '>.*?<' | tr -d ' <>' | tail -1 | sed 's/[^ -~]//g')
}

#------------------------------------------------------------------------------#

# curl -s https://omahaproxy.appspot.com/history | grep "mac_arm64,stable" | head -1 | grep -Eo '[0-9]+[.0-9]*' | head -2 | tail -1
function GoogleChrome() {
  appName="Google Chrome"
  appHomeDirectory="/Applications"
  installerType="dmg"
  latestVersion=$(curl -s https://omahaproxy.appspot.com/history | awk -F ',' '/mac_arm64,stable/{print $3; exit}' | sed 's/[^ -~]//g')
  armDownloadURL=""
  intelDownloadURL=""
  universalDownloadURL="https://dl.google.com/chrome/mac/universal/stable/GGRO/googlechrome.dmg"
  appIcon="app"
  plistVersionString="CFBundleShortVersionString"
  officialTeamIdentifier="EQHXZ8M8AV"
  volumeName="Google Chrome"
  pkgNameInVolume=""
  checksumAvailable="FALSE"
  armChecksum=$()
  intelChecksum=$()
  universalChecksum=$()
}

#------------------------------------------------------------------------------#

function JetBrainsAppCode() {
  appName="AppCode"
  appHomeDirectory="/Applications"
  installerType="dmg"
  armDownloadURL="https://download.jetbrains.com/product?code=AC&latest&distribution=macM1"
  intelDownloadURL="https://download.jetbrains.com/product?code=AC&latest&distribution=mac"
  universalDownloadURL=""
  latestVersion=$(curl -fsIL "${armDownloadURL}" | grep -i "location" | tail -1 | sed -E 's/.*\/[a-zA-Z-]*-([0-9.]*).*[-.].*dmg/\1/g' | sed 's/[^ -~]//g')
  appIcon="appcode"
  plistVersionString="CFBundleShortVersionString"
  officialTeamIdentifier="2ZEFAR8TH3"
  volumeName="AppCode"
  pkgNameInVolume=""
  checksumAvailable="TRUE"
  armChecksum=$(curl -sf "https://download.jetbrains.com/objc/AppCode-${latestVersion}-aarch64.dmg.sha256" | awk {'print $1'} | sed 's/[^ -~]//g')
  intelChecksum=$(curl -sf "https://download.jetbrains.com/objc/AppCode-${latestVersion}.dmg.sha256" | awk {'print $1'} | sed 's/[^ -~]//g')
  universalChecksum=$()
}

#------------------------------------------------------------------------------#

function JetBrainsDataGrip() {
  appName="DataGrip"
  appHomeDirectory="/Applications"
  installerType="dmg"
  armDownloadURL="https://download.jetbrains.com/product?code=DG&latest&distribution=macM1"
  intelDownloadURL="https://download.jetbrains.com/product?code=DG&latest&distribution=mac"
  universalDownloadURL=""
  latestVersion=$(curl -fsIL "${armDownloadURL}" | grep -i "location" | tail -1 | sed -E 's/.*\/[a-zA-Z-]*-([0-9.]*).*[-.].*dmg/\1/g' | sed 's/[^ -~]//g')
  appIcon="datagrip"
  plistVersionString="CFBundleShortVersionString"
  officialTeamIdentifier="2ZEFAR8TH3"
  volumeName="DataGrip"
  pkgNameInVolume=""
  checksumAvailable="TRUE"
  armChecksum=$(curl -sf "https://download.jetbrains.com/datagrip/datagrip-${latestVersion}-aarch64.dmg.sha256" | awk {'print $1'} | sed 's/[^ -~]//g')
  intelChecksum=$(curl -sf "https://download.jetbrains.com/datagrip/datagrip-${latestVersion}.dmg.sha256" | awk {'print $1'} | sed 's/[^ -~]//g')
  universalChecksum=$()
}

#------------------------------------------------------------------------------#

function JetBrainsIntelliJIDEACE() {
  appName="IntelliJ IDEA CE"
  appHomeDirectory="/Applications"
  installerType="dmg"
  armDownloadURL="https://download.jetbrains.com/product?code=IIC&latest&distribution=macM1"
  intelDownloadURL="https://download.jetbrains.com/product?code=IIC&latest&distribution=mac"
  universalDownloadURL=""
  latestVersion=$(curl -fsIL "${armDownloadURL}" | grep -i "location" | tail -1 | sed -E 's/.*\/[a-zA-Z-]*-([0-9.]*).*[-.].*dmg/\1/g' | sed 's/[^ -~]//g')
  appIcon="idea"
  plistVersionString="CFBundleShortVersionString"
  officialTeamIdentifier="2ZEFAR8TH3"
  volumeName="IntelliJ IDEA CE"
  pkgNameInVolume=""
  checksumAvailable="TRUE"
  armChecksum=$(curl -sf "https://download.jetbrains.com/idea/ideaIC-${latestVersion}-aarch64.dmg.sha256" | awk {'print $1'} | sed 's/[^ -~]//g')
  intelChecksum=$(curl -sf "https://download.jetbrains.com/idea/ideaIC-${latestVersion}.dmg.sha256" | awk {'print $1'} | sed 's/[^ -~]//g')
  universalChecksum=$()
}

#------------------------------------------------------------------------------#

function JetBrainsPyCharmCE() {
  appName="PyCharm CE"
  appHomeDirectory="/Applications"
  installerType="dmg"
  armDownloadURL="https://download.jetbrains.com/product?code=PCC&latest&distribution=macM1"
  intelDownloadURL="https://download.jetbrains.com/product?code=PCC&latest&distribution=mac"
  universalDownloadURL=""
  latestVersion=$(curl -fsIL "${armDownloadURL}" | grep -i "location" | tail -1 | sed -E 's/.*\/[a-zA-Z-]*-([0-9.]*).*[-.].*dmg/\1/g' | sed 's/[^ -~]//g')
  appIcon="pycharm"
  plistVersionString="CFBundleShortVersionString"
  officialTeamIdentifier="2ZEFAR8TH3"
  volumeName="PyCharm CE"
  pkgNameInVolume=""
  checksumAvailable="TRUE"
  armChecksum=$(curl -sf "https://download.jetbrains.com/python/pycharm-community-${latestVersion}-aarch64.dmg.sha256" | awk {'print $1'} | sed 's/[^ -~]//g')
  intelChecksum=$(curl -sf "https://download.jetbrains.com/python/pycharm-community-${latestVersion}.dmg.sha256" | awk {'print $1'} | sed 's/[^ -~]//g')
  universalChecksum=$()
}

#------------------------------------------------------------------------------#

function JetBrainsRubyMine() {
  appName="RubyMine"
  appHomeDirectory="/Applications"
  installerType="dmg"
  armDownloadURL="https://download.jetbrains.com/product?code=RM&latest&distribution=macM1"
  intelDownloadURL="https://download.jetbrains.com/product?code=RM&latest&distribution=mac"
  universalDownloadURL=""
  latestVersion=$(curl -fsIL "${armDownloadURL}" | grep -i "location" | tail -1 | sed -E 's/.*\/[a-zA-Z-]*-([0-9.]*).*[-.].*dmg/\1/g' | sed 's/[^ -~]//g')
  appIcon="rubymine"
  plistVersionString="CFBundleShortVersionString"
  officialTeamIdentifier="2ZEFAR8TH3"
  volumeName="RubyMine"
  pkgNameInVolume=""
  checksumAvailable="TRUE"
  armChecksum=$(curl -sf "https://download.jetbrains.com/ruby/RubyMine-${latestVersion}-aarch64.dmg.sha256" | awk {'print $1'} | sed 's/[^ -~]//g')
  intelChecksum=$(curl -sf "https://download.jetbrains.com/ruby/RubyMine-${latestVersion}.dmg.sha256" | awk {'print $1'} | sed 's/[^ -~]//g')
  universalChecksum=$()
}

#------------------------------------------------------------------------------#

function JetBrainsWebStorm() {
  appName="WebStorm"
  appHomeDirectory="/Applications"
  installerType="dmg"
  armDownloadURL="https://download.jetbrains.com/product?code=WS&latest&distribution=macM1"
  intelDownloadURL="https://download.jetbrains.com/product?code=WS&latest&distribution=mac"
  universalDownloadURL=""
  latestVersion=$(curl -fsIL "${armDownloadURL}" | grep -i "location" | tail -1 | sed -E 's/.*\/[a-zA-Z-]*-([0-9.]*).*[-.].*dmg/\1/g' | sed 's/[^ -~]//g')
  appIcon="webstorm"
  plistVersionString="CFBundleShortVersionString"
  officialTeamIdentifier="2ZEFAR8TH3"
  volumeName="WebStorm"
  pkgNameInVolume=""
  checksumAvailable="TRUE"
  armChecksum=$(curl -sf "https://download.jetbrains.com/webstorm/WebStorm-${latestVersion}-aarch64.dmg.sha256" | awk {'print $1'} | sed 's/[^ -~]//g')
  intelChecksum=$(curl -sf "https://download.jetbrains.com/webstorm/WebStorm-${latestVersion}.dmg.sha256" | awk {'print $1'} | sed 's/[^ -~]//g')
  universalChecksum=$()
}

#------------------------------------------------------------------------------#

function MicrosoftExcel() {
  appName="Microsoft Excel"
  appHomeDirectory="/Applications"
  installerType="pkg"
  latestVersion=$(curl -fsIL "https://go.microsoft.com/fwlink/?linkid=525135" | grep "filename=" | grep -Eo '[0-9]+[.0-9]*' | sed 's/[^ -~]//g')
  armDownloadURL=""
  intelDownloadURL=""
  universalDownloadURL="https://go.microsoft.com/fwlink/?linkid=525135"
  appIcon="XCEL"
  plistVersionString="CFBundleVersion"
  officialTeamIdentifier="UBF8T346G9"
  volumeName=""
  pkgNameInVolume=""
  checksumAvailable="TRUE"
  armChecksum=$()
  intelChecksum=$()
  universalChecksum=$(curl -fs "https://docs.microsoft.com/en-us/officeupdates/update-history-office-for-mac" | grep -A 1 "https://go.microsoft.com/fwlink/p/?linkid=525135" | tail -1 | sed -e 's/.*>\(.*\)<.*/\1/' | tr '[:upper:]' '[:lower:]' | sed 's/[^ -~]//g')
}

#------------------------------------------------------------------------------#

function MicrosoftOneDrive() {
  appName="OneDrive"
  appHomeDirectory="/Applications"
  installerType="pkg"
  latestVersion=$(curl -fsIL "https://go.microsoft.com/fwlink/?linkid=823060" | grep "Location:" | grep -Eo '[0-9]+[.0-9]*' | sed 's/[^ -~]//g')
  armDownloadURL=""
  intelDownloadURL=""
  universalDownloadURL="https://go.microsoft.com/fwlink/?linkid=823060"
  appIcon="OneDrive"
  plistVersionString="CFBundleVersion"
  officialTeamIdentifier="UBF8T346G9"
  volumeName=""
  pkgNameInVolume=""
  checksumAvailable="FALSE"
  armChecksum=$()
  intelChecksum=$()
  universalChecksum=$()
}

#------------------------------------------------------------------------------#

function MicrosoftOutlook() {
  appName="Microsoft Outlook"
  appHomeDirectory="/Applications"
  installerType="pkg"
  latestVersion=$(curl -fsIL "https://go.microsoft.com/fwlink/?linkid=525137" | grep "filename=" | grep -Eo '[0-9]+[.0-9]*' | sed 's/[^ -~]//g')
  armDownloadURL=""
  intelDownloadURL=""
  universalDownloadURL="https://go.microsoft.com/fwlink/?linkid=525137"
  appIcon="Outlook"
  plistVersionString="CFBundleVersion"
  officialTeamIdentifier="UBF8T346G9"
  volumeName=""
  pkgNameInVolume=""
  checksumAvailable="TRUE"
  armChecksum=$()
  intelChecksum=$()
  universalChecksum=$(curl -fs "https://docs.microsoft.com/en-us/officeupdates/update-history-office-for-mac" | grep -A 1 "https://go.microsoft.com/fwlink/p/?linkid=525137" | tail -1 | sed -e 's/.*>\(.*\)<.*/\1/' | tr '[:upper:]' '[:lower:]' | sed 's/[^ -~]//g')
}

#------------------------------------------------------------------------------#

function MicrosoftPowerPoint() {
  appName="Microsoft PowerPoint"
  appHomeDirectory="/Applications"
  installerType="pkg"
  latestVersion=$(curl -fsIL "https://go.microsoft.com/fwlink/?linkid=525136" | grep "filename=" | grep -Eo '[0-9]+[.0-9]*' | sed 's/[^ -~]//g')
  armDownloadURL=""
  intelDownloadURL=""
  universalDownloadURL="https://go.microsoft.com/fwlink/?linkid=525136"
  appIcon="PPT3"
  plistVersionString="CFBundleVersion"
  officialTeamIdentifier="UBF8T346G9"
  volumeName=""
  pkgNameInVolume=""
  checksumAvailable="TRUE"
  armChecksum=$()
  intelChecksum=$()
  universalChecksum=$(curl -fs "https://docs.microsoft.com/en-us/officeupdates/update-history-office-for-mac" | grep -A 1 "https://go.microsoft.com/fwlink/p/?linkid=525136" | tail -1 | sed -e 's/.*>\(.*\)<.*/\1/' | tr '[:upper:]' '[:lower:]' | sed 's/[^ -~]//g')
}

#------------------------------------------------------------------------------#

function MicrosoftTeams() {
  appName="Microsoft Teams"
  appHomeDirectory="/Applications"
  installerType="pkg"
  latestVersion=$(curl -fsIL "https://go.microsoft.com/fwlink/?linkid=869428" | grep "location:" | grep -Eo '[0-9]+[.0-9]*' | sed 's/[^ -~]//g')
  armDownloadURL=""
  intelDownloadURL=""
  universalDownloadURL="https://go.microsoft.com/fwlink/?linkid=869428"
  appIcon="icon"
  plistVersionString="CFBundleGetInfoString"
  officialTeamIdentifier="UBF8T346G9"
  volumeName=""
  pkgNameInVolume=""
  checksumAvailable="FALSE"
  armChecksum=$()
  intelChecksum=$()
  universalChecksum=$()
}

#------------------------------------------------------------------------------#

function MicrosoftVisualStudioCode() {
  appName="Visual Studio Code"
  appHomeDirectory="/Applications"
  installerType="zip"
  latestVersion=$(curl -fsL "https://code.visualstudio.com/Updates" | grep "darwin-universal" | grep -Eo '[0-9]+[.0-9]*' | head -1 | sed 's/[^ -~]//g')
  armDownloadURL=""
  intelDownloadURL=""
  universalDownloadURL="https://go.microsoft.com/fwlink/?LinkID=2156837"
  appIcon="Code"
  plistVersionString="CFBundleShortVersionString"
  officialTeamIdentifier="UBF8T346G9"
  volumeName=""
  pkgNameInVolume=""
  checksumAvailable="FALSE"
  armChecksum=$()
  intelChecksum=$()
  universalChecksum=$()
}

#------------------------------------------------------------------------------#

function MicrosoftWord() {
  appName="Microsoft Word"
  appHomeDirectory="/Applications"
  installerType="pkg"
  latestVersion=$(curl -fsIL "https://go.microsoft.com/fwlink/?linkid=525134" | grep "filename=" | grep -Eo '[0-9]+[.0-9]*' | sed 's/[^ -~]//g')
  armDownloadURL=""
  intelDownloadURL=""
  universalDownloadURL="https://go.microsoft.com/fwlink/?linkid=525134"
  appIcon="MSWD"
  plistVersionString="CFBundleVersion"
  officialTeamIdentifier="UBF8T346G9"
  volumeName=""
  pkgNameInVolume=""
  checksumAvailable="TRUE"
  armChecksum=$()
  intelChecksum=$()
  universalChecksum=$(curl -fs "https://docs.microsoft.com/en-us/officeupdates/update-history-office-for-mac" | grep -A 1 "https://go.microsoft.com/fwlink/p/?linkid=525134" | tail -1 | sed -e 's/.*>\(.*\)<.*/\1/' | tr '[:upper:]' '[:lower:]' | sed 's/[^ -~]//g')
}

#------------------------------------------------------------------------------#

# Miro policy must use the LATEST VERSION parameter in Jamf as it cannot currently be obtained online.
function Miro() {
  appName="Miro"
  appHomeDirectory="/Applications"
  installerType="dmg"
  latestVersion=$()
  armDownloadURL="https://desktop.miro.com/platforms/darwin-arm64/Miro.dmg"
  intelDownloadURL="https://desktop.miro.com/platforms/darwin/Miro.dmg"
  universalDownloadURL=""
  appIcon="electron"
  plistVersionString="CFBundleShortVersionString"
  officialTeamIdentifier="M3GM7MFY7U"
  volumeName="Miro"
  pkgNameInVolume=""
  checksumAvailable="FALSE"
  armChecksum=$()
  intelChecksum=$()
  universalChecksum=$()
}

#------------------------------------------------------------------------------#

# curl "https://www.mozilla.org/en-US/firefox/releases/" | grep -Eo 'data-latest-firefox.{0,15}' | grep -Eo '[0-9]+[.0-9]*'
function MozillaFirefox() {
  appName="Firefox"
  appHomeDirectory="/Applications"
  installerType="dmg"
  latestVersion=$(curl "https://www.mozilla.org/en-US/firefox/releases/" | grep 'data-latest-firefox' | grep -Eo '[0-9]+[.0-9]*' | head -2 | tail -1 | sed 's/[^ -~]//g')
  armDownloadURL=""
  intelDownloadURL=""
  universalDownloadURL="https://download-installer.cdn.mozilla.net/pub/firefox/releases/${latestVersion}/mac/en-US/Firefox%20${latestVersion}.dmg"
  appIcon="firefox"
  plistVersionString="CFBundleShortVersionString"
  officialTeamIdentifier="43AQ936H96"
  volumeName="Firefox"
  pkgNameInVolume=""
  checksumAvailable="TRUE"
  armChecksum=$()
  intelChecksum=$()
  universalChecksum=$(curl "https://archive.mozilla.org/pub/firefox/releases/${latestVersion}/SHA256SUMS" | grep "mac/en-US/Firefox ${latestVersion}.dmg" | awk {'print $1'})
}

#------------------------------------------------------------------------------#

function OpenVPNConnect() {
  appName="OpenVPN Connect"
  appHomeDirectory="/Applications/OpenVPN Connect"
  installerType="pkg.dmg"
  latestVersion=$(curl -fs "https://openvpn.net/client-connect-vpn-for-mac-os/" | grep "Release notes for" | grep -Eo '[0-9]+[.0-9]*' | head -1 | sed 's/[^ -~]//g')
  latestVersionUnderscore=$(echo ${latestVersion} | tr '.' '_')
  latestBuildNumber=$(curl -fs "https://openvpn.net/client-connect-vpn-for-mac-os/" | grep "Release notes for" | grep -Eo '[0-9]+[.0-9]*' | head -2 | tail -1 | sed 's/[^ -~]//g')
  armDownloadURL=""
  intelDownloadURL=""
  universalDownloadURL="https://swupdate.openvpn.net/downloads/connect/openvpn-connect-${latestVersion}.${latestBuildNumber}_signed.dmg"
  appIcon="electron"
  plistVersionString="CFBundleShortVersionString"
  officialTeamIdentifier="ACV7L3WCD8"
  volumeName="OpenVPN Connect"
  pkgNameInVolume="OpenVPN_Connect_${latestVersionUnderscore}(${latestBuildNumber})_Installer_signed"
  checksumAvailable="TRUE"
  armChecksum=$()
  intelChecksum=$()
  universalChecksum=$(curl -fs "https://openvpn.net/client-connect-vpn-for-mac-os/" | grep "sha256 signature" | head -1 | sed -e 's/.*: \(.*\)<.*/\1/' | sed 's/[^ -~]//g')
}

#------------------------------------------------------------------------------#

function pgAdmin() {
  appName="pgAdmin 4"
  appHomeDirectory="/Applications"
  installerType="dmg"
  latestVersion=$(curl -fs "https://www.pgadmin.org/download/pgadmin-4-macos/" | grep "https://www.postgresql.org/ftp/pgadmin/*.*macos/"  | head -1 | cut -d '"' -f8 | grep -Eo '[0-9]+[.0-9]*' | tail -1 | sed 's/[^ -~]//g')
  armDownloadURL=""
  intelDownloadURL=""
  universalDownloadURL="https://ftp.postgresql.org/pub/pgadmin/pgadmin4/v${latestVersion}/macos/pgadmin4-${latestVersion}.dmg"
  appIcon="app"
  plistVersionString="CFBundleShortVersionString"
  officialTeamIdentifier="26QKX55P9K"
  volumeName="pgAdmin 4"
  pkgNameInVolume=""
  checksumAvailable="FALSE"
  armChecksum=$()
  intelChecksum=$()
  universalChecksum=$()
}

#------------------------------------------------------------------------------#

function Postman() {
  appName="Postman"
  appHomeDirectory="/Applications"
  installerType="zip"
  latestVersion=$(curl -sI "https://dl.pstmn.io/download/latest/osx_64" | grep "Content-Disposition" | grep -Eo '[0-9]+[.0-9]*' | head -2 | tail -1 | sed 's/[^ -~]//g')
  armDownloadURL="https://dl.pstmn.io/download/latest/osx_arm64"
  intelDownloadURL="https://dl.pstmn.io/download/latest/osx_64"
  universalDownloadURL="https://dl.pstmn.io/download/latest/osx_64"
  appIcon="app"
  plistVersionString="CFBundleShortVersionString"
  officialTeamIdentifier="H7H8Q7M5CK"
  volumeName=""
  pkgNameInVolume=""
  checksumAvailable="FALSE"
  armChecksum=$()
  intelChecksum=$()
  universalChecksum=$()
}

#------------------------------------------------------------------------------#

function Python3() {
  appName="Python Launcher"
  installerType="pkg"
  latestVersion=$(curl -s "https://www.python.org/downloads/macos/" | grep "Latest" | head -1 | grep -Eo '[0-9]+[.0-9]*' | tail -1 | sed 's/[^ -~]//g')
  latestActiveRelease=$(echo ${latestVersion} | awk -F. '{print $1 "." $2}')
  armDownloadURL=""
  intelDownloadURL=""
  universalDownloadURL="https://www.python.org/ftp/python/${latestVersion}/python-${latestVersion}-macos11.pkg"
  appHomeDirectory="/Applications/Python ${latestActiveRelease}"
  appIcon="PythonLauncher"
  plistVersionString="CFBundleShortVersionString"
  officialTeamIdentifier="DJ3H93M7VJ"
  volumeName=""
  pkgNameInVolume=""
  checksumAvailable="FALSE"
  armChecksum=$()
  intelChecksum=$()
  universalChecksum=$()
}

#------------------------------------------------------------------------------#

function Sketch() {
  appName="Sketch"
  appHomeDirectory="/Applications"
  installerType="zip"
  latestVersion=$(curl -fs "https://www.sketch.com/updates/" | grep "Download Sketch Version" | head -1 | grep -Eo '[0-9]+[.0-9]*' | sed 's/[^ -~]//g')
  armDownloadURL=""
  intelDownloadURL=""
  universalDownloadURL="http://download.sketchapp.com/sketch.zip"
  appIcon="app"
  plistVersionString="CFBundleShortVersionString"
  officialTeamIdentifier="WUGMZZ5K46"
  volumeName=""
  pkgNameInVolume=""
  checksumAvailable="FALSE"
  armChecksum=$()
  intelChecksum=$()
  universalChecksum=$()
}

#------------------------------------------------------------------------------#

# Additional download URLs:
# armDownloadURL="https://downloads.slack-edge.com/releases/macos/${latestVersion}/prod/arm64/Slack-${latestVersion}-macOS.dmg"
# intelDownloadURL="https://downloads.slack-edge.com/releases/macos/${latestVersion}/prod/x64/Slack-${latestVersion}-macOS.dmg"
# universalDownloadURL="https://downloads.slack-edge.com/releases/macos/${latestVersion}/prod/universal/Slack-${latestVersion}-macOS.dmg"

function Slack() {
  appName="Slack"
  appHomeDirectory="/Applications"
  installerType="dmg"
  latestVersion=$(curl -sI https://slack.com/ssb/download-osx | grep "location" | grep -Eo "[0-9]+[.0-9]*" | tail -1 | sed 's/[^ -~]//g')
  armDownloadURL="https://slack.com/ssb/download-osx-silicon"
  intelDownloadURL="https://slack.com/ssb/download-osx"
  universalDownloadURL="https://slack.com/ssb/download-osx-universal"
  appIcon="electron"
  plistVersionString="CFBundleShortVersionString"
  officialTeamIdentifier="BQR82RBBHL"
  volumeName="Slack"
  pkgNameInVolume=""
  checksumAvailable="FALSE"
  armChecksum=$()
  intelChecksum=$()
  universalChecksum=$()
}

#------------------------------------------------------------------------------#

function Sourcetree() {
  appName="Sourcetree"
  appHomeDirectory="/Applications"
  installerType="zip"
  latestVersion=$(curl -fs curl -fs "https://www.sourcetreeapp.com" | tr ' ' '\n' | grep "macURL" | grep -Eo '[0-9]+[.0-9]*' | head -1 | sed 's/[^ -~]//g')
  latestBuildNumber=$(curl -fs curl -fs "https://www.sourcetreeapp.com" | tr ' ' '\n' | grep "macURL" | grep -Eo '[0-9]+[.0-9]*' | tail -1 | tr -d '.' | sed 's/[^ -~]//g')
  armDownloadURL=""
  intelDownloadURL=""
  universalDownloadURL="https://product-downloads.atlassian.com/software/sourcetree/ga/Sourcetree_${latestVersion}_${latestBuildNumber}.zip"
  appIcon="sourcetree"
  plistVersionString="CFBundleShortVersionString"
  officialTeamIdentifier="UPXU4CQZ5P"
  volumeName=""
  pkgNameInVolume=""
  checksumAvailable="FALSE"
  armChecksum=$()
  intelChecksum=$()
  universalChecksum=$()
}

#------------------------------------------------------------------------------#

# Support App by Root3
# https://github.com/root3nl/SupportApp
function SupportApp() {
  appName="Support"
  appHomeDirectory="/Applications"
  installerType="pkg"
  latestVersion=$(curl -fs "https://github.com/root3nl/SupportApp/tags" | grep "/root3nl/SupportApp/archive/refs/tags/" | grep -v "beta" | grep -Eo '[0-9]+[.0-9]*' | head -2 | tail -1 | sed 's/.$//' | sed 's/[^ -~]//g')
  armDownloadURL=""
  intelDownloadURL=""
  universalDownloadURL="https://github.com/root3nl/SupportApp/releases/download/v${latestVersion}/Support.${latestVersion}.pkg"
  appIcon="AppIcon"
  plistVersionString="CFBundleShortVersionString"
  officialTeamIdentifier="98LJ4XBGYK"
  volumeName=""
  pkgNameInVolume=""
  checksumAvailable="FALSE"
  armChecksum=$()
  intelChecksum=$()
  universalChecksum=$()
}

#------------------------------------------------------------------------------#

function Wireshark() {
  appName="Wireshark"
  appHomeDirectory="/Applications"
  installerType="dmg"
  latestVersion=$(curl -s https://www.wireshark.org/docs/relnotes/ | grep ".html" | grep -Eo "[0-9]+[.0-9]*" | head -4 | tail -1 | sed 's/[^ -~]//g')
  armDownloadURL="https://1.as.dl.wireshark.org/osx/Wireshark%20Latest%20Arm%2064.dmg"
  intelDownloadURL="https://1.as.dl.wireshark.org/osx/Wireshark%20Latest%20Intel%2064.dmg"
  universalDownloadURL=""
  appIcon="Wireshark"
  plistVersionString="CFBundleShortVersionString"
  officialTeamIdentifier="7Z6EMTD2C6"
  volumeName="Wireshark ${latestVersion}"
  pkgNameInVolume=""
  checksumAvailable="FALSE"
  armChecksum=$()
  intelChecksum=$()
  universalChecksum=$()
}

#------------------------------------------------------------------------------#

# DO NOT USE. STILL IN TESTING.
# Not working. Can't curl latest version. CHECK VERSION URL
function VMwareFusion() {
  appName="VMware Fusion"
  appHomeDirectory="/Applications"
  installerType="dmg"
  latestVersion=$(curl -sI https://slack.com/ssb/download-osx | grep "location" | grep -Eo "[0-9]+[.0-9]*" | tail -1 | sed 's/[^ -~]//g')
  downloadURL="https://www.vmware.com/go/getfusion"
  appIcon="electron"
  plistVersionString="CFBundleShortVersionString"
  officialTeamIdentifier="EG7KH642X6"
  volumeName="Slack"
  pkgNameInVolume=""
  checksumAvailable="FALSE"
  armChecksum=$()
  intelChecksum=$()
  universalChecksum=$()
}

################################################################################
#                               ...AND HERE.                                   #
################################################################################



################################################################################
#                START OF CUSTOMIZABLE JAMF HELPER PROMPTS                     #
################################################################################

# This is the Jamf Helper update prompt for the updatePrompt variable.
# The only thing that needs to be modified is the wording of the prompts if neccessary.
function updatePrompt() {
  jamfHelperUpdatePrompt=`"/Library/Application Support/JAMF/bin/jamfHelper.app/Contents/MacOS/jamfHelper" \
  -windowType utility \
  -icon "${appIconFullDirectory}" \
  -title "${appName} Update" \
  -heading "${appName} Update Available!" \
  -alignHeading natural \
  -description "If you wish to update now, save your work and then click Update. Updating now will quit ${appName}. You will be notified once the update is complete, and ${appName} will reopen. ${NL}${NL}Update version: ${latestVersion} ${NL}Installed version: ${installedVersion}" \
  -button1 "Update" \
  -button2 "Not Now" \
  -cancelButton "2"`
}

#------------------------------------------------------------------------------#

# This is the Jamf Helper forced update prompt for the forcedUpdatePrompt variable.
# The only thing that needs to be modified is the wording of the prompts if neccessary.
function forcedUpdatePrompt() {
  jamfHelperForcedUpdatePrompt=`"/Library/Application Support/JAMF/bin/jamfHelper.app/Contents/MacOS/jamfHelper" \
  -windowType utility \
  -icon "${appIconFullDirectory}" \
  -title "${appName} Update" \
  -heading "${appName} Update Notice" \
  -alignHeading natural \
  -description "Your IT administrator is requiring an update to the ${appName} app. Updating now will quit the app. It will reopen once the update is complete. ${NL}${NL}Update version: ${latestVersion} ${NL}Installed version: ${installedVersion}" \
  -button1 "Update"`
}

#------------------------------------------------------------------------------#

function updatingWindowPrompt() {
  jamfHelperUpdatingWindowPrompt=`"/Library/Application Support/JAMF/bin/jamfHelper.app/Contents/MacOS/jamfHelper" \
  -windowType hud \
  -icon "${appIconFullDirectory}" \
  -title "${appName} Update" \
  -description "${appName} is updating... ${NL}${NL}Please do not open ${appName} until the update is complete." \
  -lockHUD`
}

#------------------------------------------------------------------------------#

# This is the Jamf Helper update complete prompt for the updateCompletePrompt variable.
# The only thing that needs to be modified is the wording of the prompts if neccessary.
function updateCompletePrompt() {
  jamfHelperCompletePrompt=`"/Library/Application Support/JAMF/bin/jamfHelper.app/Contents/MacOS/jamfHelper" \
  -windowType utility \
  -icon "${appIconFullDirectory}" \
  -title "${appName} Update" \
  -description "${appName} updated successfully!" \
  -lockHUD \
  -button1 "OK"`
}

#------------------------------------------------------------------------------#

# This is the Jamf Helper error prompt for the errorPrompt variable.
# The only thing that needs to be modified is the wording of the prompts if neccessary.
function errorPrompt() {
  jamfHelperErrorPrompt=`"/Library/Application Support/JAMF/bin/jamfHelper.app/Contents/MacOS/jamfHelper" \
  -windowType utility \
  -icon "${jamfHelperErrorIcon}" \
  -title "${appName} Update" \
  -heading "${appName} Update Fail" \
  -alignHeading natural \
  -description "${appName} failed to update. Your IT administrator has been notified. The previous version of ${appName} has been restored." \
  -lockHUD \
  -button1 "OK"`
}

#------------------------------------------------------------------------------#

function quitAppPrompt() {
  jamfHelperQuitAppPrompt=`"/Library/Application Support/JAMF/bin/jamfHelper.app/Contents/MacOS/jamfHelper" \
  -windowType utility \
  -icon "${appIconFullDirectory}" \
  -title "${appName} Update" \
  -description "${appName} could not quit gracefully. Please save your work and manually quit ${appName}. ${NL}${NL}Once you have quit ${appName}, click Retry to retry the update, or Cancel to cancel the update." \
  -button1 "Retry" \
  -button2 "Cancel" \
  -cancelButton "2"`
}

#------------------------------------------------------------------------------#

# This is the Jamf Helper deferral prompt that notifies the user on the number of deferrals remianing.
# The only thing that needs to be modified is the wording of the prompts if neccessary.
function deferralPrompt() {
  jamfHelperErrorPrompt=`"/Library/Application Support/JAMF/bin/jamfHelper.app/Contents/MacOS/jamfHelper" \
  -windowType utility \
  -icon "${jamfHelperErrorIcon}" \
  -title "${appName} Update" \
  -heading "${appName} Update Deferral Notice" \
  -alignHeading natural \
  -description "Your system administrator set a ${deferralDays} day deferral limit to update ${appName}. Once the limit is reached, ${appName} will forcibly update. A 5 minute warning will appear before the update allowing you to save any work before ${appName} forcibly updates. ${NL}${NL}${appName} will forcibly update in ${deferralDaysRemaining} day(s)." \
  -lockHUD \
  -button1 "I Understand"`
}

#------------------------------------------------------------------------------#

# This is the Jamf Helper final deferral prompt that notifies the user they've reached the maximum amount of deferrals.
# The only thing that needs to be modified is the wording of the prompts if neccessary.
function finalDeferralPrompt() {
  jamfHelperErrorPrompt=`"/Library/Application Support/JAMF/bin/jamfHelper.app/Contents/MacOS/jamfHelper" \
  -windowType utility \
  -timeout 300 \
  -countdown \
  -alignCountdown center \
  -icon "${jamfHelperErrorIcon}" \
  -title "${appName} Update" \
  -heading "${appName} Update Deferral Notice" \
  -alignHeading natural \
  -alignDescription natural \
  -description "You have reached the ${deferralDays} day limit of deferring updates for ${appName}. ${appName} will automatically quit and update in 5 minutes. Please save your work. ${NL}${NL}Wait for the timer to run out or click Update Now to start the update." \
  -lockHUD \
  -button1 "Update Now" \
  -defaultButton 1`
}

################################################################################
#                  END OF CUSTOMIZABLE JAMF HELPER PROMPTS                     #
################################################################################



################################################################################
#                           START OF MAIN FUNCTIONS                            #
################################################################################

function jamfHelperVariables() {

  # Creates a new blank line for Jamf Helper.
  NL=$'\n'

  # The path to an error icon.
  # Default icon is: /System/Library/CoreServices/CoreTypes.bundle/Contents/Resources/AlertStopIcon.icns
  jamfHelperErrorIcon="/System/Library/CoreServices/CoreTypes.bundle/Contents/Resources/AlertStopIcon.icns"

  # Path to the app's icon file.
  appIconFullDirectory="${appHomeDirectory}/${appName}.app/Contents/Resources/${appIcon}.icns"

  # Proceed to the logProcess function...
  logProcess
}

#------------------------------------------------------------------------------#

# Checks if a log file exists. If not, one will be created.
function logProcess () {

  # Formats the app name to use underscores instead of spaces for logging purposes.
  # Example: Microsoft Visual Studio Code = Microsoft_Visual_Studio_Code
  appNameUnderscore=$(echo ${appName} | tr ' ' '_')

  # Defines the path for the log file.
  # _iu stands for install/update
  logFile="/Library/Logs/jamf_${appNameUnderscore}_iu.log"

  if [[ ! -e ${logFile} ]]; then
    touch ${logFile} && exec >> ${logFile}
    echo "`date` - ==================== Log File Created ===================="
    debugStart
  else
    exec >> ${logFile}
    echo ""
    echo "`date` - ==================== Log Entry Created ===================="
    debugStart
  fi

}

#------------------------------------------------------------------------------#

# Checks if debug mode is enabled.
function debugStart() {

  if [[ "${debugMode}" == "TRUE" ]]; then
    echo "`date` - * * * * * * * * * * DEBUG Mode Enabled * * * * * * * * * *"
    deviceInformation
  elif [[ "${debugMode}" == "FALSE" ]]; then
    deviceInformation
  else
    echo "`date` - Error at function: ${funcstack[1]}"
    echo "`date` - Error details: Illegal value in parameter 4 (DEBUG MODE)."
    echo "`date` - Abort mission..."
    exit 1
  fi

}

#------------------------------------------------------------------------------#

# Checks the device information.
function deviceInformation() {

  echo ""
  echo "`date` - Getting device information..."

  # Obtains the version number of macOS.
  macOSVersion=$(sw_vers -productVersion)

  #Obtains the build of macOS.
  macOSBuild=$(sw_vers -buildVersion)

  # Obtains the processor's achitecture type.
  processorArchitecture=$(uname -m)

  if [[ "${processorArchitecture}" == "x86_64" ]]; then
    processorType="Intel"
  elif [[ "${processorArchitecture}" == "arm64" ]]; then
    processorType="ARM"
  elif [[ "${processorArchitecture}" == "" ]]; then
    echo "`date` - Error at function: ${funcstack[1]}"
    echo "`date` - Error details: processorArchitecture variable could not be defined."
    exit 1
  else
    echo "`date` - Error at function: ${funcstack[1]}"
    echo "`date` - Error details: processorArchitecture variable is not recognized."
    echo "`date` - processorArchitecture: ${processorArchitecture}"
    exit 1
  fi

  # Obtains the amount of disk space available.
  diskSpaceAvailableMB=$(df -m | awk {'print $4'} | head -2 | tail -1)
  diskSpaceAvailableGB=$(df -h | awk {'print $4'} | head -2 | tail -1 | tr -d 'Gi')

  echo "`date` - macOS version: ${macOSVersion}"
  echo "`date` - macOS build: ${macOSBuild}"
  echo "`date` - Processor type: ${processorType}"
  echo "`date` - Available disk space: ${diskSpaceAvailableMB} MB | ${diskSpaceAvailableGB} GB"

  parameterCheck

}

#------------------------------------------------------------------------------#

# Checks and tests Jamf parameters.
function parameterCheck() {

  echo ""
  echo "`date` - Checking JAMF parameters..."
  echo "`date` - Parameter 01 - Base path: ${basePath}"
  echo "`date` - Parameter 02 - Computer name: ${computerName}"
  echo "`date` - Parameter 03 - User name: ${userName}"
  echo "`date` - Parameter 04 - Debug mode: ${debugMode}"
  echo "`date` - Parameter 05 - Application name: ${applicationName}"
  echo "`date` - Parameter 06 - Required disk space: ${requiredDiskSpace} MB"
  echo "`date` - Parameter 07 - Deferral days: ${deferralDays} days"
  echo "`date` - Parameter 08 - Prompts: ${prompts}"
  echo "`date` - Parameter 09 - Updating window: ${updatingWindow}"
  echo "`date` - Parameter 10 - Defined latest version: ${definedLatestVersion}"
  echo "`date` - Parameter 11 - Blank: ${notUsedParameter11}"

  echo ""
  echo "`date` - Testing JAMF parameters..."

  if [[ "${basePath}" != "" ]]; then
    :
  else
    echo "`date` - Parameter 01 - check: Fail"
    echo "`date` - Failure details: Parameter 01 (BASE PATH) cannot be defined."
    echo "`date` - Abort mission..."
    exit 1
  fi

  if [[ "${computerName}" != "" ]]; then
    :
  else
    echo "`date` - Parameter 02 - check: Fail"
    echo "`date` - Failure details: Parameter 02 (COMPUTER NAME) cannot be defined."
    echo "`date` - Abort mission..."
    exit 1
  fi

  if [[ "${userName}" != "" ]]; then
    :
  else
    echo "`date` - Parameter 03 - check: Fail"
    echo "`date` - Failure details: Parameter 03 (USER NAME) cannot be defined."
    echo "`date` - Abort mission..."
    exit 1
  fi

  if [[ "${debugMode}" == "TRUE" || "${debugMode}" == "FALSE" ]]; then
    :
  else
    echo "`date` - Parameter 04 - check: Fail"
    echo "`date` - Failure details: Illegal value in parameter 4 (DEBUG MODE)."
    echo "`date` - Abort mission..."
    exit 1
  fi

  if [[ "${applicationName}" != "" ]]; then
    :
  else
    echo "`date` - Parameter 05 - check: Fail"
    echo "`date` - Failure details: Illegal value in parameter 05 (APPLICATION NAME)."
    echo "`date` - Abort mission..."
    exit 1
  fi

  if [[ "${requiredDiskSpace}" == "NA" || "${requiredDiskSpace}" -ge "0" ]]; then
    :
  else
    echo "`date` - Parameter 06 - check: Fail"
    echo "`date` - Failure details: Illegal value in parameter 6 (REQUIRED DISK SPACE)."
    echo "`date` - Abort mission..."
    exit 1
  fi

  if [[ "${deferralDays}" == "NA" || "${deferralDays}" == "0" || "${deferralDays}" -ge "1" ]]; then
    :
  else
    echo "`date` - Parameter 07 - check: Fail"
    echo "`date` - Failure details: Illegal value in parameter 07 (DEFERRAL DAYS)."
    echo "`date` - Abort mission..."
    exit 1
  fi

  if [[ "${prompts}" == "TRUE" || "${prompts}" == "FALSE" ]]; then
    :
  else
    echo "`date` - Parameter 08 - check: Fail"
    echo "`date` - Failure details: Illegal value in parameter 08 (UPDATE PROMPT)."
    echo "`date` - Abort mission..."
    exit 1
  fi

  if [[ "${updatingWindow}" == "TRUE" || "${updatingWindow}" == "FALSE" ]]; then
    :
  else
    echo "`date` - Parameter 09 - check: Fail"
    echo "`date` - Failure details: Illegal value in parameter 09 (UPDATING WINDOW). Value must be TRUE or FALSE."
    echo "`date` - Abort mission..."
    exit 1
  fi

  if [[ "${definedLatestVersion}" == "" ]]; then
    echo "`date` - Parameter 10 - check: Fail"
    echo "`date` - Failure details: Illegal value in parameter 10 (LATEST VERSION). Value must be NA or a version number."
    echo "`date` - Abort mission..."
    exit 1
  elif [[ "${definedLatestVersion}" == "NA" ]]; then
    :
  else
    :
  fi

  if [[ "${notUsedParameter11}" != "" ]]; then
    echo "`date` - Parameter 11 - check: Fail"
    echo "`date` - Parameter 11 is in use, but not defined in the script."
    echo "`date` - Abort mission..."
    exit 1
  else
    :
  fi

  echo "`date` - Did all parameters pass: Yes"
  appInstalledCheck

}

#------------------------------------------------------------------------------#

# Checks if the app is installed.
function appInstalledCheck() {

  echo ""
  echo "`date` - Checking ${appName} on computer..."

  # Defines the full path of the application.
  appFullHomeDirectory="${appHomeDirectory}/${appName}.app"

  # Defines the full path of the plist directory.
  plistDirectory="${appFullHomeDirectory}/Contents/Info.plist"

  if [[ -a "${appFullHomeDirectory}" ]]; then

    echo "`date` - Is ${appName} installed: Yes"

    appInstalled="TRUE"

    installedVersionVariables
    latestVersionVariables
    compareVersions

  else

    echo "`date` - Is ${appName} installed: No"

    appInstalled="FALSE"

    latestVersionVariables
    installerVariables
  fi

}

#------------------------------------------------------------------------------#

function installedVersionVariables() {

  # Reads the version number from the installed app's Info.plist file.
  installedVersion=$(defaults read ${plistDirectory} ${plistVersionString})

}

#------------------------------------------------------------------------------#

# Defines the variables that gather the installed and latest versions available.
function latestVersionVariables() {

  if [[ "${definedLatestVersion}" == "NA" && "${latestVersion}" == "" ]]; then
    echo "`date` - Error at function: ${funcstack[1]}"
    echo "`date` - Error details: latestVersion variable could not be defined."
    echo "`date` - Abort mission..."
    exit 1

  elif [[ "${definedLatestVersion}" != "NA" && "${latestVersion}" != "" ]]; then
    echo "`date` - Error at function: ${funcstack[1]}"
    Parameter 10 - Defined latest version
    echo "`date` - Error details: Parameter 10 (LATEST VERSION) and latestVersion variable are both defined. Only one can be defined."
    echo "`date` - Abort mission..."
    exit 1

  elif [[ "${definedLatestVersion}" == "NA" && "${latestVersion}" != "" ]]; then
    compareVersions

  elif [[ "${definedLatestVersion}" != "NA" && "${latestVersion}" == "" ]]; then
    latestVersion="${definedLatestVersion}"
    compareVersions

  else
    echo "`date` - Error at function: ${funcstack[1]}"
    echo "`date` - Error details: Check the function, variables, and paramters within the function."
    echo "`date` - Abort mission..."
    exit 1
  fi
}

#------------------------------------------------------------------------------#

function compareVersions() {

  echo "`date` - Installed version: ${installedVersion}"
  echo "`date` - Latest version: ${latestVersion}"

  sortVersions=$(printf '%s\n' "${latestVersion}" "${installedVersion}" | sort -V 2>&1)
  getLowestValue=$(echo "${sortVersions}" | head -1)
  getHighestValue=$(echo "${sortVersions}" | tail -1)

  if [[ "${installedVersion}" == "" ]]; then
    echo "`date` - Error at function: ${funcstack[1]}"
    echo "`date` - Error details: installedVersion variable is blank."
    echo "`date` - Abort mission..."
    exit 1
  elif [[ "${latestVersion}" == "" ]]; then
    echo "`date` - Error at function: ${funcstack[1]}"
    echo "`date` - Error details: latestVersion variable is blank."
    echo "`date` - Abort mission..."
    exit 1
  else
    if [[ "${installedVersion}" == "${getHighestValue}" ]]; then
      echo "`date` - Is the latest version of ${appName} installed: Yes"
      echo "`date` - Abort mission..."
      cleanUp
      exit 0
    elif [[ "${installedVersion}" == "${getLowestValue}" ]]; then
      echo "`date` - Is the latest version of ${appName} installed: No"
      appProcessVariables
    else
      echo "`date` - Error at function: ${funcstack[1]}"
      echo "`date` - Error details: installedVersion variable is not equal to either the getHighestValue or getLowestValue variable."
      echo "`date` - Abort mission..."
      exit 1
    fi
  fi
}

#------------------------------------------------------------------------------#

# Defines the variables to get the app's executable name.
function appProcessVariables() {

  # Pulls the executable name from the app's plist.
  appProcessName=$(defaults read "${plistDirectory}" CFBundleExecutable)

  # Pulls the process ID(s) if the app is running.
  appPID=$(pgrep "${appProcessName}")

  if [[ "${appProcessName}" == "" ]]; then
    echo "`date` - Error at function: ${funcstack[1]}"
    echo "`date` - Error details: appProcessName variable is blank."
    echo "`date` - Abort mission..."
    exit 1
  else
    checkAppState
  fi

}


#------------------------------------------------------------------------------#

# Checks if the app is running or not.
function checkAppState() {

  if [[ "${appPID}" == "" ]]; then
    echo "`date` - Is ${appName} running: No"
    appState="OFF"
    installerVariables
  else
    echo "`date` - Is ${appName} running: Yes"
    appState="ON"
    checkPromptSettings
  fi

}

#------------------------------------------------------------------------------#

# Notifies the user of the app udpate via Jamf Helper (if enabled).
function checkPromptSettings() {
  if [[ "${prompts}" == "TRUE" ]]; then
    echo "`date` - Prompt user to update: Yes"
    echo "`date` - Prompt type: updatePrompt"
    updatePrompt

    if [[ "${jamfHelperUpdatePrompt}" == "0" ]]; then
      echo "`date` - Did user choose to update: Yes"
      quitAppPreCheck
    elif [[ "${jamfHelperUpdatePrompt}" == "2" ]]; then
      echo "`date` - Did user choose to update: No"
      deferralVariables
    else
      echo "`date` - Did user choose to update: No"
      echo "`date` - No option was selected or the script was interrupted."
      echo "`date` - Abort mission..."
      exit 1
    fi

  elif [[ "${prompts}" == "FALSE" ]]; then
    quitAppPreCheck
  fi
}

#------------------------------------------------------------------------------#

function deferralVariables() {
  # The location of the deferral log file that's created with this script.
  # _d stands for deferral.
  jamfHelperDeferralLog="/Library/Logs/jamf_${appNameUnderscore}_d.log"

  # Prints today's date in the format of: YYYYMMDD
  todaysDate=$(date -j -f "%a %b %d %T %Z %Y" "`date`" "+%Y%m%d")

  # Prints epoch version of today's date.
  todaysDateEpoch=$(date -j -f "%a %b %d %T %Z %Y" "`date`" "+%s")

  # Prints the date for the deferralDays variable in the format of: YYYYMMDD
  deferralDeadlineDate=$(date -j -f "%a %b %d %T %Z %Y" "`date -v+${deferralDays}d`" "+%Y%m%d")

  # Prints epoch date of the deferralDays variable date.
  deferralDeadlineDateEpoch=$(date -j -f "%a %b %d %T %Z %Y" "`date -v+${deferralDays}d`" "+%s")

  checkDeferralDate
}

#------------------------------------------------------------------------------#

function checkDeferralDate() {

  echo ""
  echo "`date` - Checking deferral settings..."

  if [[ "${deferralDays}" == "NA" ]]; then
    echo "`date` - Is a deferral limit set: No"
    echo "`date` - Abort mission..."
    debugEnd
    exit 1

  else
    echo "`date` - Is a deferral limit set: Yes"
    if [[ -f ${jamfHelperDeferralLog} ]]; then
      echo "`date` - Does deferral log exist: Yes"
      deferralDeadline=$(cat ${jamfHelperDeferralLog} | head -1)
      deferralCreated=$(cat ${jamfHelperDeferralLog} | tail -1)
      originalDeferralDays=$(( ( ${deferralDeadline} - ${deferralCreated} )/(86400) ))
      echo "`date` - deferralDays variable was set to: ${originalDeferralDays}"

      if [[ "${originalDeferralDays}" != "${deferralDays}" ]]; then
        echo "`date` - Does deferralDays variable match from the last run: No"
        newDeferralDeadlineDateEpoch=$(date -j -f "%a %b %d %T %Z %Y" "`date -v+${deferralDays}d`" "+%s")
        echo "`date` - Removing old log..."
        rm -rf ${jamfHelperDeferralLog}
        echo "`date` - Creating new log..."
        touch ${jamfHelperDeferralLog}
        echo "`date` - Updating log with new deferral date..."
        echo ${newDeferralDeadlineDateEpoch} > ${jamfHelperDeferralLog}
        echo ${todaysDateEpoch} >> ${jamfHelperDeferralLog}
        deferralDeadline=$(cat ${jamfHelperDeferralLog} | head -1)
        deferralCreated=$(cat ${jamfHelperDeferralLog} | tail -1)
        deferralDaysRemaining=$(( ( ${deferralDeadline} - ${todaysDateEpoch} )/(86400) ))
        echo "`date` - Number of days remaining to defer update: ${deferralDaysRemaining}"
        checkDeferral

      else
        deferralDeadline=$(cat ${jamfHelperDeferralLog} | head -1)
        deferralCreated=$(cat ${jamfHelperDeferralLog} | tail -1)
        deferralDaysRemaining=$(( ( ${deferralDeadline} - ${todaysDateEpoch} )/(86400) ))
        echo "`date` - Does deferralDays variable match from the last run: Yes"
        echo "`date` - Number of days remaining to defer update: ${deferralDaysRemaining}"
        checkDeferral
      fi

    else
      echo "`date` - Does deferral log exist: No"
      echo "`date` - Creating deferral log..."
      touch ${jamfHelperDeferralLog} # Creates deferral log at location specified in jamfHelperDeferralLog variable
      echo ${deferralDeadlineDateEpoch} > ${jamfHelperDeferralLog}
      echo ${todaysDateEpoch} >> ${jamfHelperDeferralLog}
      deferralDeadline=$(cat ${jamfHelperDeferralLog} | head -1)
      deferralCreated=$(cat ${jamfHelperDeferralLog} | tail -1)
      deferralDaysRemaining=$(( ( ${deferralDeadline} - ${todaysDateEpoch} )/(86400) ))
      echo "`date` - Number of days remaining to defer update: ${deferralDaysRemaining}"
      echo "`date` - Prompt user regarding deferral limit: Yes"
      echo "`date` - Prompt type: deferralPrompt"
      echo "`date` - Abort mission..."
      deferralPrompt
      debugEnd
      exit 1
    fi
  fi
}

#------------------------------------------------------------------------------#

function checkDeferral() {
  if [[ "${deferralDaysRemaining}" -le "0" ]]; then
    echo "`date` - Has deferral limit been reached: Yes"
    echo "`date` - Prompt user deferral limit reached: Yes"
    echo "`date` - Prompt type: finalDeferralPrompt"

    finalDeferralPrompt
    quitAppPreCheck

  else
    echo "`date` - Has deferral limit been reached: No"
    deferralDeadline=$(cat ${jamfHelperDeferralLog} | head -1)
    deferralCreated=$(cat ${jamfHelperDeferralLog} | tail -1)
    deferralDaysRemaining=$(( ( ${deferralDeadline} - ${todaysDateEpoch} )/(86400) ))
    echo "`date` - Prompt user regarding deferral limit: Yes"
    echo "`date` - Prompt type: deferralPrompt"
    echo "`date` - Abort mission..."
    deferralPrompt
    debugEnd
    exit 1
  fi
}

#------------------------------------------------------------------------------#

function quitAppPreCheck() {
  echo ""
  echo "`date` - Attempting to quit ${appName}..."

  if [[ "${appState}" == "ON" && "${appName}" == "Docker" ]]; then
    quitAppDocker
  else
    quitApp
  fi
}

#------------------------------------------------------------------------------#

# This needs to run first so the script doesn't attempt to quit Docker first.
# If there is an attempt to quit Docker first, it will fail.
# The user will then be prompted to quit Docker, but won't be able to because the app will be frozen.
function quitAppDocker() {
  echo "`date` - ${appName} must be quit manually by the user."
  echo "`date` - Prompting user to manually quit ${appName}..."
  echo "`date` - Prompt type: quitAppPrompt"
  quitAppPrompt

  if [[ "${jamfHelperQuitAppPrompt}" == "0" ]]; then
    sleep 5
    confirmAppQuit=$(pgrep "${appProcessName}")

    if [[ "${confirmAppQuit}" == "" ]]; then
      echo "`date` - Did ${appName} quit successfully: Yes"
      displayUpdatingWindow
    else
      echo "`date` - Did ${appName} quit successfully: No"
      echo "`date` - Prompting user to quit ${appName} again..."
      quitAppDocker
    fi

  elif [[ "${jamfHelperQuitAppPrompt}" == "2" ]]; then
    echo "`date` - Error at function: ${funcstack[1]}"
    echo "`date` - Error details: User chose to cancel the update."
    echo "`date` - Abort mission..."
    debugEnd
    exit 1
  fi
}

#------------------------------------------------------------------------------#

# Force quit the app if it's running.
function quitApp() {
  if [[ "${appState}" == "ON" ]]; then
    killall "${appProcessName}"
    sleep 1
    confirmAppQuit=$(pgrep "${appProcessName}")

    if [[ "${confirmAppQuit}" == "" ]]; then
      echo "`date` - Did ${appName} quit successfully: Yes"
      displayUpdatingWindow
    else
      echo "`date` - Did ${appName} quit successfully: No"
      echo "`date` - Prompting user to manually quit ${appName}..."
      echo "`date` - Prompt type: quitAppPrompt"
      quitAppPrompt

      if [[ "${jamfHelperQuitAppPrompt}" == "0" ]]; then
        quitApp
      elif [[ "${jamfHelperQuitAppPrompt}" == "2" ]]; then
        echo "`date` - Error at function: ${funcstack[1]}"
        echo "`date` - Error details: User chose to cancel the update."
        echo "`date` - Abort mission..."
        debugEnd
        exit 1
      fi
    fi
  else
    installerVariables
  fi
}

#------------------------------------------------------------------------------#

function displayUpdatingWindow() {
  if [[ "${updatingWindow}" == "TRUE" ]]; then
    updatingWindowPrompt &
    installerVariables
  elif [[ "${updatingWindow}" == "FALSE" ]]; then
    installerVariables
  else
    echo "`date` - Error at function: ${funcstack[1]}"
    echo "`date` - Error details: updatingWindow variable cannot be determined."
    echo "`date` - Abort mission..."
    debugEnd
    exit 1
  fi
}

#------------------------------------------------------------------------------#

function installerVariables() {
  # The path where the installer is downloaded. Installer is also renamed.
  installerFullDirectory="/private/tmp/${appNameUnderscore}.${installerType}"

  # A temp directory to relocate the original app while the new one is being installed.
  appTempDirectory="/usr/local"

  # The temp path for the original app that's been relocated.
  appFullTempDirectory="${appTempDirectory}/${appName}.app"

  # volumeAppFullDirectory contains the path of the app within a volume.
  volumeAppFullDirectory="/Volumes/${volumeName}/${appName}.app"

  # The pkg name within a dmg volume.
  if [[ "${pkgSubfoldersInVolume}" == "" ]]; then
    pkgInVolumeDirectory="/Volumes/${volumeName}/${pkgNameInVolume}.pkg"
  else
    pkgInVolumeDirectory="/Volumes/${volumeName}/${pkgSubfoldersInVolume}/${pkgNameInVolume}.pkg"
  fi

  # The path where the pkg will be downloaeded/moved to.
  pkgNewDirectory="/private/tmp"

  # The entire path where the pkg will be downloaeded/moved to.
  pkgNewFullDirectory="${pkgNewDirectory}/${pkgNameInVolume}.pkg"

  cleanUpPreInstallCheck
}

#------------------------------------------------------------------------------#

function cleanUpPreInstallCheck() {
  echo ""
  echo "`date` - Downloading ${appName} installer..."
  cleanUpPreInstall
  determineInstallerDownload
}

#------------------------------------------------------------------------------#

# Downloads the latest version available of the app
function determineInstallerDownload() {
  echo "`date` - Determining which download URL to use..."

  if [[ "${processorType}" == "ARM" ]]; then
    echo "`date` - Processor type: ARM"

    if [[ "${armDownloadURL}" != "" ]]; then
      echo "`date` - Downloading ARM-specific installer..."
      installerDownloadType="arm"
      armDownload
    elif [[ "${universalDownloadURL}" != "" ]]; then
      echo "`date` - An ARM-specific installer is not specified in the script."
      echo "`date` - Downloading a universal installer..."
      installerDownloadType="universal"
      universalDownload
    elif [[ "${intelDownloadURL}" != "" ]]; then
      echo "`date` - An ARM-specific installer is not specified in the script."
      echo "`date` - Downloading an Intel installer..."
      installerDownloadType="intel"
      intelDownload
    else
      echo "`date` - Error at function: ${funcstack[1]} (ARM)"
      echo "`date` - Error details: The armDownloadURL, universalDownloadURL, and intelDownloadURL variables are blank."
    fi

  elif [[ "${processorType}" == "Intel" ]]; then
    echo "`date` - Processor type: Intel"

    if [[ "${intelDownloadURL}" != "" ]]; then
      echo "`date` - Downloading Intel-specific installer..."
      installerDownloadType="intel"
      intelDownload
    elif [[ "${universalDownloadURL}" != "" ]]; then
      echo "`date` - An Intel-specific installer is not specified in the script."
      echo "`date` - Downloading a universal installer..."
      installerDownloadType="universal"
      universalDownload
    else
      echo "`date` - Error at function: ${funcstack[1]} (Intel)"
      echo "`date` - Error details: The intelDownloadURL and universalDownloadURL variables are blank."
    fi

  else
    echo "`date` - Did the installer download successfully: No"
    echo "`date` - Error at function: ${funcstack[1]}"
    echo "`date` - Error details: The processorType, universalDownloadURL, intelDownloadURL, or armDownloadURL variables could not be determined."
    echo "`date` - processorType: ${processorType}"
    echo "`date` - universalDownloadURL: ${universalDownloadURL}"
    echo "`date` - armDownloadURL: ${armDownloadURL}"
    echo "`date` - intelDownloadURL: ${intelDownloadURL}"
    echo "`date` - Abort mission..."
    debugEnd
    exit 1
  fi
}

#------------------------------------------------------------------------------#

function armDownload() {
  downloadAttemptCounter=0

  until [[ -a "${installerFullDirectory}" ]]; do
    ((downloadAttemptCounter++))
    curl "${armDownloadURL}" -s -L -o "${installerFullDirectory}"
    sleep 1

    if [[ ! -a "${installerFullDirectory}" && "${downloadAttemptCounter}" -eq "1" ]]; then
      echo "`date` - First attempt to download installer failed."
    elif [[ ! -a "${appFullHomeDirectory}" && "${downloadAttemptCounter}" -eq "2" ]]; then
      echo "`date` - Second attempt to download installer failed."
    elif [[ ! -a "${appFullHomeDirectory}" && "${downloadAttemptCounter}" -ge "3" ]]; then
      echo "`date` - Third attempt to download installer failed."
      break
    else
      break
    fi
    sleep 1
  done

  if [[ -a "${installerFullDirectory}" ]]; then
    echo "`date` - Did the installer download successfully: Yes"
    checksumCheck
  else
    echo "`date` - Did the installer downloaded successfully: No"
    echo "`date` - Error at function: ${funcstack[1]}"
    echo "`date` - Error details: The latest installer was not able to be downloaded."
    echo "`date` - Abort mission..."
    debugEnd
    exit 1
  fi
}

#------------------------------------------------------------------------------#

function intelDownload() {
  downloadAttemptCounter=0

  until [[ -a "${installerFullDirectory}" ]]; do
    ((downloadAttemptCounter++))
    curl "${intelDownloadURL}" -s -L -o "${installerFullDirectory}"
    sleep 1

    if [[ ! -a "${installerFullDirectory}" && "${downloadAttemptCounter}" -eq "1" ]]; then
      echo "`date` - First attempt to download installer failed."
    elif [[ ! -a "${appFullHomeDirectory}" && "${downloadAttemptCounter}" -eq "2" ]]; then
      echo "`date` - Second attempt to download installer failed."
    elif [[ ! -a "${appFullHomeDirectory}" && "${downloadAttemptCounter}" -ge "3" ]]; then
      echo "`date` - Third attempt to download installer failed."
      break
    else
      break
    fi
    sleep 1
  done

  if [[ -a "${installerFullDirectory}" ]]; then
    echo "`date` - Did the installer download successfully: Yes"
    checksumCheck
  else
    echo "`date` - Did the installer downloaded successfully: No"
    echo "`date` - Error at function: ${funcstack[1]}"
    echo "`date` - Error details: The latest installer was not able to be downloaded."
    echo "`date` - Abort mission..."
    debugEnd
    exit 1
  fi
}

#------------------------------------------------------------------------------#

function universalDownload() {
  downloadAttemptCounter=0

  until [[ -a "${installerFullDirectory}" ]]; do
    ((downloadAttemptCounter++))
    curl "${universalDownloadURL}" -s -L -o "${installerFullDirectory}"
    sleep 1

    if [[ ! -a "${installerFullDirectory}" && "${downloadAttemptCounter}" -eq "1" ]]; then
      echo "`date` - First attempt to download installer failed."
    elif [[ ! -a "${appFullHomeDirectory}" && "${downloadAttemptCounter}" -eq "2" ]]; then
      echo "`date` - Second attempt to download installer failed."
    elif [[ ! -a "${appFullHomeDirectory}" && "${downloadAttemptCounter}" -ge "3" ]]; then
      echo "`date` - Third attempt to download installer failed."
      break
    else
      break
    fi
    sleep 1
  done

  if [[ -a "${installerFullDirectory}" ]]; then
    echo "`date` - Did the installer download successfully: Yes"
    checksumCheck
  else
    echo "`date` - Did the installer downloaded successfully: No"
    echo "`date` - Error at function: ${funcstack[1]}"
    echo "`date` - Error details: The latest installer was not able to be downloaded."
    echo "`date` - Abort mission..."
    debugEnd
    exit 1
  fi
}

#------------------------------------------------------------------------------#

function checksumCheck() {
  echo ""
  echo "`date` - Checking installer checksums..."
  if [[ "${checksumAvailable}" == "TRUE" ]]; then
    echo "`date` - Are checksums enforced: Yes"
    checksumVariables
  elif [[ "${checksumAvailable}" == "FALSE" ]]; then
    echo "`date` - Are checksums enforced: No"
    echo "`date` - Skipping checksum verification..."

    if [[ "${debugMode}" == "TRUE" ]]; then
      debugEnd
      exit 0
    else
      relocateApp
    fi

  else
    echo "`date` - Error at function: ${funcstack[1]}"
    echo "`date` - Error details: checksumAvailable variable must either be TRUE or FALSE."
    echo "`date` - Abort mission..."
    exit 1
  fi
}


#------------------------------------------------------------------------------#

function checksumVariables() {

  # The path of the installer's checksum output.
  installerChecksumFullDirectory="/private/tmp/${appNameUnderscore}-Installer-Checksum.txt"

  # The path the installer checksum is downlaoded to. It's also renamed.
  # Do not modify this variable. It must remain here.
  checksumFullDirectory="/private/tmp/${appNameUnderscore}-Site-Checksum.txt"

  installerChecksum
}

#------------------------------------------------------------------------------#

# Obtains the SHA-256 checksum of the downloaded installer.
function installerChecksum() {

  if [[ "${#armChecksum}" == "64" || "${#intelChecksum}" == "64" || "${#universalChecksum}" == "64" ]]; then
    siteChecksum="SHA256"
    shasum -a 256 ${installerFullDirectory} > ${installerChecksumFullDirectory}
    installerChecksum=$(cat ${installerChecksumFullDirectory} | awk '{print $1}')
    echo "`date` - Checksum type: SHA-256"
    echo "`date` - SHA-256 of installer: ${installerChecksum}"
    latestChecksum
  elif [[ "${#armChecksum}" == "128" || "${#intelChecksum}" == "128" || "${#universalChecksum}" == "128" ]]; then
    echo "`date` - Checksum type: SHA-512"
    siteChecksum="SHA512"
    shasum -a 512 ${installerFullDirectory} > ${installerChecksumFullDirectory}
    installerChecksum=$(cat ${installerChecksumFullDirectory} | awk '{print $1}')
    echo "`date` - SHA-512 of installer: ${installerChecksum}"
    latestChecksum
  else
    echo "`date` - Error at function: ${funcstack[1]}"
    echo "`date` - Error details: Character count of checksums could not be determined."
    echo "`date` - Abort mission..."
    exit 1
  fi
}

#------------------------------------------------------------------------------#

# Downloads the latest version of the app's checksum file, and pulls the SHA256 checksum.
function latestChecksum() {
  if [[ "${installerDownloadType}" == "arm" ]]; then
    echo ${armChecksum} > ${checksumFullDirectory}
    actualChecksum=$(cat ${checksumFullDirectory} | awk '{print $1}')
    if [[ "${siteChecksum}" == "SHA256" ]]; then
      echo "`date` - SHA-256 via app site: ${actualChecksum}"
      verifyChecksums
    elif [[ "${siteChecksum}" == "SHA512" ]]; then
      echo "`date` - SHA-512 via app site: ${actualChecksum}"
      verifyChecksums
    else
      echo "`date` - Error at function: ${funcstack[1]}"
      echo "`date` - Error details: siteChecksum variable could not be determined."
      abortMission
    fi

  elif [[ "${installerDownloadType}" == "intel" ]]; then
    echo ${intelChecksum} > ${checksumFullDirectory}
    actualChecksum=$(cat ${checksumFullDirectory} | awk '{print $1}')
    if [[ "${siteChecksum}" == "SHA256" ]]; then
      echo "`date` - SHA-256 via app site: ${actualChecksum}"
      verifyChecksums
    elif [[ "${siteChecksum}" == "SHA512" ]]; then
      echo "`date` - SHA-512 via app site: ${actualChecksum}"
      verifyChecksums
    else
      echo "`date` - Error at function: ${funcstack[1]}"
      echo "`date` - Error details: siteChecksum variable could not be determined."
      abortMission
    fi

  elif [[ "${installerDownloadType}" == "universal" ]]; then
    echo ${universalChecksum} > ${checksumFullDirectory}
    actualChecksum=$(cat ${checksumFullDirectory} | awk '{print $1}')
    if [[ "${siteChecksum}" == "SHA256" ]]; then
      echo "`date` - SHA-256 via app site: ${actualChecksum}"
      verifyChecksums
    elif [[ "${siteChecksum}" == "SHA512" ]]; then
      echo "`date` - SHA-512 via app site: ${actualChecksum}"
      verifyChecksums
    else
      echo "`date` - Error at function: ${funcstack[1]}"
      echo "`date` - Error details: siteChecksum variable could not be determined."
      abortMission
    fi

  else
    echo "`date` - Error at function: ${funcstack[1]}"
    echo "`date` - Error details: installerDownloadType variable could not be defined."
    abortMission
  fi
}

#------------------------------------------------------------------------------#

# Compare checksums (if applicable).
function verifyChecksums() {
  echo "`date` - Comparing checksums..."

  if [[ "${actualChecksum}" == "${installerChecksum}" ]]; then
    echo "`date` - Do checksums match: Yes"
    echo "`date` - Safe to proceed with installation..."

    if [[ "${debugMode}" == "TRUE" ]]; then
      debugEnd
      exit 0
    else
      relocateApp
    fi

  else
    echo "`date` - Do checksums match: No"
    echo "`date` - NOT SAFE TO INSTALL."
    echo "`date` - Installer did not pass checksum verification."
    echo "`date` - Abort mission..."
    debugEnd
    exit 1
  fi
}

#------------------------------------------------------------------------------#

# The existing app is temporarily moved to the /usr/local directory.
# If the update fails, the existing app will be recovered from the /usr/local directory.
function relocateApp() {
  echo ""
  echo "`date` - Preparing to install ${appName}..."

  if [[ "${appInstalled}" == "TRUE" ]]; then
    echo "`date` - Relocating existing version of ${appName} to: /usr/local"

    until [[ ! -a "${appFullHomeDirectory}" ]]; do
      mv "${appFullHomeDirectory}" "${appTempDirectory}"
    done

    if [[ -a "${appFullHomeDirectory}" ]]; then
      echo "`date` - Was ${appName} relocated: No"
      abortMission
    else
      echo "`date` - Was ${appName} relocated: Yes"
      determineInstaller
    fi

  elif [[ "${appInstalled}" == "FALSE" ]]; then
    determineInstaller

  else
    echo "`date` - Error at function: ${funcstack[1]}"
    echo "`date` - Error details: Cannot determine if app is installed or not."
    echo "`date` - Abort mission..."
    exit 1
  fi
}

#------------------------------------------------------------------------------#

function determineInstaller() {
  echo "`date` - Determining installer type..."
  if [[ "${installerType}" == "dmg" ]]; then
    echo "`date` - Installer type: dmg"
    installLatestFromDmg
  elif [[ "${installerType}" == "pkg" ]]; then
    echo "`date` - Installer type: pkg"
    installLatestFromPkg
  elif [[ "${installerType}" == "zip" ]]; then
    echo "`date` - Installer type: zip"
    installLatestFromZip
  elif [[ "${installerType}" == "Figma.zip" ]]; then
    echo "`date` - Installer type: Figma.zip"
    installLatestFromFigmaZip
  elif [[ "${installerType}" == "app.tar.bz2" ]]; then
    echo "`date` - Installer type: app.tar.bz2"
    installLatestFromAppTarBz2
  elif [[ "${installerType}" == "app" ]]; then
    echo "`date` - Installer type: app"
    installLatestFromApp
  elif [[ "${installerType}" == "pkg.dmg" ]]; then
    echo "`date` - Installer type: pkg.dmg"
    installLatestFromPkgDmg
  else
    echo "`date` - Error at function: ${funcstack[1]}"
    echo "`date` - Error details: installerType variable could not be determined."
    abortMission
  fi
}

#------------------------------------------------------------------------------#

function installLatestFromDmg() {
  echo "`date` - Installing from dmg installer..."
  installAttemptCounter=0

  until [[ -a "${appFullHomeDirectory}" ]]; do
    ((installAttemptCounter++))
    echo "`date` - Attaching dmg and opening volume..."
    hdiutil attach ${installerFullDirectory} -nobrowse -quiet
    echo "`date` - Copying ${appName} from ${volumeAppFullDirectory} to ${appFullHomeDirectory}..."
    ditto -rsrc "${volumeAppFullDirectory}" "${appFullHomeDirectory}"
    sleep 1
    if [[ ! -a "${appFullHomeDirectory}" && "${installAttemptCounter}" == "1" ]]; then
      echo "`date` - First attempt to install app failed."
    elif [[ ! -a "${appFullHomeDirectory}" && "${installAttemptCounter}" == "2" ]]; then
      echo "`date` - Second attempt to install app failed."
    elif [[ ! -a "${appFullHomeDirectory}" && "${installAttemptCounter}" == "3" ]]; then
      echo "`date` - Third attempt to install app failed."
      break
    else
      break
    fi
    sleep 1
  done

  if [[ -a "${appFullHomeDirectory}" ]]; then
    echo "`date` - ${appName}.app was successfully copied to ${appHomeDirectory}."
    checkLatestInstall
  elif [[ ! -a "${appFullHomeDirectory}" ]]; then
    echo "`date` - ${appName}.app failed to copy to ${appHomeDirectory}..."
    abortMission
  else
    echo "`date` - Error at function: ${funcstack[1]}"
    echo "`date` - Error details: Could not determine if ${appName} exists at ${appHomeDirectory}."
    exit 1
  fi
}

#------------------------------------------------------------------------------#

function installLatestFromPkg() {
  echo "`date` - Installing from pkg installer..."
  installAttemptCounter=0

  until [[ -a "${appFullHomeDirectory}" ]]; do
    ((installAttemptCounter++))
    echo "`date` - Opening and running pkg..."
    installer -pkg ${installerFullDirectory} -target /
    sleep 1
    if [[ ! -a "${appFullHomeDirectory}" && "${installAttemptCounter}" == "1" ]]; then
      echo "`date` - First attempt to install app failed."
    elif [[ ! -a "${appFullHomeDirectory}" && "${installAttemptCounter}" == "2" ]]; then
      echo "`date` - Second attempt to install app failed."
    elif [[ ! -a "${appFullHomeDirectory}" && "${installAttemptCounter}" == "3" ]]; then
      echo "`date` - Third attempt to install app failed."
      break
    else
      break
    fi
    sleep 1
  done

  if [[ -a "${appFullHomeDirectory}" ]]; then
    echo "`date` - ${appName}.app was successfully installed to ${appHomeDirectory}."
    checkLatestInstall
  elif [[ ! -a "${appFullHomeDirectory}" ]]; then
    echo "`date` - ${appName}.app failed to install to ${appHomeDirectory}..."
    abortMission
  else
    echo "`date` - Error at function: ${funcstack[1]}"
    echo "`date` - Error details: Could not determine if ${appName} exists at ${appHomeDirectory}."
    exit 1
  fi
}

#------------------------------------------------------------------------------#

function installLatestFromZip() {
  echo "`date` - Installing from zip file..."
  installAttemptCounter=0

  until [[ -a "${appFullHomeDirectory}" ]]; do
    ((installAttemptCounter++))
    echo "`date` - Changing directory to /private/tmp..."
    cd /private/tmp
    echo "`date` - Unzipping ${installerFullDirectory}..."
    unzip -qq "${installerFullDirectory}"
    echo "`date` - Moving ${appName}.app to ${appHomeDirectory}..."
    mv "${appName}.app" "${appHomeDirectory}"
    sleep 1
    if [[ ! -a "${appFullHomeDirectory}" && "${installAttemptCounter}" == "1" ]]; then
      echo "`date` - First attempt to install app failed."
    elif [[ ! -a "${appFullHomeDirectory}" && "${installAttemptCounter}" == "2" ]]; then
      echo "`date` - Second attempt to install app failed."
    elif [[ ! -a "${appFullHomeDirectory}" && "${installAttemptCounter}" == "3" ]]; then
      echo "`date` - Third attempt to install app failed."
      break
    else
      break
    fi
    sleep 1
  done

  if [[ -a "${appFullHomeDirectory}" ]]; then
    echo "`date` - ${appName}.app was successfully moved to ${appHomeDirectory}."
    checkLatestInstall
  elif [[ ! -a "${appFullHomeDirectory}" ]]; then
    echo "`date` - ${appName}.app failed to move to ${appHomeDirectory}..."
    abortMission
  else
    echo "`date` - Error at function: ${funcstack[1]}"
    echo "`date` - Error details: Could not determine if ${appName} exists at ${appHomeDirectory}."
    exit 1
  fi
}

#------------------------------------------------------------------------------#

function installLatestFromFigmaZip() {
  echo "`date` - Installing from zip file..."
  installAttemptCounter=0

  until [[ -a "${appFullHomeDirectory}" ]]; do
    ((installAttemptCounter++))
    echo "`date` - Changing directory to /private/tmp..."
    cd /private/tmp
    echo "`date` - Unzipping ${installerFullDirectory}..."
    unzip -qq "${installerFullDirectory}"
    echo "`date` - Moving ${appName}.app to ${appHomeDirectory}..."
    mv "${appName}.app" "${appHomeDirectory}"
    sleep 1
    if [[ ! -a "${appFullHomeDirectory}" && "${installAttemptCounter}" == "1" ]]; then
      echo "`date` - First attempt to install app failed."
    elif [[ ! -a "${appFullHomeDirectory}" && "${installAttemptCounter}" == "2" ]]; then
      echo "`date` - Second attempt to install app failed."
    elif [[ ! -a "${appFullHomeDirectory}" && "${installAttemptCounter}" == "3" ]]; then
      echo "`date` - Third attempt to install app failed."
      break
    else
      break
    fi
    sleep 1
  done

  if [[ -a "${appFullHomeDirectory}" ]]; then
    echo "`date` - ${appName}.app was successfully moved to ${appHomeDirectory}."

    echo "`date` - Modifying app owner permission to user: ${userName}"
    chown -R ${userName} "${appFullHomeDirectory}"

    echo "`date` - Opening the ${appName} installer app..."
    open -a "${appFullHomeDirectory}"

    appProcessName=$(defaults read "${plistDirectory}" CFBundleExecutable)
    appPID=$(pgrep "${appProcessName}")
    appInstallerPID=$(echo ${appPID})
    echo "`date` - App installer PID: ${appInstallerPID}"

    openAttemptCounter=0
    until [[ "${appPID}" != "${appInstallerPID}" ]]; do
      ((openAttemptCounter++))
      echo "`date` - UNTIL LOOP: openAttemptCounter: ${openAttemptCounter}"
      sleep 5
      # Pulls the executable name from the app's plist.
      appProcessName=$(defaults read "${plistDirectory}" CFBundleExecutable)
      echo "`date` - UNTIL LOOP: appProcessName: ${appInstallerPID}"
      # Pulls the process ID(s) if the app is running.
      appPID=$(pgrep "${appProcessName}")
      echo "`date` - UNTIL LOOP: appPID: ${appInstallerPID}"

      if [[ "${appPID}" == "${appInstallerPID}" && "${openAttemptCounter}" == "60" ]]; then
        echo "`date` - ${appName} was unable to install."
        break
      fi
      sleep 1
    done

  elif [[ ! -a "${appFullHomeDirectory}" ]]; then
    echo "`date` - ${appName}.app failed to move to ${appHomeDirectory}..."
    abortMission
  else
    echo "`date` - Error at function: ${funcstack[1]}"
    echo "`date` - Error details: Could not determine if ${appName} exists at ${appHomeDirectory}."
    exit 1
  fi

  if [[ "${appPID}" != "${appInstallerPID}" ]]; then
    echo "`date` - Attempting to quit ${appName}..."
    appProcessName=$(defaults read "${plistDirectory}" CFBundleExecutable)
    killall "${appProcessName}"
    sleep 1
    confirmAppQuit=$(pgrep "${appProcessName}")
    if [[ "${confirmAppQuit}" == "" ]]; then
      echo "`date` - Did ${appName} quit successfully: Yes"
    else
      echo "`date` - Did ${appName} quit successfully: No"
      echo "`date` - Error at function: ${funcstack[1]}"
      echo "`date` - Error details: ${appName} was unable to quit."
      echo "`date` - Abort mission..."
      exit 1
    fi
  fi

  checkLatestInstall
}

#------------------------------------------------------------------------------#

function installLatestFromAppTarBz2() {
  echo "`date` - Installing from bz2 file..."
  installAttemptCounter=0

  until [[ -a "${appFullHomeDirectory}" ]]; do
    ((installAttemptCounter++))
    echo "`date` - Changing directory to /private/tmp..."
    cd /private/tmp
    echo "`date` - Extracting ${installerFullDirectory}..."
    bunzip2 -k "${installerFullDirectory}"
    sleep 3
    tar -xf "${appName}.app.tar"
    sleep 3
    echo "`date` - Moving ${appName}.app to ${appHomeDirectory}..."
    mv "${appName}.app" "${appHomeDirectory}"
    sleep 1
    if [[ ! -a "${appFullHomeDirectory}" && "${installAttemptCounter}" == "1" ]]; then
      echo "`date` - First attempt to install app failed."
    elif [[ ! -a "${appFullHomeDirectory}" && "${installAttemptCounter}" == "2" ]]; then
      echo "`date` - Second attempt to install app failed."
    elif [[ ! -a "${appFullHomeDirectory}" && "${installAttemptCounter}" == "3" ]]; then
      echo "`date` - Third attempt to install app failed."
      break
    else
      break
    fi
    sleep 1
  done

  if [[ -a "${appFullHomeDirectory}" ]]; then
    echo "`date` - ${appName}.app was successfully moved to ${appHomeDirectory}."
    checkLatestInstall
  elif [[ ! -a "${appFullHomeDirectory}" ]]; then
    echo "`date` - ${appName}.app failed to move to ${appHomeDirectory}..."
    abortMission
  else
    echo "`date` - Error at function: ${funcstack[1]}"
    echo "`date` - Error details: Could not determine if ${appName} exists at ${appHomeDirectory}."
    exit 1
  fi
}

#------------------------------------------------------------------------------#

function installLatestFromApp() {
  echo "`date` - Installing updated version..."
  installAttemptCounter=0

  until [[ -a "${appFullHomeDirectory}" ]]; do
    ((installAttemptCounter++))
    echo "`date` - Moving ${appName}.app to ${appHomeDirectory}..."
    mv "${installerFullDirectory}" "${appFullHomeDirectory}"
    sleep 1
    if [[ ! -a "${appFullHomeDirectory}" && "${installAttemptCounter}" == "1" ]]; then
      echo "`date` - First attempt to install app failed."
    elif [[ ! -a "${appFullHomeDirectory}" && "${installAttemptCounter}" == "2" ]]; then
      echo "`date` - Second attempt to install app failed."
    elif [[ ! -a "${appFullHomeDirectory}" && "${installAttemptCounter}" == "3" ]]; then
      echo "`date` - Third attempt to install app failed."
      break
    else
      break
    fi
    sleep 1
  done

  if [[ -a "${appFullHomeDirectory}" ]]; then
    echo "`date` - ${appName}.app was successfully installed to ${appHomeDirectory}."
    checkLatestInstall
  elif [[ ! -a "${appFullHomeDirectory}" ]]; then
    echo "`date` - ${appName}.app failed to install to ${appHomeDirectory}..."
    abortMission
  else
    echo "`date` - Error at function: ${funcstack[1]}"
    echo "`date` - Error details: Could not determine if ${appName} exists at ${appHomeDirectory}."
    exit 1
  fi
}

#------------------------------------------------------------------------------#

function installLatestFromPkgDmg() {
  echo "`date` - Installing from pkg within dmg installer..."
  installAttemptCounter=0

  until [[ -a "${appFullHomeDirectory}" ]]; do
    ((installAttemptCounter++))
    echo "`date` - Attaching dmg and opening volume..."
    hdiutil attach ${installerFullDirectory} -nobrowse -quiet
    echo "`date` - Extracting pkg from volume..."
    ditto -rsrc "${pkgInVolumeDirectory}" "${pkgNewDirectory}"
    echo "`date` - Opening and running pkg..."
    installer -pkg "${pkgNewFullDirectory}" -target /
    sleep 1
    if [[ ! -a "${appFullHomeDirectory}" && "${installAttemptCounter}" == "1" ]]; then
      echo "`date` - First attempt to install app failed."
    elif [[ ! -a "${appFullHomeDirectory}" && "${installAttemptCounter}" == "2" ]]; then
      echo "`date` - Second attempt to install app failed."
    elif [[ ! -a "${appFullHomeDirectory}" && "${installAttemptCounter}" == "3" ]]; then
      echo "`date` - Third attempt to install app failed."
      break
    else
      break
    fi
    sleep 1
  done

  if [[ -a "${appFullHomeDirectory}" ]]; then
    echo "`date` - ${appName}.app was successfully installed to ${appHomeDirectory}."
    checkLatestInstall
  elif [[ ! -a "${appFullHomeDirectory}" ]]; then
    echo "`date` - ${appName}.app failed to install to ${appHomeDirectory}..."
    abortMission
  else
    echo "`date` - Error at function: ${funcstack[1]}"
    echo "`date` - Error details: Could not determine if ${appName} exists at ${appHomeDirectory}."
    exit 1
  fi
}

#------------------------------------------------------------------------------#

# Checks if installed version is the latest version.
function checkLatestInstall() {

  if [[ -a "${appFullHomeDirectory}" ]]; then
    echo ""
    echo "`date` - Checking installation of ${appName}..."

    newInstalledVersion=$(defaults read ${plistDirectory} ${plistVersionString})

    if [[ "${newInstalledVersion}" == "" || "${newInstalledVersion}" == "NA" ]]; then
      echo "`date` - ${appName} installed successfully, but the installed version could not be obtained."
      echo "`date` - Installed version: ${newInstalledVersion}"
      echo "`date` - Latest version: ${latestVersion}"
      checkTeamIdentifier
    elif [[ "${newInstalledVersion}" == "${latestVersion}" ]]; then
      echo "`date` - The latest version of ${appName} installed successfully."
      echo "`date` - Installed version: ${newInstalledVersion}"
      echo "`date` - Latest version: ${latestVersion}"
      checkTeamIdentifier
    else
      echo "`date` - ${appName} installed successfully, but the latest version and installed version do not match."
      echo "`date` - Installed version: ${newInstalledVersion}"
      echo "`date` - Latest version: ${latestVersion}"
      checkTeamIdentifier
    fi

  else
    echo "`date` - Error at function: ${funcstack[1]}"
    echo "`date` - Error details: ${appName} does not exist in the ${appFullHomeDirectory} directory."
    abortMission
  fi

}

#------------------------------------------------------------------------------#

function checkTeamIdentifier() {
  echo "`date` - Checking and comparing team identifiers..."
  installedTeamIdentifier=$(codesign -dv ${appFullHomeDirectory} 2>&1 | grep TeamIdentifier | cut -c 16-)

  if [[ "${officialTeamIdentifier}" == "NA" ]]; then
    echo "`date` - A TeamIdentifier is not defined in the script."
    additionalInstallers
  else
    verifyTeamIdentifier
  fi
}

#------------------------------------------------------------------------------#

function verifyTeamIdentifier() {
  if [[ "${officialTeamIdentifier}" == "${installedTeamIdentifier}" ]]; then
    echo "`date` - Does team identifier match: Yes"
    additionalInstallers
  else
    echo "`date` - Does team identifier match: No"
    echo "`date` - This version of ${appName} may not be legitimate."
    teamIdentifierCounter=0

    until [[ ! -a "${appFullHomeDirectory}" ]]; do
      ((teamIdentifierCounter++))
      echo "`date` - Removing app..."
      rm -rf "${appFullHomeDirectory}"
      sleep 1
      if [[ -a "${appFullHomeDirectory}" && "${teamIdentifierCounter}" == "1" ]]; then
        echo "`date` - First attempt to remove app failed."
      elif [[ -a "${appFullHomeDirectory}" && "${teamIdentifierCounter}" == "2" ]]; then
        echo "`date` - Second attempt to remove app failed."
      elif [[ -a "${appFullHomeDirectory}" && "${teamIdentifierCounter}" == "3" ]]; then
        echo "`date` - Third attempt to remove app failed."
        break
      else
        break
      fi
      sleep 1
    done
    restoreApp
  fi
}

#------------------------------------------------------------------------------#

# Stops the script from continuing if debug mode is enabled.
function debugEnd() {
  if [[ "${debugMode}" == "TRUE" ]]; then
    echo ""
    echo "`date` - Stopping script due to DEBUG mode being enabled..."
    echo "`date` - Note: Policy will show as Completed or Failed based on the exit code of the function that ran before the debugEnd function."
    echo "`date` - * * * * * * * * * * End of DEBUG * * * * * * * * * *"
  else
    :
  fi
}

#------------------------------------------------------------------------------#

function additionalInstallers() {
  if [[ "${appName}" == "Wireshark" ]]; then
    echo "`date` - Installing additional packages for Wireshark..."
    echo "`date` - Attempting to install package: Install ChmodBPF.pkg"
    installer -pkg "/Applications/Wireshark.app/Contents/Resources/Extras/Install ChmodBPF.pkg" -target /
    modifyApp
  else
    modifyApp
  fi
}

#------------------------------------------------------------------------------#

# Removes extended file attributes from the app.
function modifyApp() {
  echo "`date` - Modifying app permissions..."
  chown -R root:wheel "${appFullHomeDirectory}"
  chmod -R 775 "${appFullHomeDirectory}"
  xattr -cr "${appFullHomeDirectory}"
  missionAccomplished

}

#------------------------------------------------------------------------------#

# Restores the app from /usr/local/
function restoreApp() {
  echo "`date` - Restoring previous version of ${appName}..."
  mv "${appFullTempDirectory}" "${appHomeDirectory}"
  installedVersion=$(defaults read ${plistDirectory} ${plistVersionString})
  echo "`date` - ${appName} has been restored to version ${installedVersion}."

}

#------------------------------------------------------------------------------#

# Clean up all temporary files.
function cleanUpPreInstall() {
  echo "`date` - Cleaning up potential leftover files from previous install attempts..."
  hdiutil detach $(/bin/df | /usr/bin/grep "${volumeName}" | awk '{print $1}') -quiet

  # Deletes the previous version of app from /usr/local.
  rm -rf "/usr/local/${appName}.app"

  # Deletes the downloaded installer from the /private/tmp directory.
  rm -rf "/private/tmp/${appNameUnderscore}.${installerType}"

  # Deletes the installer checksum file.
  rm -rf "/private/tmp/${appNameUnderscore}-Installer-Checksum.txt"

  # Deletes the checksum file created or downloaded from the app's site.
  rm -rf "/private/tmp/${appNameUnderscore}-Site-Checksum.txt"

  # Deletes the PKG file for the installer.
  rm -rf "/private/tmp/${pkgNameInVolume}.pkg"

  # Deletes any previously unzipped temp files from the /private/tmp directory.
  rm -rf "/private/tmp/__MACOSX"

  # Deletes any previously attempted app.tar.bz2 files.
  rm -rf "/private/tmp/${appName}.app.tar.bz2"

  # Deletes any previously attempted app.tar files.
  rm -rf "/private/tmp/${appName}.app.tar"
}

#------------------------------------------------------------------------------#

# Clean up all temporary files.
function cleanUp() {
  echo "`date` - Cleaning up files..."
  hdiutil detach $(/bin/df | /usr/bin/grep "${volumeName}" | awk '{print $1}') -quiet

  # Deletes the previous version of app from /usr/local.
  rm -rf "/usr/local/${appName}.app"

  # Deletes the downloaded installer from the /private/tmp directory.
  rm -rf "/private/tmp/${appNameUnderscore}.${installerType}"

  # Deletes the installer checksum file.
  rm -rf "/private/tmp/${appNameUnderscore}-Installer-Checksum.txt"

  # Deletes the checksum file created or downloaded from the app's site.
  rm -rf "/private/tmp/${appNameUnderscore}-Site-Checksum.txt"``

  # Deletes the PKG file for the installer.
  rm -rf "/private/tmp/${pkgNameInVolume}.pkg"

  # Deletes the deferral log.
  rm -rf "/Library/Logs/jamf_${appNameUnderscore}_d.log"

  # Deletes any previously unzipped temp files from the /private/tmp directory.
  rm -rf "/private/tmp/__MACOSX"

  # Deletes any previously attempted app.tar.bz2 files.
  rm -rf "/private/tmp/${appName}.app.tar.bz2"

  # Deletes any previously attempted app.tar files.
  rm -rf "/private/tmp/${appName}.app.tar"

  debugEnd

}

#------------------------------------------------------------------------------#

function openApp() {
  if [[ "${appState}" == "ON" ]]; then
    echo "`date` - Launching ${appName}..."
    su -l ${userName} -c "open -a '${appFullHomeDirectory}'"
  fi
}

#------------------------------------------------------------------------------#

# Reopen app and notify user (if applicable).
function missionAccomplished() {

  cleanUp
  killall jamfHelper
  openApp


  if [[ "${appInstalled}" == "FALSE" ]]; then
    echo "`date` - Mission accomplished!"
    exit 0
  else
    if [[ "${prompts}" == "TRUE" && "$appState" == "ON" ]]; then
      echo "`date` - Prompt user the app updated: Yes"
      echo "`date` - Prompt type: updateCompletePrompt"
      updateCompletePrompt
      echo "`date` - Mission accomplished!"
      exit 0
    else
      echo "`date` - Prompt user the app updated: No"
      echo "`date` - Mission accomplished!"
      exit 0
    fi
  fi

}

#------------------------------------------------------------------------------#

function abortMission() {
  restoreApp
  cleanUp
  killall jamfHelper
  openApp
  errorPrompt
  echo "`date` - Abort mission..."
  exit 1
}


################################################################################
#                            END OF MAIN FUNCTIONS                             #
################################################################################



################################################################################
#                               START OF SCRIPT                                #
################################################################################

# Sets new variables based on the Jamf parameters.
basePath="${1}"
computerName="${2}"
userName="${3}"
debugMode="${4}"
applicationName="${5}"
requiredDiskSpace="${6}"
deferralDays="${7}"
prompts="${8}"
updatingWindow="${9}"
definedLatestVersion="${10}"
notUsedParameter11="${11}"

${5}
jamfHelperVariables

################################################################################
#                                 END OF SCRIPT                                #
################################################################################
