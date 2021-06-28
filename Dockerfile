# https://medium.com/@aharon.amir/develop-c-on-docker-with-vscode-98fb85b818b2
FROM ubuntu:latest

RUN apt-get update
RUN apt-get install -y 
RUN apt-get install -y git 
RUN apt-get install -y gcc-8 
RUN apt-get install -y g++-8 
RUN DEBIAN_FRONTEND="noninteractive" apt-get install -y cmake 
RUN apt-get install -y gdb 
RUN apt-get install -y gdbserver
RUN apt-get clean autoclean
RUN apt-get autoremove -y
RUN rm -rf /var/lib/apt/lists/*
    
RUN update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-8 999 \
 && update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-8 999 \
 && update-alternatives --install /usr/bin/cc  cc  /usr/bin/gcc-8 999 \
 && update-alternatives --install /usr/bin/c++ c++ /usr/bin/g++-8 999

RUN useradd -ms /bin/bash develop
RUN echo "develop   ALL=(ALL:ALL) ALL" >> /etc/sudoers

# for gdbserver
EXPOSE 2000

USER develop
WORKDIR /home/develop
RUN git clone https://github.com/google/googletest.git

ARG WORKSPACE_ROOT
VOLUME ${WORKSPACE_ROOT}
WORKDIR ${WORKSPACE_ROOT}/build