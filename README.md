# <ins>Universal-Installer-and-Updater</ins>
Note: You can use GitHub's built in table of contents to jump to a specific section.

# <ins>About</ins>
This scipt is designed to work with Jamf. It has the ability to install or update any app defined within the script. Simply input a few parameters on the script payload when creating a policy, and the script will take care of the rest. Instructions below on how to setup a functioning workflow of the script in Jamf, creating install and update policies, and other tips for implenting this workflow in your Jamf environment.

## A Few Notes About this Script
- You can create at least two seperate policies with different settings: one for installing an app, and one for updating an app.
- The script is capable of installing apps with the following installers: .dmg, .pkg, .pkg within .dmg, .zip, and .app.
- Adding an app to the script is fairly simple. See the **Adding Apps to the Script** subsection below.
- This script does not come with a waranty or guarantee of any kind; use at your own risk. It works great in my environment of ~300 Mac endpoints.
- If changes are made on the app developer's website, it's possible those changes could break the script. These issues are usually caught fairly quickly and typically resolved within hours. The script will then be updated here on GitHub as well.

## Instructions Outline
1. Adding the script to Jamf.
2. Creating individual Policies for each app you would like to install/update:
   - Creating a policy to install an app via Self Service
   - Creating a policy to install an app to endpoints automatically
   - Creating a policy to update an app via Self Service
   - Creating a policy to update an app automatically for endpoints
3. Setting the parameters under the Script payload within each Policy.
4. Add software titles of your choice to Patch Management to monitor updates.

# <ins>Instructions (Prerequisites)</ins>
The following instructions will guide you through adding the script to Jamf, as well as an explanation of the script's parameters.

## Adding the Script to Jamf
1. In Jamf, navigate to **Settings** > **Computer Management** > **Scripts** > **New**
2. On the **General** tab for **Display Name**, input: **`Universal Installer and Updater`**.
   - **Note**: The screenshot shows "Universal Installer and Updater (Production)" as the script name. I have the same script created as a test script as well so I can test changes to the script before deploying it to production. You may want to do this as well, but it's completely optional.
   - [Screenshot](https://raw.githubusercontent.com/itjimbo/Universal-Installer-and-Updater/main/Resources/Script%20%3E%20General.png)
3. On the **Script** tab, copy/paste the contents of the **[Universal Installer and Updater.sh](https://github.com/itjimbo/Universal-Installer-and-Updater/blob/main/Universal%20Installer%20and%20Updater.sh)** file from this repository.
   - [Screenshot](https://raw.githubusercontent.com/itjimbo/Universal-Installer-and-Updater/main/Resources/Script%20%3E%20Script.png)
4. On the **Options** tab, choose **Before** for the **Priority** dropdown, and copy/paste the following **Parameter Labels**:
   - [Screenshot](https://raw.githubusercontent.com/itjimbo/Universal-Installer-and-Updater/main/Resources/Script%20%3E%20Options.png)

    **Parameter 4**:
    
    `DEBUG MODE - [TRUE = enabled / FALSE = disabled] (If TRUE, the script will run to the point of installing the latest version. If FALSE, the script will run through completely.)`
    
    **Parameter 5**:
    
    `APPLICATION NAME - (Find the application's function in the script, and copy/paste the name of the function here.)`
        
    **Parameter 6**:
    
    `REQUIRED DISK SPACE - [0 = no disk space requirement / 1000 = 1 GB / 2000 = 2 GB / 10000 = 10 GB / etc...] (measured in MB)`
        
    **Parameter 7**:
    
    `DEFERRAL DAYS - [NA = deferral days functions are skipped / 0 = force update the app now / any number greater than or equal to 1 = the number of days the user can defer the update]`
        
    **Parameter 8**:
    
    `PROMPTS - [TRUE = enabled / FALSE = disabled] (If TRUE, all prompts will be shown to the user only if the app is open. If FALSE, prompts are ignored and the app will update without prompting the user, even if the app is open)`
        
    **Parameter 9**: 
    
    `UPDATING WINDOW - [TRUE = enabled / FALSE = disabled] (If TRUE, a small and simple HUD will display showing that the app is in the process of updating. If FALSE, no HUD will be displayed.)`
        
    **Parameter 10**: 
    
    `LATEST VERSION - [NA = parameter is skipped, otherwise fill in desired app version to be installed] (Only use this parameter if the latest version cannot be ontained in the app's function of the script.)`
    
    **Parameter 11**: 
    
    _Not currently in use, leave parameter blank._
    
6. Click **Save**.

## Explanation of Paramaters
**Parameter 4 - DEBUG MODE**

- Debug mode will run up to the point of downloading the latest installer. It will not install/update the app. This is useful for checking that everything in the script works as expected up to that point.

**Parameter 5 - APPLICATION NAME**

- This is the app's function name from within the script. It lets the script know which app the Policy is configured for.

**Parameter 6 - REQUIRED DISK SPACE**

- Some apps are very large or may require a specified amount of disk space. This parameter will ensure the target machine has the minimum required disk space before proceeding with install/update attempts. The disk space is measured in megabytes (MB). 

**Parameter 7 - DEFERRAL DAYS**

- The number of days a user is permitted to defer an update. A log is kept with the date the user first deferred. Each time the script runs, it will check if there's a deferral log. If a deferral log exists and the user defers again, the days will count down each day until the user has reached the maximum deferral limit. Once the limit has been reached, the app will forcibly update. This parameter can also be modified and it will update the user's deferral log. If a user has 5 days left on their deferral log, but a vulnerability has been identified for a certain app and you'd like the app to be updated on all machines within 2 days, simply change the parameter to two days and it will update the users deferral log the next time the Policy runs.

**Parameter 8 - PROMPTS**

- These are Jamf Helper window prompts. These include update prompts, error prompts, deferral prompts, and update complete prompts. All prompts require user interaction. Even if set to true, prompts will only appear if the app was running when the Policy ran. If the app was not running, prompts are not displayed and will not interrupt the user.

**Parameter 9 - UPDATING WINDOW**

- These are Jamf Helper window prompts to inform the user an app is updating. It will only appear if the app was running when the Policy ran. No user interaction is required for this prompt. It's a small and simple window to show the user an app is updating. 

**Parameter 10 - LATEST VERSION**

- Some apps developer sites simply don't post release notes or include the latest version number of their app(s) anywhere. In these instances, you can still use this script by defining the latest version in this parameter.

**Parameter 11 - _Blank_**

- This parameter is not currently in use.

# <ins>Instructions (Configuring Policies)</ins>
The following instructions contain 4 sections that will guide you with configuring the following: 
- Adding an app to Self Service so users can install an app
- Adding a "Check for Updates" chiclet in Self Service for the app so users can check for updates at any time
- Adding an automatic installer that deploys the app automatically to target computers
- Adding an automatic updater that updates an app automatically to target computers

## Creating an Install Policy for Self Service
In the steps below, Mozilla Firefox will be used as an example. This is an install policy that allows the app to be downloaded via Self Service. To install an app to endpoints automatically, skip to the **Adding an Install Policy for Automatic Installs** section below.

1. In Jamf, navigate to **Computers** > **Policies** > **New**
2. On the **General** tab, fill in the following:
      
      a. **Display Name**: `Mozilla Firefox - Install`
      
      b. **Enabled**: Checked
      
      c. **Trigger**: _None_
      
      d. **Execution Frequency**: Ongoing
      
      [Screenshot](https://raw.githubusercontent.com/itjimbo/Universal-Installer-and-Updater/main/Resources/Policy%20%3E%20General.png)
      
3. Click on the **Scripts** payload, then click **Configure**. Search for the **Universal Installer and Updater** script, then click **Add**.
4. Be sure the **Priority** option is set to **Before**. Then fill in the following parameters:

      a. **DEBUG MODE**: FALSE
   
      b. **APPLICATION NAME**: MicrosoftWord
   
      c. **REQUIRED DISK SPACE**: 0 _(or configure to your liking based on the parameter's details)_
   
      d. **DEFERRAL DAYS**: 7 _(or configure to your liking based on the parameter's details)_
   
      e. **PROMPTS**: TRUE
   
      f: **UPDATING WINDOW**: TRUE 
   
      g. **LATEST VERSION**: NA _(since the latest version is obtained in the script itself)_
   
      h. **Paramter 11**: _blank_
      
      [Screenshot](https://raw.githubusercontent.com/itjimbo/Universal-Installer-and-Updater/main/Resources/Policy%20%3E%20Scripts.png)
   
5. Click on the **Files and Processes** payload, then click **Configure**. For the **Execute Command** option, copy/paste: 

   `echo "Displaying last 100 lines from log." && cat /Library/Logs/jamf_Firefox_iu.log | tail -n 100`
   
   [Screenshot](https://raw.githubusercontent.com/itjimbo/Universal-Installer-and-Updater/main/Resources/Policy%20%3E%20Files%20and%20Processes.png)
   
6. Click on the **Scope** tab and choose which computers or users the policy should be deployed to. It's a good idea to use test machines first to make sure the policy/script works.
7. Click on the **Self Service** tab and configure the app for deployment via Self Service (optional).
   
   [Screenshot](https://raw.githubusercontent.com/itjimbo/Universal-Installer-and-Updater/main/Resources/Policy%20%3E%20Self%20Service.png)
   
8. Click **Save**.

## Creating an Install Policy to Automatically Distribute an App
This will create a policy which will deploy an app automatically to target computers.

1. In Jamf, navigate to **Computers** > **Policies** > **New**
2. On the **General** tab, fill in the following:
      
      a. **Display Name**: `Mozilla Firefox - Automatically Install`
      
      b. **Enabled**: Checked
      
      c. **Trigger**: Recurring Check-in
      
      d. **Execution Frequency**: Once per computer
      
      [Screenshot]()
      
3. Click on the **Scripts** payload, then click **Configure**. Search for the **Universal Installer and Updater** script, then click **Add**.
4. Be sure the **Priority** option is set to **Before**. Then fill in the following parameters:

      a. **DEBUG MODE**: FALSE
   
      b. **APPLICATION NAME**: MozillaFirefox _(or any other app within the script you would like to install)_
   
      c. **REQUIRED DISK SPACE**: 0 _(or configure to your liking based on the parameter's details)_
   
      d. **DEFERRAL DAYS**: 7 _(or configure to your liking based on the parameter's details)_
   
      e. **PROMPTS**: TRUE
   
      f: **UPDATING WINDOW**: TRUE 
   
      g. **LATEST VERSION**: NA _(NA, since the latest version is obtained in the script itself)_
   
      h. **Paramter 11**: _blank_
      
      [Screenshot](https://raw.githubusercontent.com/itjimbo/Universal-Installer-and-Updater/main/Resources/Policy%20%3E%20Scripts.png)
   
5. Click on the **Files and Processes** payload, then click **Configure**. For the **Execute Command** option, copy/paste the command below.
   
   `echo "Displaying last 100 lines from log." && cat /Library/Logs/jamf_Firefox_iu.log | tail -n 100`
   
   Note: The log file name is always the name of the app as it appears in the Applications folder, but without the spaces. Update the 'jamf_Firefox_iu.log' portion of the command with the app you are working with. For example, if you are creating a policy for Google Chrome, then the log file name would be 'jamf_GoogleChrome_iu.log', and the command would appear as shown below.

   `echo "Displaying last 100 lines from log." && cat /Library/Logs/jamf_GoogleChrome_iu.log | tail -n 100`
   
   [Screenshot](https://raw.githubusercontent.com/itjimbo/Universal-Installer-and-Updater/main/Resources/Policy%20%3E%20Files%20and%20Processes.png)
   
6. Click on the **Scope** tab and select which computers or users the policy should be deployed to. It's a good idea to use test computers first to be sure the policy/script works.
7. Click on the **Self Service** tab and be sure **Make the policy available in Self Service** option is **unchecked**.
   
   [Screenshot](https://raw.githubusercontent.com/itjimbo/Universal-Installer-and-Updater/main/Resources/Policy%20%3E%20Self%20Service.png)
   
8. Click **Save**.

## Creating an Update Policy for Self Service
This policy will allow users to check an app for updates at any time in Self Service.

1. In Jamf, navigate to **Computers** > **Policies** > **New**
2. On the **General** tab, fill in the following:
      
      a. **Display Name**: `Mozilla Firefox - Check for Updates`
      
      b. **Enabled**: Checked
      
      c. **Trigger**: _None_
      
      d. **Execution Frequency**: Ongoing
      
      [Screenshot](https://raw.githubusercontent.com/itjimbo/Universal-Installer-and-Updater/main/Resources/Policy%20%3E%20General.png)
      
3. Click on the **Scripts** payload, then click **Configure**. Search for the **Universal Installer and Updater** script, then click **Add**.
4. Be sure the **Priority** option is set to **Before**. Then fill in the following parameters:

      a. **DEBUG MODE**: FALSE
   
      b. **APPLICATION NAME**: MozillaFirefox 
      _(or any other app within the script you would like to install)_
   
      c. **REQUIRED DISK SPACE**: 0 
      _(or configure to your liking based on the parameter's details)_
   
      d. **DEFERRAL DAYS**: 7 
      _(or configure to your liking based on the parameter's details)_
   
      e. **PROMPTS**: TRUE
   
      f: **UPDATING WINDOW**: TRUE 
   
      g. **LATEST VERSION**: NA 
      _(since the latest version is obtained in the script itself)_
   
      h. **Paramter 11**: 
      _(leave blank)_
      
      [Screenshot](https://raw.githubusercontent.com/itjimbo/Universal-Installer-and-Updater/main/Resources/Policy%20%3E%20Scripts.png)
   
5. Click on the **Files and Processes** payload, then click **Configure**. For the **Execute Command** option, copy/paste: 

   `echo "Displaying last 100 lines from log." && cat /Library/Logs/jamf_Firefox_iu.log | tail -n 100`
   
   [Screenshot](https://raw.githubusercontent.com/itjimbo/Universal-Installer-and-Updater/main/Resources/Policy%20%3E%20Files%20and%20Processes.png)
   
6. Click on the **Scope** tab and choose which computers, users, and or groups the policy should deployed to. It's a good idea to use test machines first to make sure the policy/script works.
7. Click on the Self Service tab and be sure **Make the policy available in Self Service** option is **checked**. Configure the settings as shown in the screenshot below.
   
   [Screenshot](https://raw.githubusercontent.com/itjimbo/Universal-Installer-and-Updater/main/Resources/Policy%20%3E%20Self%20Service.png)
   
8. Click **Save**.

## Creating an Update Policy to Automatically Update an App
This will create a policy which will automatically update an app on target computers based on the execution frequency.

1. In Jamf, navigate to **Computers** > **Policies** > **New**
2. On the **General** tab, fill in the following:
      
      a. **Display Name**: `Mozilla Firefox - Automatically Update`
      
      b. **Enabled**: Checked
      
      c. **Trigger**: Recurring Check-in
      
      d. **Execution Frequency**: Once every day _(or once every week/month depending on how often you want the policy to check for udpates)_
      
      [Screenshot](URL)
      
3. Click on the **Scripts** payload, then click **Configure**. Search for the **Universal Installer and Updater** script, then click **Add**.
4. Be sure the **Priority** option is set to **Before**. Then fill in the following parameters:

      a. **DEBUG MODE**: FALSE
   
      b. **APPLICATION NAME**: MozillaFirefox _(or any other app within the script you would like to install)_
   
      c. **REQUIRED DISK SPACE**: 0 _(or configure to your liking based on the parameter's details)_
   
      d. **DEFERRAL DAYS**: 7 _(or configure to your liking based on the parameter's details)_
   
      e. **PROMPTS**: TRUE
   
      f: **UPDATING WINDOW**: TRUE 
   
      g. **LATEST VERSION**: NA _(NA, since the latest version is obtained in the script itself)_
   
      h. **Paramter 11**: _blank_
      
      [Screenshot](https://raw.githubusercontent.com/itjimbo/Universal-Installer-and-Updater/main/Resources/Policy%20%3E%20Scripts.png)
   
5. Click on the **Files and Processes** payload, then click **Configure**. For the **Execute Command** option, copy/paste the command below.
   
   `echo "Displaying last 100 lines from log." && cat /Library/Logs/jamf_Firefox_iu.log | tail -n 100`
   
   Note: The log file name is always the name of the app as it appears in the Applications folder, but without the spaces. Update the 'jamf_Firefox_iu.log' portion of the command with the app you are working with. For example, if you are creating a policy for Google Chrome, then the log file name would be 'jamf_GoogleChrome_iu.log', and the command would appear as shown below.

   `echo "Displaying last 100 lines from log." && cat /Library/Logs/jamf_GoogleChrome_iu.log | tail -n 100`
   
   [Screenshot](https://raw.githubusercontent.com/itjimbo/Universal-Installer-and-Updater/main/Resources/Policy%20%3E%20Files%20and%20Processes.png)
   
6. Click on the **Scope** tab and select which computers or users the policy should be deployed to. It's a good idea to use test computers first to be sure the policy/script works.
7. Click on the **Self Service** tab and be sure **Make the policy available in Self Service** option is **unchecked**.
   
   [Screenshot](https://raw.githubusercontent.com/itjimbo/Universal-Installer-and-Updater/main/Resources/Policy%20%3E%20Self%20Service.png)
   
8. Click **Save**.

# <ins>Instructions (Duplicating Policies)</ins>
If you would like to create the same policies for other apps, I recommend duplicating the existing policies and simply updating a few of the options to match the newly configured app.

## Duplicating Policies for Other Apps
A breakdown of each type of policy is listed below, with the changes each policy would need for a newly configured app.

### <ins>Creating an Install Policy for Self Service</ins>
 - Update the...
 - Update the...
### <ins>Creating an Install Policy to Automatically Distribute an App</ins>
 - Update the...
 - Update the...
### <ins>Creating an Update Policy for Self Service</ins>
 - Update the...
 - Update the...
### <ins>Creating an Update Policy to Automatically Update an App</ins>
 - Update the...
 - Update the...


# <ins>Adding Apps to the Script</ins>
You can add new apps to the script with minimal effort. 

# <ins>Log Samples</ins>
Logs are available in two places. The script keeps a log of everything it does locally on an endpoint, and it also reports the last 100 lines of the log to Jamf's policy logs. 

Here is a sample of a log from Jamf after an update with of Mozilla Firefox. It's not the prettiest since Jamf displays a narrow window for logs, but it's still legibile. 

[Screenshot](https://raw.githubusercontent.com/itjimbo/Universal-Installer-and-Updater/main/Resources/Jamf%20%3E%20Mozilla%20Firefox%20%3E%20Logs.png)

Here is a sample of the same log from the local machine. You can see it's much easier to read than the version in Jamf.

[Screenshot](https://raw.githubusercontent.com/itjimbo/Universal-Installer-and-Updater/main/Resources/Library%20%3E%20Logs%20%3E%20Mozilla%20Firefox.png)
