# 3 (a)
jumlah=28
fungsi () {
    for ((num=1; num<=$jumlah; num=num+1))
    do
    # lokasi[$num]=`grep 'Location:' location.log`
    wget https://loremflickr.com/320/240/cat -O pdkt_kusuma_$num.jpg -a wget.log 
    # awk -F ' ' ' '
    done
}
fungsi
num=0
grep "Location" wget.log > location.log
readarray arr < location.log
for ((i=0; i<28; i++))
do
    for ((j=i+1; j<=28; j++))
    do
        if [ "${arr[$i]}" = "${arr[$j]}" ]
        then
            echo ${arr[$i]}
            echo ${arr[$j]}
            echo $i"=="$j
            mv pdkt_kusuma_"$(($j+1))".jpg duplicate/duplicate_"$((num+=1))".jpg
            # duplicate_"$((num+=1))"
        fi
    done
done
num2=0
for ((i=1; i<=28; i++))
do
mv pdkt_kusuma_"$i".jpg kenangan/kenangan_"$((num2+=1))".jpg
done
cp wget.log wget.log.bak