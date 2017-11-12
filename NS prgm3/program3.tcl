set ns [new Simulator]
set tf [open program3.tr w]
$ns trace-all $tf
set nm [open program3.nam w]
$ns namtrace-all $nm

set n0 [$ns node]
set n1 [$ns node]
set n2 [$ns node]
set n3 [$ns node]


$ns make-lan "$n0 $n1 $n2 $n3" 10MB 10ms LL Queue/DropTail Mac/802_3

set tcp0 [new Agent/TCP]
$ns attach-agent $n0 $tcp0

set tcp1 [new Agent/TCP]
$ns attach-agent $n1 $tcp1

set ftp0 [new Application/FTP]
$ftp0 attach-agent $tcp0

set ftp1 [new Application/FTP]
$ftp1 attach-agent $tcp1

set sink2 [new Agent/TCPSink]
$ns attach-agent $n2 $sink2

set sink3 [new Agent/TCPSink]
$ns attach-agent $n3 $sink3

set file1 [open file1.tr w]
$tcp0 attach $file1
$tcp0 trace cwnd_
$tcp0 set maxcwnd_ 10


set file2 [open file2.tr w]
$tcp1 attach $file2
$tcp1 trace cwnd_


$ns at 0.1 "$ftp0 start"
$ns at 1.5 "$ftp0 stop"
$ns at 2 "$ftp0 start "
$ns at 3 "$ftp0 stop"


$ns at 0.2 "$ftp1 start"
$ns at 2 "$ftp1 stop"
$ns at 2.5 "$ftp1 start "
$ns at 4 "$ftp1 stop"

$ns connect $tcp0 $sink2
$ns connect $tcp1 $sink3

proc finish { } {
global  ns nm tf
$ns flush-trace
exec nam program3.nam &
close $tf
close $nm
exit 0
}

$ns at 5.0 "finish"
$ns run




















