# Universal-Installer-and-Updater

This scipt is designed to work with Jamf. It has the ability to install any app defined within the script. Simply input parameters for the script when creating the Jamf Policy.

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
    
    /Resources/Jamf Script Parameter Labels.png

6. Click **Save**.



## Versions
**Version 2022.03.09**
- Initial build of the script
