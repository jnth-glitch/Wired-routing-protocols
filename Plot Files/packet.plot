set terminal pdf
set output "packet_comp.pdf"
set title "RIP vs OSPF\nTotal Packets Delivery Percentage in Ring and Mesh Topologies"
set ylabel "Packet Ddelivery Percentage"
set style data histogram
set style fill solid
set style histogram clustered
plot 'pdr.data' using 2:xtic(1) title "RIP", '' using 3 title "OSPF"
