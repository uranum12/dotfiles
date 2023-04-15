temp=`vcgencmd measure_temp | tr -d -c 0-9.`°C
cpu=`sar -u 1 1 | grep 'Average' | awk -v format='%3.1f%%' '{printf(format, 100-$8)}'`
mem=`free | grep 'Mem' | awk -v format='%3.1f%%' '{printf(format, 100*$3/$2)}'`
echo "CPU $cpu $temp | MEM $mem"
