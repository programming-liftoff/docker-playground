FROM ubuntu:latest

#==========================
# TODO: Use desired values
#==========================
ENV username andrew
ENV password pass
ENV rootpassword toor

#============
# Add a user
# 1) First add a user and set user's shell to bash and create a directory for user in the /home folder
# 2) Next set the user's password
# 3) Then add the user to the `sudo` group so the user can use the `sudo` command
#============
RUN useradd -ms /bin/bash $username
RUN echo $username:$password | chpasswd
RUN adduser $username sudo

RUN apt-get update

#=====================
# Updates for debconf
# Prevent message 'debconf: unable to initialize frontend: Dialog'
# Prevent message 'debconf: delaying package configuration, since apt-utils is not installed'
#=====================
RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections
RUN apt-get install -y --no-install-recommends apt-utils

#================
# Basic software
# build-essential Includes:
#  - gcc (C language compiler)
#  - g++ (C++ compiler)
#  - make
#================
RUN apt-get install -y sudo
RUN apt-get install -y build-essential
RUN apt-get install -y nano

#===========================================================================
# Install Programming Languages. Add or remove languages as desired.
# Note: C and C++ are installed above and do not need to be listed here.
#===========================================================================

#=========
# Python3
#=========
RUN apt-get install -y python3 && \
    apt-get install -y python3-pip

#================
# Ruby (via RVM)
#================
RUN apt-get install -y curl && \
    gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB && \
    \curl -L https://get.rvm.io | bash -s stable --ruby && \
    adduser $username rvm

#====
# Go
#====
RUN curl -o ./go.linux-amd64.tar.gz https://storage.googleapis.com/golang/go1.9.1.linux-amd64.tar.gz && \
    tar -C /usr/local -xzf go.linux-amd64.tar.gz && \
    rm -f go.linux-amd64.tar.gz
ENV PATH="${PATH}:/usr/local/go/bin"

#===========================================================================
# End of Languages section
#===========================================================================

#===================
# Set root password
#===================
RUN echo root:$rootpassword | chpasswd

#==================
# Set default user
# 1) Set the default user when the container starts
# 2) Set the default directory to load when container starts
#==================
USER $username
WORKDIR /home/$username

# TODO: `chmod 744 entry_point.sh` or `chmod +x entry_point.sh` on file
COPY ./entry_point.sh /
ENTRYPOINT ["/entry_point.sh"]
