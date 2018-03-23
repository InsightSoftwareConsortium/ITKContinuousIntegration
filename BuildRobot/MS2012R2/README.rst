To start the installation, in an Administrator Powershell::

  iex ((new-object net.webclient).DownloadString('https://raw.githubusercontent.com/InsightSoftwareConsortium/ITKBuildRobot/master/MS2012R2/setup.ps1'))
  
Depending on the version of the operation system, the PowerShell script execution policy may need to be changed before running the script::

  Set-ExecutionPolicy -ExecutionPolicy Unrestricted
