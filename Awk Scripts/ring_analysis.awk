BEGIN {
highest_packet_id = 0; 
avg=0.0
size = 0
strt_time = 0.5
stop_time = 4.0
udp_receive=0
udp_drop=0
udp_pkt=0

}
{
event = $1
time = $2
node1 = $3
node2 = $4
src = $5; 
pkt_size = $6
flow_id = $8; 
node_1_address = $9; 
node_2_address = $10; 
seq_no = $11; 
packet_id = $12;
if ( packet_id > highest_packet_id ) highest_packet_id = packet_id; 
if ( start_time[packet_id] == 0 ) start_time[packet_id] = time; 
if ( event != "d" ) { 
if ( event == "r" ) { 
end_time[packet_id] = time; 
} 
} 
else { 
end_time[packet_id] = -1; 
}
if(event == "r") {
	if(node2== 0)
	{
	++udp_receive
	stop_time= time
	size+=pkt_size
	}
}
else if(event == "d")
{
	if(node2 == 1 || node2 == 7)
	{
	 ++udp_drop
	}
}
}
END {
for ( packet_id = 0; packet_id <= highest_packet_id; packet_id++ ) { 
 start = start_time[packet_id]; 
 end = end_time[packet_id]; 
 packet_duration = end - start; 
 avg+=packet_duration; 
 }
avg=avg/highest_packet_id; 
printf("\n\n===============================ANALYSIS FOR RING==========================================\n")
printf("\nAverage end to end delay : %f",avg);
printf("\nAverage Throughput of UDP  = %.2f kbps\nStart time1=%.2f\nStop Time=%.2f\n",
(size/(stop_time-strt_time))*(8/1000),strt_time,stop_time)
printf("Total packets received : %d",udp_receive)
printf("\nTotal packets dropped : %d",udp_drop)
printf("\nPacket delivery ratio : %f\n",(udp_receive*100)/(udp_receive+udp_drop))
}