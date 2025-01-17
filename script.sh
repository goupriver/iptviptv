#!/bin/bash

# ставим перенос строки как пробелы и переносы
IFS=$'\n'
WORK_DIR='/home/goupriver/Documents/script'
DUMP_FILE="$WORK_DIR/dump_iptv"
USER_FILE="$WORK_DIR/user_file"



# удаляем пустые строки из дампа
sed -i '/^$/d' $DUMP_FILE

line=0
group_start=false

for string_from_dump in $(cat $DUMP_FILE); do
    line=$(( $line+1 ))

    for channel_from_userlist in $(cat $USER_FILE); do
        if [ `echo cat $string_from_dump | grep -i "$channel_from_userlist"` ]; then
            echo $channel_from_userlist
            group_start=true
            break
        elif [ `echo $string_from_dump | grep -i "EXTVLCOPT"`  ] && [ $group_start == true ]; then
            echo "== EXTVLCOPT" 2&>/dev/null 
        elif [ `echo $string_from_dump | grep -i "http"` ] && [ $group_start == true ]; then 
            echo "== http" 2&>/dev/null 
        else
            group_start=false
        fi
    done

    if [ $group_start == false ]; then
        # удалить строку
        group_start=false
        sed -i "$line"d $DUMP_FILE
        line=$(( $line-1 ))
    fi
done