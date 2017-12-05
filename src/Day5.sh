if [ $# -eq 0 ]; then
    echo "No arguments given"
    exit
fi

a=($@)
index=0
count=0

while [ $index -ge 0 -a $index -lt $# ]; do
    jump_value=${a[$index]}
    new_jump=$((jump_value+1))
    a[$index]=$new_jump
    index=$((index+jump_value))
    count=$((count+1))
done

echo $count
