#!/bin/sh

# Send SIGTERM to child processes of PID 1.
function signal_handler()
{
    echo "Stop"
    local pid=$(pidof ffmpeg)
	kill -9 2
    exit
}


trap signal_handler 1 2 3 13 15

echo "Running"
$@ &
pid=$!

wait ${pid}
exit $?
