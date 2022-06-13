# Versions

**Version 2022.06.13**
- Added the following apps:
   - Adobe Acrobat DC
   - Adobe Acrobat Reader DC
   - Adobe Creative Cloud
   - Appium Server GUI
   - Appium Inspector
- Removed date from every echo command for Jamf logging readability
   - Added date for each section instead
- Added missing function to the installedVersionVariables function
- Added version compare functionality to the latestVersionVariables function
- Added curl command to latestVersion variable for Miro 
- Renamed app functions to match app name in Applications folder
- Renamed some variables
- Fixed FileZilla universalChecksum
- Fixed pgAdmin latestVersion
- Simplified the version compare functions by utilizing sort -V
- Added rm -rf for older log file names

**Version 2022.05.30**
- Added Support App (from root3nl software) and FileZilla app
- Added support for app.tar.bz2 installers (FileZilla)
- Removed downloading checksum files (checksums are stilled curled)
- Added support for SHA512
- Added files to clean up

**Version 2022.05.26**
- Added OpenVPN Connect app
- Added log separator lines for legibility
- Replaced function name in echo commands with "${funcstack[1]}" to pull the name of a current function

**Version 2022.05.23**
- Added Sourcetree app
- Added a JamfHelper window function (quitAppPrompt) to prompt the user to manaually quit an app
   - Primarily created for Docker, but works for all apps
   - Created a custom function (quitAppPreCheck) to determine if the app that must quit is Docker, or some other app
   - Created custom function (quitAppDocker) to quit Docker that utilizes the quitAppPrompt function

**Version 2022.05.20**
- Added list of apps at the top of the script for easy searching
- Updated latestVersion variables for consistency
- Added Beyond Compare, CraftManager, Figma, and Python 3 apps to script
- Figma app uses custom installer
   - 'Figma' and 'installLatestFromFigmaZip' functions were created
   - 'installLatestFromFigmaZip' function was added to the 'determineInstaller' function
- Added additionalInstallers function to install additional packages for Wireshark (and other future apps)
- Added commented line dividers between functions

**Version 2022.05.05**
- Fixed MozillaFirefox function where checksum command was in wrong variable
- Updated errorPrompt JamfHelper description
- Added cleanUp function to compareVersions function to delete the deferral log if the installed version is greater than or equal to the latest version
- Added installedVersion variable to restoreApp function to fix an issue where jamfHelper was not showing the version an app was restored to
- Updated the cleanUpPreInstall and cleanUp functions
- Updated abortMission function to remove obsolete IF statement, and added a killall for jamfHelper

**Version 2022.04.21**
- Initial upload of script to GitHub
- Script is in a working state
