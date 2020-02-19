set="abcdefghijklmonpqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
echo $coba
n=28
rand=""
    char=${set:$RANDOM % ${#set}:1}
    rand+=$char
echo $rand