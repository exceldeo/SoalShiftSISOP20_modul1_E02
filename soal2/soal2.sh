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

dekripsi (){
    str=$1
    arr=()
    i=0
    a=97
    hour=$(cat log_$1.txt)

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


# (a) 
cat /dev/urandom | tr -dc A-Za-z0-9 | head -c 28 > $*


# # (b)
file="$(echo $* | sed 's/[^A-Za-z]*//g')"
namafile="${file%txt}"

# (c)
enkripsi $namafile
mv "$*" "$result.txt"

# (d)
# echo $hour > "log_$result".txt
# dekripsi $result
# mv "$result.txt" "$back.txt"
