#!/bin/bash

# (a)
region=$(awk -F '\t' '{a[$13] += $21} END{for (i in a) print a[i], i }' Sample-Superstore.tsv | sort -g | awk '{print $2}' | head -2 | tail -1 )
echo "1.a." $region

i=0
echo "1.b."

# (b)
for state in `awk -F '\t' -v region="$region" '($13~region) {a[$11] += $21} END{for (i in a) print a[i], i}' Sample-Superstore.tsv | sort -g | awk '{print $2}' | head -2`
do
    arr[$i]=$state
    echo ${arr[$i]}
    i=`expr $i + 1`
done

echo "1.c."

# (c)
awk -F '\t' -v satu="${arr[0]}" -v dua="${arr[1]}" '
    {if ( $11==satu || $11==dua)
    a[$17]+=$21} 
    END{ for (i in a) 
    print a[i], i}' Sample-Superstore.tsv | sort -rg | awk '{sub($1 FS,""); print}' | tail -10