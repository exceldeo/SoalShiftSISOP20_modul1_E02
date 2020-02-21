echo "soal 1 a"
# 1 (a)
awk -F '\t' '{a[$13] += $21} END{for (i in a) print a[i], i }' Sample-Superstore.tsv | sort -g | head -2 | tail -1 
echo "soal 1 b"
#  1(b)
awk -F '\t' '/Central/{a[$11] += $21} END{for (i in a) print a[i], i}' Sample-Superstore.tsv | sort -g | head -2

echo "soal 1 c"
# 1 (c)
awk -F '\t' '
    {if ( $11=="Illinois" || $11=="Texas" ) 
    a[$17]+=$21} 
    END{ for (i in a) 
    print a[i], i}' Sample-Superstore.tsv | sort -rg | tail -10