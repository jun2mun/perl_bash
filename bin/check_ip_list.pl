#!/usr/bin/perl

use Net::Ping;

$p = Net::Ping->new("icmp");
$my_addr='$ip';
$p->bind($my_addr);
@host_array=('$ip','$ip2','$ip3');
foreach $host (@host_array)
{
        print "$host is ";
        if($p->ping($host,2)){
                print "reachable.\n";
                push @ip_list, $host;
        }
        else{
                print "Not reachable.\n"
        }


        print "NOT " unless $p->ping($host, 2);
        print "reachable.\n";
        sleep(1);
}
$p->close();

print "current ip stats: @ip_list[0]\n";
