#!/bin/bash

set +eux

cd `dirname $0`
export SLEK_DIR=`pwd`
export BACKUP_DIR="$SLEK_DIR/backup-`date +%Y%m%d-%H%M%S`"
mkdir $BACKUP_DIR

cd ~/

for thing in `ls -1a $SLEK_DIR/dotfiles/ | grep -vE "^(\.|\.\.)$"` ; do
	if [ -L .$thing ] ; then
		echo "Skipping $thing: already a link"
	else
		if [ -e .$thing ] ; then 
			echo "Moving old $thing to $BACKUP_DIR"
			mv .$thing $BACKUP_DIR/$thing
		fi
		echo "Linking $thing to the repo"
		ln -s $SLEK_DIR/dotfiles/$thing ~/.$thing
	fi
done
