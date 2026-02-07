#! /bin/bash 

SLEEP_SEC=4

while :; do

mem="$(free --mega | awk '/^Mem:/ {print $3 "MB" "/" $2 "MB"}')"

kern="$(uname -r | sed "s/-.*//")"

hdd="$(df -h | awk 'NR==4{print $3, $5}')" 

cpu="$(awk '{u=$2+$4; t=$2+$4+$5; if (NR==1){u1=u; t1=t;} else print ($2+$4-u1) * 100 / (t-t1) "%"; }' <(grep 'cpu ' /proc/stat) <(sleep 1;grep 'cpu ' /proc/stat) | cut -c -4 | sed 's/%//g')"

df="$(df -h | awk 'NR==2{print $3,"("$5")"}')"


echo "+@fg=2;+@fg=0;+@bg=1;+2<$kern+2<+@fg=1;+@fg=0;+@bg=0;+2<Free:+<$df+<+@fg=2;+@fg=0;+@bg=1;+2<CPU:+<$cpu%+2<+@fg=1;+@fg=0;+@bg=0;+2<$mem+<"
sleep $SLEEP_SEC
done
