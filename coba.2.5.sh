echo "Zsampap asu" | tr '[a-zA-Z]' '[b-zaB-ZA-Z]'

echo "tbnqbq btv" | tr '[b-zaB-ZA-Z]' '[a-zA-Z]'

string="asdfghjk"

echo -n "$string" | while read -N 1
do
    printf '%c\n' "$REPLY"
    printf '%d\n' "'$REPLY"
# coba="$(printf '%d' "'$REPLY")"
printf "$coba"
lima=5
number=`expr $coba + $lima`
# echo $number

printf "\x$(printf %x $number)"
done