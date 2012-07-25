#!/bin/bash

cd `dirname $0`
export SLEK_DIR=`pwd`
export SLEK_PRIVATE=$SLEK_DIR/private
export BACKUP_DIR="$SLEK_DIR/backup-`date +%s`"
mkdir $BACKUP_DIR

cd ~/

for file in `echo $SLEK_DIR/pre-install.d/*` ; do
	$file
done

for thing in `ls -1 $SLEK_DIR/dotfiles/` ; do
	if [ -e .$thing ] ; then 
		cp -r .$thing $BACKUP_DIR/$thing
	fi
	if [ -d $SLEK_DIR/dotfiles/$thing ] ; then
		mkdir -p .$thing
		cp $SLEK_DIR/dotfiles/$thing/* .$thing/
	else
		cp $SLEK_DIR/dotfiles/$thing .$thing
	fi
done

for file in `echo $SLEK_DIR/post-install.d/*` ; do
	$file
done
