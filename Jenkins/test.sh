#!/bin/bash

set -euo pipefail

installed_version=2.112
echo "Jenkins installed version: $installed_version"
backup_version=2.187.3
echo "backup :$backup_version"

# Taken and customized from:
# https://stackoverflow.com/questions/4023830/how-to-compare-two-strings-in-dot-separated-version-format-in-bash
vercomp () {
    if [[ $1 == $2 ]]
    then
        comp=0
        return
    fi
    local IFS=.
    local i ver1=($1) ver2=($2)
    echo "ver1:""${ver1[@]}"
echo "ver2:""${ver2[@]}"

    # fill empty fields in ver1 with zeros
    for ((i=${#ver1[@]}; i<${#ver2[@]}; i++))
    do
        ver1[i]=0
    done
    for ((i=0; i<${#ver1[@]}; i++))
    do
        echo $i
        echo "ver1:"${ver1[i]}
        echo "ver2:"${ver2[i]}
        if [[ ! ${ver2[i]+abc} ]]
        then
            echo "plop"
            # fill empty fields in ver2 with zeros
            ver2[i]=0
        fi
        if ((10#${ver1[i]} > 10#${ver2[i]}))
        then
            comp=1
            return
        fi
        if ((10#${ver1[i]} < 10#${ver2[i]}))
        then
            comp=0
            return
        fi
    done
    return 0
}

vercomp $backup_version $installed_version

if [[ $comp -ne 0 ]]
then
  echo "Jenkins installed version is older than backup."
  echo "Update Jenkins before recovering backup."
  exit -1
fi
