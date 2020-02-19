enkripsi (){
    str=$1
    arr=()
    i=0
    satu=122
    jam=`date +%H`
    while [ "$i" -lt "${#str}" ]; 
        do
        kw="$(printf '%d\n' "'${str:$i:1}")"
        let jumlah=$kw+$jam
        if [ $jumlah -gt $satu ]
            then
            let jumlah-=26
        fi
        arr+=("$(printf '%b' $(printf '\\x%x' $jumlah))")
        i=$((i+1))
    done
    apalah="$(printf '%s' "${arr[@]}")"
    # echo "$apalah"

}

dekripsi (){
    str=$1
    arr=()
    i=0
    satu=97
    jam=`date +%H`
    while [ "$i" -lt "${#str}" ]; 
        do
        kw="$(printf '%d\n' "'${str:$i:1}")"
        let jumlah=$kw-$jam
        if [ $jumlah -lt $satu ]
            then
            let jumlah+=26
        fi
        arr+=("$(printf '%b' $(printf '\\x%x' $jumlah))")
        i=$((i+1))
    done
    apalah="$(printf '%s' "${arr[@]}")"
    # return $apalah
}


# (a) 
cat /dev/urandom | tr -dc A-Za-z0-9 | head -c 28 > $*.txt


# (b)
file="$(echo $* | sed 's/[^A-Za-z]*//g')"
namafile="${file%txt}"
# printf $namafile
enkripsi $namafile
mv "$*.txt" "$apalah.txt"