myvar=$1
first_char="$(printf '%s' "$myvar" | cut -c1)"

for var in $myvar
do
    echo "var=$var" 
done

for angka in 1 2 3 4 5;
do
   echo "angka=$angka";
done

echo $first_char
printf '%d\n' "'$first_char"
coba="$(printf '%d' "'$first_char")"
printf $coba'\n'
lima=5
number=`expr $coba + $lima`
if [$number -gt 122] then
number=-26
fi
echo $number

printf "\x$(printf %x $number)\n"