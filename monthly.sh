#!/bin/bash

# plesk-s3-backup.sh
#
# @author	Derek Marcinyshyn
# @date		2016-03-19
#
# Copyright (c) 2016, Derek Marcinyshyn <derek@marcinyshyn.com>
# All rights reserved. 
#
# Redistribution and use in source and binary forms, with or without 
# modification, are permitted provided that the following conditions are met: 
#
#  * Redistributions of source code must retain the above copyright notice, 
#    this list of conditions and the following disclaimer. 
#  * Redistributions in binary form must reproduce the above copyright 
#    notice, this list of conditions and the following disclaimer in the 
#    documentation and/or other materials provided with the distribution. 
#
# THIS SOFTWARE IS PROVIDED BY THE AUTHOR AND CONTRIBUTORS ``AS IS'' AND ANY 
# EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED 
# WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE 
# DISCLAIMED. IN NO EVENT SHALL THE AUTHOR OR CONTRIBUTORS BE LIABLE FOR ANY 
# DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES 
# (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR 
# SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER 
# CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT 
# LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY 
# OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH 
# DAMAGE. 

EMAIL="" 
PREFIX="backup" # This is always "backup" in plesk 12.5
KEEP=12 # Backups to keep on S3
AWS_ACCESS_KEY_ID="" 
AWS_ACCESS_KEY_SECRET="" 
BUCKETNAME="" 
ARCHIVENAME="monthly" 
LOGFILE=/root/plesk-s3-backup/plesk-s3-backup/$ARCHIVENAME.log


/root/plesk-s3-backup/plesk-s3-backup.sh -p $PREFIX -K $KEEP -i $AWS_ACCESS_KEY_ID -k $AWS_ACCESS_KEY_SECRET -b $BUCKETNAME -a $ARCHIVENAME > $LOGFILE 2>&1
RET=$?
if [ ! $RET -eq 0 ];then
	echo "The backup job $ARCHIVENAME failed" | mail -s "$ARCHIVENAME Backup to s3 failed see attached log" -a $LOGFILE "$EMAIL"
else
	echo "The backup job $ARCHIVENAME was succesful" | mail -s "$ARCHIVENAME Backup to s3 was successful" -a $LOGFILE "$EMAIL"
fi