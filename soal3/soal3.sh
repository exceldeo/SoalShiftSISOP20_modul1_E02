#!/bin/bash

jumlah=28

readarray arr < location.log
index=${#arr[@]}

download () {
    for ((num=1; num<=$jumlah; num=num+1))
    do
        index=$((index+=1))
        wget https://loremflickr.com/320/240/cat -O pdkt_kusuma_$index.jpg -a wget.log
    done
}

# (a)
download
grep "Location" wget.log > location.log