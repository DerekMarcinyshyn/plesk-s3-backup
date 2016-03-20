# Plesk S3 Backup

Simple shell scripts that copy latest server backup from Plesk 12.5 to a S3 bucket.

It will keep a set amount of archived backups such as 14 dailys and 12 monthlys.

## Setup

Dependencies
[s3cmd](http://s3tools.org/s3cmd)  
python setuptools

### Clone

```
git clone https://github.com/DerekMarcinyshyn/plesk-s3-backup
```

### Cronjobs

```
0 1 * * * /root/plesk-s3-backup/daily.sh > /dev/null 2>&1
0 1 1 * * /root/plesk-s3-backup/monthly.sh > /dev/null 2>&1
```

## Restore

Download the entire "dumps" folder from S3 with the correct date eg. /my-backup-bucket/backup/daily/1411241645/dumps

Copy to your plesk server to the /var/lib/psa/dumps/ folder, you should then access the plesk backup manager and see the entire backup available.


## Restore one subscription:

Download the entire first level of the backup you want to restore eg. /my-backup-bucket/backup/daily/1511241645/dumps/* excluding the domains folder

Download the subscription folder from the domains folder inside the backup with the date you want to restore from eg. /my-backup-bucket/backup/daily/1511241645/dumps/domains/test.com

Copy the downloaded folders back to /var/lib/psa/dumps/ 

You can now use the server backup manager to restore the backup
