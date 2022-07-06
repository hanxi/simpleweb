for fd in $(ls /proc/$$/fd/); do
    [ $fd -gt 2 ] && exec {fd}<&-
done
cd skynet
./skynet examples/config
