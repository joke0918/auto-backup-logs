#!/bin/bash
AppRootPath='/Users/yeohuang/CareerFrog/code';
DATE=$(date -v -1d +%Y%m%d);
backupDir="/Users/yeohuang/Documents/logs-backup";
cd $AppRootPath;
for appName in `ls -l -1`; do
  backupPath="$backupDir/$appName";
  echo $backupPath;
  mkdir -p $backupPath;
  # find mtime +1 logs move into temp-logs folder
  # compress temp-logs and move to /mnt/{appName}/logs folder
  tempBackupFolder=${DATE};
  rm -rf $tempBackupFolder && mkdir $tempBackupFolder;
  for file in `find "$appName/logs" -name "*.log" -mtime +1`; do
    IFS='\/' read -r -a array <<< "$file";
    targetName=$file;
    length=${#array[@]};
    if (($length >= 3)); then
      # /errors/2017-08-08.log -> errors_2017-08-08.log
      targetName="${array[($length-2)]}_${array[($length-1)]}";
      #statements
    fi
    cp $file $tempBackupFolder/$targetName;
  done
  mv $tempBackupFolder $backupPath;
done
