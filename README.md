# Universal-Installer-and-Updater

This scipt is designed to work with Jamf. It has the ability to install any app defined within the script. Simply input a few parameters for the script when creating the Policy, and the script will take care of everything else. 

Some bullet points about this script:
- You could create two seperate policies with different settings; one to install the app, and one to update the app. The install policy should be set to run once per computer, while the update policy could be set to run once every day, week, month, etc...
- The script is capable of installing apps with the following installers: .dmg, .pkg, .pkg within .dmg, .zip, and .app (apps without an installer). 
- Adding an app to the script is fairly simple. Check out the **Adding Apps to the Script** section under **Instructions** below.
- This script does not come with a waranty or guarantee of any kind; use at your own risk. It works fine for me in my environment of ~300 Mac endpoints.
- At times the script can and will fail or break due to changes from the app vendor's website. These issues are usually caught fairly quickly and resolved just as quick. The script will then be updated here as well.

## Instructions
### Adding the Script to Jamf
1. In Jamf, navigate to **Settings** > **Computer Management** > **Scripts**, and click **New**.
2. On the General tab, for **Display Name** input: **Universal Installer and Updater**
3. On the Script tab, copy/paste the contents of the **Universal Installer and Updater.sh** file from this repository.
4. On the Options tab, choose **Before** for the **Priority** dropdown.
5. On the same tab, copy/paste the following **Parameter Labels**:

    **Parameter 4**:
    
    DEBUG MODE (TRUE = will run entire script up to the point of installing the latest version, FALSE = debug mode is disabled and the script will run through completely)
    
    **Parameter 5**:
    
    APPLICATION NAME (Find the name of the application's function in the script, and copy/paste it here)
        
    **Parameter 6**:
    
    REQUIRED DISK SPACE (measured in MB) (0 = no disk space requirement, 1000 = 1 GB,  2000 = 2 GB, 10000 MB = 10 GB, etc...)
        
    **Parameter 7**:
    
    DEFERRAL DAYS (NA = deferral days functions are skipped, 0 = force update the app now, any. number greater than or equal to 1 = the number of days the user can defer the update)
        
    **Parameter 8**:
    
    PROMPTS (TRUE = will show all prompts to the user only if the app is open, FALSE = prompts are ignored and the app will update without informing the user if the app is open)
        
    **Parameter 9**: 
    
    _Not currently in use_
        
    **Parameter 10**: 
    
    _Not currently in use_
    
    **Parameter 11**: 
    
    _Not currently in use_
    
    ![This is an image](https://raw.githubusercontent.com/itjimbo/Universal-Installer-and-Updater/main/Resources/Jamf%20Script%20Parameter%20Labels.png)

6. Click **Save**.

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
**Version 2022.03.09**
- Initial build of the script (in working condition)
