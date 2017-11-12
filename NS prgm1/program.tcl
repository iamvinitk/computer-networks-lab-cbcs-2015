set ns [new Simulator]
set tf [open program.tr w]
$ns trace-all $tf
set nm [open program.nam w]
$ns namtrace-all $nm

set n0 [$ns node]
set n1 [$ns node]
set n2 [$ns node]
set n3 [$ns node]

$ns duplex-link $n0 $n2 100Mb 10ms DropTail
set queue-limit 10

$ns duplex-link $n1 $n2 100Mb 10ms DropTail
set queue-limit 10

$ns duplex-link $n2 $n3 1Mb 10ms DropTail
set queue-limit 5

set udp0 [new Agent/UDP]
$ns attach-agent $n0 $udp0
set cbr0 [new Application/Traffic/CBR]
$cbr0 attach-agent $udp0

set udp1 [new Agent/UDP]
$ns attach-agent $n1 $udp1
set cbr1 [new Application/Traffic/CBR]
$cbr1 attach-agent $udp1

set null3 [new Agent/Null]
$ns attach-agent $n3 $null3

$ns color 1 "red"
$ns color 2 "blue"

$udp0 set class_ 1
$udp1 set class_ 2

$n0 label "Source0/Udp0"
$n1 label "Source1/Udp1"
$n2 label "Router"
$n3 label "Destination"
$ns connect $udp0 $null3
$ns connect $udp1 $null3

$cbr1 set packetSize_ 500Mb
$cbr1 set interval_ 0.001
proc finish { } {
global ns tf nm
$ns flush-trace
close $tf
close $nm
exec nam program.nam &
exit 0
}

$ns at 0.1 "$cbr0 start"
$ns at 0.5 "$cbr1 start"
$ns at 5.0 "finish"
$ns run
~                                                                                                                                              
~                                                                                                                                              
~                                                                                                                                              
~                                                                                                                                              
~                                                                                                                                              
~                                                                                                                                              
~                                                                                                                                              
~                                                                                                                 
