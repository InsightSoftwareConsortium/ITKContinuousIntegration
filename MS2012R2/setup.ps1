iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1'))
choco install -y visualstudio2015community git cmder vim processhacker javaruntime cmake ninja python3 python2
