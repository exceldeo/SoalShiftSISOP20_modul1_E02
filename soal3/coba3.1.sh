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
mv pdkt_kusuma_"$(($i+1))".jpg ./Desktop/SoalShiftSISOP20_modul1_E02/soal3/duplicate/duplicate_"$i".jpg
fi
done
done

for ((i=1; i<=28; i++))
do
mv pdkt_kusuma_"$i".jpg ./Desktop/SoalShiftSISOP20_modul1_E02/soal3/kenangan/kenangan_"$i".jpg
done
cp wget.log wget.log.bak