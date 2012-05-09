#!/bin/bash

INSTALL_PATH=/root/mirror-scripts

#source $INSTALL_PATH/config/config.sh
source $INSTALL_PATH/config/jobs/$4

# include source config
#if [[ ! -e $INSTALL_PATH/config/sources/$1  ]]; then
#echo "The source definition $1 does not exist"
#exit
#fi
source $INSTALL_PATH/config/sources/$1

# include target config
#if [[ ! -e $INSTALL_PATH/config/sources/$2  ]]; then
#echo "The target definition $2 does not exist"
#exit
#fi
source $INSTALL_PATH/config/targets/$2


# set variables
SOURCE=$1
LOG=$5

#check if lock file exists
if [[ -e "$INSTALL_PATH/lock/$JOB_ID-$SOURCE" ]]; then
        echo "JOB LOCK FILE $JOB_ID-$SOURCE EXISTS. EXITING"
	SUBJECT="JOB LOCK FILE $JOB_ID-$SOURCE EXISTS"	
	EMAIL_MESSAGE="JOB LOCK FILE $JOB_ID-$SOURCE EXISTS"
        source $INSTALL_PATH/bin/email.sh
        # should put email here 
        exit
else

	# make a lock file
	touch "$INSTALL_PATH/lock/$JOB_ID-$SOURCE"
	# start execution
	source $INSTALL_PATH/bin/rsync.sh
	# delete lock file
	rm -rf "$INSTALL_PATH/lock/$JOB_ID-$SOURCE"
fi
