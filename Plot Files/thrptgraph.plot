set terminal pdf
set output "throughput.pdf"
set title "RIP vs OSPF\nAverage Throughputs in Ring and Mesh Topologies"
set ylabel "Average Throughput"
set style data histogram
set style fill solid
set style histogram clustered
plot 'throughput_graph.data' using 2:xtic(1) title "RIP", '' using 3 title "OSPF"
