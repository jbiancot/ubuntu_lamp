# A Docker image with Ubuntu, Apache and PHP

A more complete and standard Docker image containing:

* Ubuntu 16.04.3 LTS (xenial)
* Apache/2.4.18
* PHP 7.0.22

_docker image name: jbiancot/ubuntu_lamp_

# I strongly recommend to you a newer version of this images: https://github.com/jbiancot/ubuntu_lamp_java

I have tried some Docker LAMP images but they fall short. In many cases, they have basic Apache/PHP packages and it is hard to extend from them, or they do not follow conventions, e.g: path for web files (.html, .php, .js) is different from the standard, etc.

Then I have decided to tailor-made my own image trying to follow as much the Ubuntu's LAMP stack, this image uses the parent image (ubuntu:16.04)

# Usage

If you are not running Apache Web Server on the host you can use port 80 **otherwise you would need to change the port.**

`docker run -p 80:80 -ti jbiancot/ubuntu_lamp /bin/bash`

Once you are in, you will start Apache webserver manually: **apachectl start**

Like in a standard Ubuntu LAMP installation, I am using:

`/var/www/html`

as the document root for web content.

# Root user and credentials

Open SSH is present, if you want to SSH into the box, please refer to the Dockerfile for root's password (credentials).

You could start SSH service (sshd) in case you want to have access the Docker container from a remote box:

`service ssh start`

# HTTPS

When you start Apache webserver, Ports 80 (HTTP) and 443 (HTTPS) will be open/listening. You will need to setup SSL certificates, etc. In order to be able to use HTTPS.

# About the php.ini file

I didn't modify the php.ini, it is up to you to make the appropriate enhancements, change request time out, memory requirement, date time, etc.

# What files have been modified ?

I have changed a few files with some custom setup but they were tiny modifications, please refer to the Dockerfile to review the the logic I followed.

At the moment, only apache2.conf and 000-default.conf were modified more substantially with a couple of extra lines but I kept the unaltered version of those files on the same directory, just look for the file name and suffix *...backup.conf*

# Apache modules
```
 core_module (static)
 so_module (static)
 watchdog_module (static)
 http_module (static)
 log_config_module (static)
 logio_module (static)
 version_module (static)
 unixd_module (static)
 access_compat_module (shared)
 alias_module (shared)
 auth_basic_module (shared)
 authn_core_module (shared)
 authn_file_module (shared)
 authz_core_module (shared)
 authz_host_module (shared)
 authz_user_module (shared)
 autoindex_module (shared)
 deflate_module (shared)
 dir_module (shared)
 env_module (shared)
 filter_module (shared)
 mime_module (shared)
 mpm_prefork_module (shared)
 negotiation_module (shared)
 php7_module (shared)
 rewrite_module (shared)
 setenvif_module (shared)
 socache_shmcb_module (shared)
 ssl_module (shared)
 status_module (shared)
 unique_id_module (shared)
```

# PHP modules
```
PHP Modules
calendar
Core
ctype
curl
date
dom
exif
fileinfo
filter
ftp
gd
gettext
hash
iconv
json
libxml
mbstring
mcrypt
mysqli
mysqlnd
openssl
pcntl
pcre
PDO
pdo_mysql
Phar
posix
readline
Reflection
session
shmop
SimpleXML
sockets
SPL
standard
sysvmsg
sysvsem
sysvshm
tokenizer
wddx
xml
xmlreader
xmlwriter
xsl
Zend OPcache
zlib

[Zend Modules]
Zend OPcache
```
