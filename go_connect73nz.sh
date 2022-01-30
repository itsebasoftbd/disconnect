#!/bin/bash
source ~/.db-base

datenow=`date +"%Y-%m-%d %T"`

read user_name is_freeze user_duration <<< $(MYSQL_PWD=$DB_PASS mysql -u $DB_USER -h $DB_HOST -D $DB_NAME -sNe "SELECT user_name, is_freeze, user_duration FROM users WHERE user_name='$USERNAME'")

if [[ $is_freeze -eq 1 ]]; then
exit -1
else
    if [[ $user_duration -eq 0 ]]; then
    exit -1
    else
        MYSQL_PWD=$DB_PASS mysql -u $DB_USER -h $DB_HOST -D $DB_NAME  -sse "UPDATE users SET is_active='1', active_address='OpenConnect', active_date='$datenow', device_connected='1' WHERE user_name='$USERNAME'"
    fi
fi