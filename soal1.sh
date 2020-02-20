# 1 (a)
awk -F '\t' '{a[$13] += $21} END{for (i in a) print a[i], i }' Sample-Superstore.tsv | sort -g | head -2 | tail -1 

# 1(b)
awk -F '\t' '/Central/{a[$11] += $21} END{for (i in a) print a[i], i}' Sample-Superstore.tsv | sort -g | head -2

# 1 (c)
awk -F '\t' 'BEGIN {if( $11=="Illinois" || $11=="Texas" ) a[$17]+=$21} END {for (i in a) print a[i], i}' Sample-Superstore.tsv | sort -g 