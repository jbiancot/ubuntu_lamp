FROM ubuntu:16.04
MAINTAINER Jesus Bianco <jbiancot@gmail.com> 
ENV DEBIAN_FRONTEND noninteractive
ENV LANGUAGE en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8

RUN DEBIAN_FRONTEND=noninteractive 
 
RUN apt-get -qq update
RUN apt-get -qq -y install --no-install-recommends apt-utils

RUN apt-get -qq -y install aptitude
RUN aptitude install locales

ENV LANGUAGE en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8

RUN locale-gen en_US en_US.UTF-8
RUN dpkg-reconfigure locales 

RUN apt-get -qq -y install dialog
RUN apt-get -qq -y install apache2
RUN apt-get -qq -y install net-tools	##  To have tools like: netstat
RUN apt-get -qq -y install -y openssh-server

##  We enable some useful Apache webserver packages.
##
RUN a2enmod ssl			##  only if you need HTTPS, you have to setup manually, e.g: certificates
RUN a2enmod rewrite
RUN a2enmod unique_id

##  We set a root password:  Rush2112
##  The developer MUST change it on Production boxes or use ssh keys !!!
##
RUN echo 'root:Rush2112' | chpasswd

##  We allow to the 'root' user to SSH into the box using passwords.
##
RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

##  We change some Apache webserver configuration files, but we keep the originals (backups)
##
RUN cp /etc/apache2/apache2.conf /etc/apache2/apache2_backup.conf
RUN cp /etc/apache2/sites-available/000-default.conf /etc/apache2/sites-available/000-default_backup.conf

##  We copy our apache2.conf to the Apache webserver directory.
COPY apache2.conf /etc/apache2/

##  We copy our 000-default.conf to the Apache webserver directory.
COPY 000-default.conf /etc/apache2/sites-available/

##  We improve some Apache webserver configuration.
RUN sed -i 's/#AddDefaultCharset UTF-8/AddDefaultCharset UTF-8/' /etc/apache2/conf-available/charset.conf

RUN sed -i 's/ServerTokens OS/ServerTokens Prod/' /etc/apache2/conf-available/security.conf
RUN sed -i 's/ServerSignature On/ServerSignature Off/' /etc/apache2/conf-available/security.conf

RUN apt-get -qq -y install libapache2-mod-php \
	libapache2-mod-php7.0 \
	php7.0 \
	php7.0-cli \
	php7.0-common \
	php7.0-curl \
	php7.0-gd \
	php7.0-json \
	php7.0-mbstring \
	php7.0-mcrypt \
	php7.0-mysql \
	php7.0-opcache \
	php7.0-readline \
	php7.0-xml


#####  EOF - TRON.
