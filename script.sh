#!/bin/bash

# ставим перенос строки как пробелы и переносы
IFS=$'\n'
# WORK_DIR="$HOME"/iptviptv
WORK_DIR="$HOME"/Documents/script
DUMP_FILE="$WORK_DIR/dump_iptv"
USER_FILE="$WORK_DIR/user_file"


if [ -f $DUMP_FILE ]; then
    rm -f $DUMP_FILE
fi

cd $WORK_DIR \
&& wget -O dump_iptv -c https://gitlab.com/iptv135435/iptvshared/raw/main/IPTV_SHARED.m3u

# удаляем пустые строки из дампа
# sed -i '/^$/d' $DUMP_FILE

# line=0
# group_start=false

# for string_from_dump in $(cat $DUMP_FILE); do
#     line=$(( $line+1 ))

#     for channel_from_userlist in $(cat $USER_FILE); do
#         if [ `echo $string_from_dump | grep -i "$channel_from_userlist"` ]; then
#             echo $channel_from_userlist
#             group_start=true
#             break
#         fi
#     done

#     if [ `echo $string_from_dump | grep -i "EXTVLCOPT"`  ] && [ $group_start == true ]; then
#         continue
#     elif [ `echo $string_from_dump | grep -i "http"` ] && [ $group_start == true ] && [ ! `echo $string_from_dump | grep -o -i "EXTINF"` ]; then 
#         group_start=false
#         continue
#     elif [ `echo $string_from_dump | grep -i "rtmp"` ] && [ $group_start == true ]; then 
#         group_start=false
#         continue
#     fi

#     if [ $group_start == false ]; then
#         # удалить строку
#         group_start=false
#         sed -i "$line"d $DUMP_FILE
#         line=$(( $line-1 ))
#     fi
# done

git add .
git commit -m "$(date +'%e.%m.%Y %R')"
git push --force