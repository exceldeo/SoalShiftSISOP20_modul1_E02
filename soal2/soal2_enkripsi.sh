#!/bin/bash

#define function
enkripsi (){
    str=$1
    arr=()
    i=0
    z=122
    hour=`date +%H`

    while [ "$i" -lt "${#str}" ]; 
        do
        an="$(printf '%d\n' "'${str:$i:1}")"        
        let total=$an+$hour

        if [ $total -gt $z ]
            then
            let total-=26
        fi

        arr+=("$(printf '%b' $(printf '\\x%x' $total))")
        i=$((i+1))
    done

    result="$(printf '%s' "${arr[@]}")"
}

# (c)
file=$*
namafile="${file%.txt}"

enkripsi $namafile
mv "$*" "$result.txt"

echo $hour > "./log/log_$result".txt