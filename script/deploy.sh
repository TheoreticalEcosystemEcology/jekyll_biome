#!/bin/bash
abort() {
    local message=$1
    echo $message
    exit -1
}
[ -z $FTP_PASS ] && abort "FTP_PASS is undefined"
[ -z $FTP_USER ] && abort "FTP_USER is undefined"
[ -z $FTP_SITE ] && abort "FTP_SITE is undefined"
lftp -d -u $FTP_USER,$FTP_PASS $FTP_SITE \
 -e 'set ftps:initial-prot ''; set ftp:ssl-force true; set ftp:ssl-protect-data true; set ssl:verify-certificate false; mirror --ignore-time --parallel=10 -e -v -R _site ~ ; exit'