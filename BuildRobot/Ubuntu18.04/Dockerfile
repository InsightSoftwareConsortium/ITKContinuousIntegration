FROM ubuntu:18.04
MAINTAINER Matt McCormick <matt.mccormick@kitware.com>

RUN apt-get -y update && \
  apt-get -y upgrade && \
  apt-get -y install openjdk-8-jdk && \
  apt-get -y update --fix-missing && \
  apt-get install -y openjdk-8-jdk && \
  DEBIAN_FRONTEND=noninteractive apt-get install -y \
    cmake \ 
    cmake-curses-gui \
    ca-certificates \
    curl \
    dvipng \
    libcurl4-openssl-dev \
    libssl-dev \
    libncurses5-dev \
    git \
    gnuplot \
    build-essential \
    python-dev \
    python-numpy \
    python-sphinx \
    ccache \
    clang \
    wget \
    ninja-build \
    subversion && \
  apt-get install -y --no-install-recommends \
    texlive-latex-base && \
  apt-get clean

RUN ccache -M 5G

RUN mkdir -p /jenkins/workspace
WORKDIR /jenkins

# ExternalData cache
RUN mkdir data && \
  wget --content-disposition https://sourceforge.net/projects/itk/files/itk/4.13/InsightData-4.13.0.tar.xz/download && \
  tar -xJf InsightData-4.13.0.tar.xz && \
  mv InsightToolkit-4.13.0/.ExternalData/MD5/ ./data/ && \
  rm -rf Insight*

# The reference repository for cloning
RUN git clone https://github.com/InsightSoftwareConsortium/ITK.git
RUN git clone https://github.com/InsightSoftwareConsortium/ITKExamples.git
