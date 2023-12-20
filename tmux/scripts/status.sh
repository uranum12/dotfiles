if [ "$(uname)" == 'Darwin' ]; then
    top_output=$(top -l 1 -n 0)
    cpu=$(echo "$top_output" | awk '/CPU usage:/ {print $3}')
    mem=$(echo "$top_output" | awk '/PhysMem:/ {print $2}')
    echo "CPU $cpu | MEM $mem"
elif [ "$(expr substr $(uname -s) 1 5)" == 'Linux' ]; then
    temp=" `vcgencmd measure_temp | tr -d -c 0-9.`°C"
    cpu=`sar -u 1 1 | grep 'Average' | awk -v format='%3.1f%%' '{printf(format, 100-$8)}'`
    mem=`free | grep 'Mem' | awk -v format='%3.1f%%' '{printf(format, 100*$3/$2)}'`
    echo "CPU $cpu$temp | MEM $mem"
else
    exit 1
fi
