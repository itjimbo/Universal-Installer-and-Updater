# Universal-Installer-and-Updater

This scipt is designed to work with Jamf. It has the ability to install any app defined within the script. Simply input a few parameters for the script when creating the Policy, and the script will take care of everything else. 

Some bullet points about this script:
- You could create two seperate policies with different settings; one to install an app, and one to update an app. The install policy should be set to run once per computer, while the update policy could be set to run once every day, week, month, etc...
- The script is capable of installing apps with the following installers: .dmg, .pkg, .pkg within .dmg, .zip, and .app (apps without an installer). 
- Adding an app to the script is fairly simple. See the **Adding Apps to the Script** section under **Instructions** below.
- This script does not come with a waranty or guarantee of any kind; use at your own risk. It works great for me in my environment of ~300 Mac endpoints.
- If changes are made on the app developer's website, it's possible those changes could break the script. These issues are usually caught fairly quickly and typically resolved within hours. The script will then be updated here on GitHub as well.

## Instructions
### Adding the Script to Jamf
1. In Jamf, navigate to **Settings** > **Computer Management** > **Scripts**, and click **New**.
2. On the **General** tab, for **Display Name** input: **Universal Installer and Updater**
3. On the **Script** tab, copy/paste the contents of the **Universal Installer and Updater.sh** file from this repository.
4. On the **Options** tab, choose **Before** for the **Priority** dropdown.
5. Within the **Options** tab, copy/paste the following **Parameter Labels**:

    **Parameter 4**:
    
    DEBUG MODE - [TRUE = enabled / FALSE = disabled] (If TRUE, the script will run to the point of installing the latest version. If FALSE, the script will run through completely.)
    
    **Parameter 5**:
    
    APPLICATION NAME - (Find the application's function in the script, and copy/paste the name of the function here.)
        
    **Parameter 6**:
    
    REQUIRED DISK SPACE - [0 = no disk space requirement / 1000 = 1 GB / 2000 = 2 GB / 10000 = 10 GB / etc...] (measured in MB)
        
    **Parameter 7**:
    
    DEFERRAL DAYS - [NA = deferral days functions are skipped / 0 = force update the app now / any number greater than or equal to 1 = the number of days the user can defer the update]
        
    **Parameter 8**:
    
    PROMPTS - [TRUE = enabled / FALSE = disabled] (If TRUE, all prompts will be shown to the user only if the app is open. If FALSE, prompts are ignored and the app will update without prompting the user, even if the app is open)
        
    **Parameter 9**: 
    
    UPDATING WINDOW - [TRUE = enabled / FALSE = disabled] (If TRUE, a small and simple HUD will display showing that the app is in the process of updating. If FALSE, no HUD will be displayed.)
        
    **Parameter 10**: 
    
    LATEST VERSION - [NA = parameter is skipped, otherwise fill in desired app version to be installed] (Only use this parameter if the latest version cannot be ontained in the app's function of the script.)
    
    **Parameter 11**: 
    
    _Not currently in use, leave parameter blank._
    
6. Click **Save**.


Here is how the script parameters should be set in Jamf.   
![This is an image](https://raw.githubusercontent.com/itjimbo/Universal-Installer-and-Updater/main/Resources/Jamf%20Script%20Parameter%20Labels.png)

### Explanation of Paramaters
**Parameter 4** - DEBUG MODE
Debug mode is good for...

### Adding an Install Policy to Jamf
Under the **Files and Processes** payload, add the following command to the **Execute Command** code block.

`echo "Displaying last 100 lines from log." && cat /Library/Logs/jamf_<APP_NAME>_iu.log | tail -n 100`

Example:

`echo "Displaying last 100 lines from log." && cat /Library/Logs/jamf_Firefox_iu.log | tail -n 100`

### Adding an Update Policy to Jamf
Under the **Files and Processes** payload, add the following command to the **Execute Command** code block.

`echo "Displaying last 100 lines from log." && cat /Library/Logs/jamf_<APP_NAME>_iu.log | tail -n 100`

Example:

`echo "Displaying last 100 lines from log." && cat /Library/Logs/jamf_Firefox_iu.log | tail -n 100`



## Versions
**Version 2022.04.07**
- Initial upload of script (in working condition)
