#!/bin/bash

#define function
dekripsi (){
    str=$1
    arr=()
    i=0
    a=97

    hour=$(cat ./log/log_$1.txt)

    while [ "$i" -lt "${#str}" ]; 
        do
        an="$(printf '%d\n' "'${str:$i:1}")"
        let total=$an-$hour

        if [ $total -lt $a ]
            then
            let total+=26
        fi

        arr+=("$(printf '%b' $(printf '\\x%x' $total))")
        i=$((i+1))
    done

    back="$(printf '%s' "${arr[@]}")"
    
}

# (d)
file=$*
namafile="${file%.txt}"

dekripsi $namafile
mv "$*" "$back.txt"