iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1'))
choco install -y visualstudio2015community -packageParameters "--AdminFile https://raw.githubusercontent.com/InsightSoftwareConsortium/ITKBuildRobot/master/MS2012R2/VSAdminDeployment.xml"
choco install -y git cmder vim processhacker javaruntime cmake ninja python3 python2

new-item -ItemType directory C:\Jenkins
new-item -ItemType directory C:\Jenkins\workspace
cd C:\Jenkins

new-item -ItemType directory data
$downloader = new-object System.Net.WebClient
$downloader.DownloadFile('https://sourceforge.net/projects/itk/files/itk/4.9/InsightData-4.9.0.zip/download', 'C:\Jenkins\InsightData-4.9.0.zip')
function Expand-ZIPFile($file, $destination)
{
$shell = new-object -com shell.application
$zip = $shell.NameSpace($file)
foreach($item in $zip.items())
{
$shell.Namespace($destination).copyhere($item)
}
}
Expand-ZIPFile -File 'C:\Jenkins\InsightData-4.9.0.zip' 'C:\Jenkins\'
Move-Item .\InsightToolkit-4.9.0\.ExternalData\MD5 .\data\
Remove-Item .\InsightData-4.9.0.zip
Remove-Item -recurse .\InsightToolkit-4.9.0

new-item -ItemType directory src
cd src
& 'C:\Program Files\Git\bin\git.exe' clone git://itk.org/ITK.git


netsh advfirewall firewall add rule dir=in protocol=TCP localport=445 name=SMPTCP action=allow
netsh advfirewall firewall add rule dir=in protocol=TCP localport=5985 name=WINRMIncoming action=allow

winrm quickconfig
cmd.exe /C 'winrm set winrm/config/service/Auth @{Basic="true"}'
cmd.exe /C 'winrm set winrm/config/service @{AllowUnencrypted="true"}'
cmd.exe /C 'winrm set winrm/config/winrs @{MaxMemoryPerShellMB="16024"}'
