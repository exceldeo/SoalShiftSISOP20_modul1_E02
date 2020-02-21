# 3 (a)
jumlah=30
fungsi () {
    for ((num=1; num<=$jumlah; num=num+1))
    do
    # lokasi[$num]=`grep 'Location:' location.log`
    `wget https://loremflickr.com/320/240/cat -O pdkt_kusuma_$num -a wget.log `
    # awk -F ' ' ' '
    done
}
fungsi

grep "Location" wget.log > location.log
readarray line < location.log
for ((i=0; i<28; i++))
do
for ((j=0; j<=i; j++))
do
if [ $i == $j ]
then
continue
elif [ "${line[$i]}" == "${line[$j]}" ]
then
mv pdkt_kusuma_"$(($i+1))".jpg ./duplicate/duplicate_"$i".jpg
fi
done
done

for ((i=1; i<=28; i++))
do
mv pdkt_kusuma_"$i".jpg ./kenangan/kenangan_"$i".jpg
done
cp wget.log wget.log.bak