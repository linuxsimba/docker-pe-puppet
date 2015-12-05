FROM ubuntu:trusty
MAINTAINER Stanley Kamithi <stanley@linuxsimba.com>

# Set the locale
RUN locale-gen en_US.UTF-8  
ENV LANG en_US.UTF-8  
ENV LANGUAGE en_US:en  
ENV LC_ALL en_US.UTF-8


# Copy the Puppet Enterprise image to the container and run it
ENV PE_DIR  puppet-enterprise-2015.2.3-ubuntu-14.04-amd64
ENV ANSWER_FILE all-in-one.answers.txt
ENV ETC_HOSTS etc_hosts

COPY $PE_DIR.tar.gz /
RUN  tar xvfz $PE_DIR.tar.gz
COPY $ETC_HOSTS /etc/hosts
COPY $ANSWER_FILE $PE_DIR/
RUN $PE_DIR/puppet-enterprise-installer -a $ANSWER_FILE

# PE Console
EXPOSE 443
# Puppet Agent TCP
EXPOSE 8140
# Mcollective
EXPOSE 61613
