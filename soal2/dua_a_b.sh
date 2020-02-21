#!/bin/bash

# (a) 
cat /dev/urandom | tr -dc A-Za-z0-9 | head -c 28 > $*

# (b)
file="$(echo $* | sed 's/[^A-Za-z]*//g')"
mv "$*.txt" "$file.txt"