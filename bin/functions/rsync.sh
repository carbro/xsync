echo $(date) "Start $SOURCE_PATH/$SOURCE_DIR to $TARGET_HOST" 

i=1
#OPTION  1
OPTION[i++]="--itemize-changes"

#OPTION  2
OPTION[i++]="--stats"

#OPTION  3
OPTION[i++]="--progress"

#OPTION  4
OPTION[i++]="--delete"

#OPTION  5
OPTION[i++]="--partial"

##OPTION  6
OPTION[i++]="-avz"

#OPTION  7
OPTION[i++]="--password-file $INSTALL_PATH/config/passwords/$TARGET_PASSWORD_FILE"

#OPTION  10
if [ "$EXCLUDE_FILTER" = "YES" ]; then
OPTION[i++]="--exclude-from=$INSTALL_PATH/config/excludes/$EXCLUDE_DEF_FILE"
fi

#OPTION  8
OPTION[i++]="--port $TARGET_PORT $SOURCE_PATH/$SOURCE_DIR"


#OPTION  100
OPTION[i++]="rsync://$TARGET_USER@$TARGET_HOST$TARGET_PREFIX$TARGET_DIR"

echo rsync ${OPTION[*]}  

#rsync ${OPTION[*]}  
ERROR=99
EMAIL_MESSAGE=""
START_TIME=$(date)
#ERROR=${OPTION[*]}  
#echo "RSYNC EXIT CODE WAS $ERROR"
while [ $ERROR != "0" ]; do
	echo "catched!"
	rsync ${OPTION[*]}  
	ERROR=$?
	echo "RSYNC EXIT CODE WAS $ERROR"
	if [ $ERROR == "0" ]; then
		SUBJECT="Succesful finished Backup Job $JOB_NAME"	
		END_TIME=$(date)
		LOG_FILE=`tail -n 25 /var/log/mirror-scripts/$LOG`
		EMAIL_MESSAGE="
		Start Time was $START_TIME \n
		End Time was $END_TIME \n
		Log: $LOG_FILE"
		source $INSTALL_PATH/bin/email.sh
	else
                SUBJECT="ERROR $ERROR with Backup Job $JOB_NAME"       
                END_TIME=$(date)
                EMAIL_MESSAGE="
		LOG_FILE=`tail -n 25 /var/log/mirror-scripts/$LOG`
		Error Code: $ERROR
                Start Time was $START_TIME
                End Time was $END_TIME
		Log: $LOG_FILE"
                source $INSTALL_PATH/bin/email.sh
	fi
		sleep 30
done

#if [ $ERROR = "0" ]; then
#        EMAIL_MESSAGE="$SOURCE RSYNC EXIT CODE WAS $ERROR"
#	source $INSTALL_PATH/bin/email.sh
#fi

echo $(date) "END $SOURCE_PATH/$SOURCE_DIR to $TARGET_HOST"
