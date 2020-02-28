#!/bin/bash

mkdir duplicate
mkdir kenangan

readarray arr < location.log

num=0

for ((i=0; i<${#arr[@]}; i++))
do
    for ((j=i+1; j<=${#arr[@]}; j++))
    do
        if [ "${arr[$i]}" = "${arr[$j]}" ]
        then
            # echo ${arr[$i]}
            # echo ${arr[$j]}
            # echo $i"=="$j
            mv pdkt_kusuma_"$(($j+1))".jpg duplicate/duplicate_"$((num+=1))".jpg
        fi
    done
done

angka=0

for ((i=1; i<=${#arr[@]}; i++))
do
    file=pdkt_kusuma_"$i".jpg
    if [ -f "$file" ]
    then
        mv "$file" kenangan/kenangan_"$((angka+=1))".jpg
    fi
done

cp wget.log wget.log.bak