# powershell

Running a PowerShell Script via GitHub

This tutorial will teach you how to call a PowerShell script (.ps1) using the Bypass execution policy to avoid restrictions, ensuring the script runs correctly.

1. Setting Up the Environment
Before running the script, you need to ensure that Windows allows PowerShell scripts to execute. By default, Windows has security restrictions that prevent unsigned scripts from running.

To temporarily bypass this limitation, we will use the Bypass execution policy within the current process scope.

2. Command to Run the Script
The command to execute the script is:
Set-ExecutionPolicy Bypass -Scope Process -Force
& 'D:\Public\script''s\install.ps1' -Force -Confirm

Command Breakdown:
Set-ExecutionPolicy Bypass -Scope Process -Force

Sets the execution policy to Bypass, allowing any script to run.

The Scope Process ensures that this setting is applied only to the current PowerShell session without modifying the system-wide configuration.
-Force suppresses confirmation prompts.
& 'D:\Public\script''s\install.ps1' -Force -Confirm
The & (call operator) executes the script located at the specified path.
The path contains double quotes because there is a special character ('), so we use '' to escape the single quote within the folder name.
-Force and -Confirm are parameters passed to the script, depending on its implementation.

3. Creating a PowerShell Script in a GitHub Repository
If you want to store your script on GitHub and execute it from a repository, follow these steps:

Step 1: Create a Repository on GitHub
Go to GitHub and log in.

Click New repository and provide a name for the repository.

Choose the visibility (public or private) and click Create repository.

Step 2: Add the Script to the Repository
In the repository, click Add file → Create new file.

Name the file install.ps1.

Add your PowerShell script code and click Commit changes to save it.

4. Running the Script Directly from GitHub
If the script is hosted on GitHub, we can download and run it dynamically with the following PowerShell commands:
Set-ExecutionPolicy Bypass -Scope Process -Force
Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/YOUR_USERNAME/YOUR_REPOSITORY/main/install.ps1'))

Explanation:
Invoke-Expression executes the downloaded script directly.

New-Object System.Net.WebClient downloads the script content from the GitHub repository.

Conclusion
This tutorial demonstrated how to call a PowerShell script (.ps1) using Set-ExecutionPolicy Bypass and how to host and execute a script directly from GitHub. This approach is useful for automation and script distribution without needing to store them locally.
