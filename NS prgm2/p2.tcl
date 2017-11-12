set ns [new Simulator]
set tf [open out.tr w]

$ns trace-all $tf
set nf [open out.nam w]
$ns namtrace-all $nf

set n0 [$ns node]

set n1 [$ns node]

set n2 [$ns node]


set n3 [$ns node]


set n4 [$ns node]


set n5 [$ns node]


set n6 [$ns node]



$n0 label "ping0"
$n1 label "ping1"
$n2 label "router"
$n3 label "ping3"
$n4 label "ping4"
$n5 label "ping5"
$n6 label "ping6"

$ns duplex-link $n0 $n2 100Mb 300ms DropTail
$ns duplex-link $n1 $n2 1Mb 300ms DropTail
$ns duplex-link $n3 $n2 1Mb 300ms DropTail
$ns duplex-link $n4 $n2 1Mb 300ms DropTail
$ns duplex-link $n5 $n2 100Mb 300ms DropTail
$ns duplex-link $n6 $n2 1Mb 300ms DropTail

$ns queue-limit $n0 $n2 5
$ns queue-limit $n2 $n6 2
$ns queue-limit $n2 $n4 3
$ns queue-limit $n5 $n2 5

set ping0 [new Agent/Ping]
$ns attach-agent $n0 $ping0

set ping5 [new Agent/Ping]
$ns attach-agent $n5 $ping5

set ping6 [new Agent/Ping]
$ns attach-agent $n6 $ping6


set ping4 [new Agent/Ping]
$ns attach-agent $n4 $ping4

$ns color 1 "red"
$ns color 2 "green" 

$ping0 set packetSize_ 500Mb
$ping5 set packetSize_ 600Mb

$ping0 set interval_ 0.0001
$ping5 set interval_ 0.00001

$ping0 set class_ 1
$ping4 set class_ 1
$ping5 set class_ 2
$ping6 set class_ 2

$ns connect $ping0 $ping4
$ns connect $ping5 $ping6

proc finish {} {
global ns tf nf

$ns flush-trace
close $tf
close $nf

exec nam out.nam &
exit 0
} 

Agent/Ping instproc recv {from rtt} {
$self instvar node_
puts "the node[$node_ id] received a reply from $from with rtt $rtt"

}
proc SendPingPacket {} {

global ns ping0 ping5

set intervalTime 0.001
set now [$ns now]

$ns at [expr $now + $intervalTime] "$ping0 send"
$ns at [expr $now + $intervalTime] "$ping5 send"
$ns at [expr $now + $intervalTime] "SendPingPacket"


}

$ns at 0.01 "SendPingPacket"
$ns at 10.0 "finish"
$ns run






