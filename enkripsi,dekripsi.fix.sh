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
    echo "$apalah"
}

denkripsi (){
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
    echo "$apalah"
}

enkripsi $1
denkripsi $2