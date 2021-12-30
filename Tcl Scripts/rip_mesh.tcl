set ns [new Simulator]
#====================================================================================
#			SETTING TRACE,NAM,XGRAPH FILES
#====================================================================================
set nf [open ripmesh_nam.nam w]
set tr [open ripmesh_trace.tr w]
$ns namtrace-all $nf
$ns trace-all $tr

$ns color 1 purple

#====================================================================================
#			CREATION OF NODES AND LINKS 
#====================================================================================
for {set i 0} {$i < 10} {incr i} {
set n($i) [$ns node]
}
for {set i 1 } {$i < 8} {incr i} {
$ns duplex-link $n($i) $n([expr ($i+1)%9]) 1Mb 10ms DropTail
}

$ns duplex-link $n(9) $n(5) 1Mb 10ms DropTail
$ns duplex-link $n(0) $n(1) 1Mb 10ms DropTail
$ns duplex-link $n(8) $n(1) 1Mb 10ms DropTail
$ns duplex-link $n(2) $n(8) 1Mb 10ms DropTail
$ns duplex-link $n(2) $n(7) 1Mb 10ms DropTail
$ns duplex-link $n(3) $n(6) 1Mb 10ms DropTail
$ns duplex-link $n(1) $n(4) 1Mb 10ms DropTail
$ns duplex-link $n(4) $n(7) 1Mb 10ms DropTail
$ns duplex-link $n(8) $n(5) 1Mb 10ms DropTail

#====================================================================================
#			CREATING AND ATTACHING AGENTS
#====================================================================================
set udp5 [new Agent/UDP]
set null0 [new Agent/Null]
set cbr5 [new Application/Traffic/CBR]

$ns attach-agent $n(9) $udp5
$ns attach-agent $n(0) $null0

$cbr5 attach-agent $udp5
$ns connect $udp5 $null0
$udp5 set fid_ 1
#====================================================================================
#				ALTERING LINKS 
#====================================================================================
	
$ns rtmodel-at 1.0 down $n(1) $n(4) 
$ns rtmodel-at 1.7 up $n(1) $n(4)	
$ns rtmodel-at 1.5 down $n(8) $n(5)
$ns rtmodel-at 1.8 up $n(8) $n(5)
$ns rtmodel-at 2.5 down $n(1) $n(4)
$ns rtmodel-at 2.8 up $n(1) $n(4)

#====================================================================================
#				FINISH PROCEDURE
#====================================================================================
proc finish {} {
global ns nf tr
$ns flush-trace
close $nf
close $tr
exec nam ripmesh_nam.nam &
exit 0 }

$ns rtproto DV		
$ns at 0.5 "$cbr5 start"
$ns at 4 "finish"
$ns run
