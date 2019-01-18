#!/bin/bash

API_DEV_KEY=$PASTEBIN_KEY;  # Required, see http://pastebin.com/api#1
API_USER_KEY=''; # Optional, empty = guest, see http://pastebin.com/api#8

#########################################################################################

# default values
NAME=
FORMAT=
PRIVATE=0
EXPIRE_DATE=N

while getopts "n:f:e:hpu" OPTION
do
    case $OPTION in
    n)
        NAME=$OPTARG
        ;;
    f)
        FORMAT="&api_paste_format=${OPTARG}"
        ;;
    e)
        EXPIRE_DATE=$OPTARG
        ;;
    p)
        PRIVATE=2
        ;;
    u)
        PRIVATE=1
        ;;
    ?)
        echo "\
Pastebin.com Bash Script \

Usage : $0 [ -n <name> ] [ -f <format> ] [ -e <expiration> ] [ -p | -u ] [ -h ]

Input data using STDIN.

-n Specify the name of paste to be used
-f Specify code format used, use any of the values here http://pastebin.com/api#5
-e Specify expiration time, default never, examples here http://pastebin.com/api#6
-p Set paste private, requires a userkey, default public
-u Set paste unlisted, default public
"
        exit
        ;;
    esac
done

INPUT="$(</dev/stdin)"

querystring="api_option=paste&api_dev_key=${API_DEV_KEY}&api_user_key=${API_USER_KEY}&api_paste_expire_date=${EXPIRE_DATE}&api_paste_private=${PRIVATE}&api_paste_code=${INPUT}&api_paste_name=${NAME}${FORMAT}"

curl -d "${querystring}" http://pastebin.com/api/api_post.php

echo ""
