!#/bin/sh

sudo apt-get -y update
sudo apt-get -y upgrade
sudo apt-get install -y openjdk-7-jdk
sudo apt-get -y update --fix-missing
sudo apt-get install -y openjdk-7-jdk
sudo apt-get install -y cmake \
  cmake-curses-gui \
  libncurses5-dev \
  git \
  build-essential \
  python-dev \
  ccache \
  clang \
  wget \
  ninja-build \
  subversion
ccache -M 5G

sudo mkdir /jenkins
sudo chown ubuntu.ubuntu /jenkins
cd /jenkins
mkdir workspace

# ExternalData cache
mkdir data
wget --content-disposition https://sourceforge.net/projects/itk/files/itk/4.9/InsightData-4.9.0.tar.xz/download
tar -xJf InsightData-4.9.0.tar.xz
mv InsightToolkit-4.9.0/.ExternalData/MD5/ ./data/
rm -rf Insight*

# The reference repository for cloning
mkdir src
cd src
git clone git://itk.org/ITK.git

# CMake
git clone https://cmake.org/cmake.git CMake
cd ..
mkdir bin
cd bin
mkdir CMake
cd CMake
cmake -G Ninja -DCMAKE_BUILD_TYPE=Release ../../src/CMake
ninja
