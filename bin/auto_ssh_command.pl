#!/usr/bin/perl

use Expect;
use warnings;
use strict;
my %server_data = (
                "$ip" => {id=>'$user',pass=>'$password',port=>'22'}
);

foreach my $ip (sort keys %server_data){
        printf "IP:%16s ID: %10s PW:%16s SSH\n", $ip,$server_data{$ip}->{id},$server_data{$ip}->{pass};
        ## ssh port 22 -> bash 22 error occur
        #my $conn = "ssh -o StrictHostKeyChecking=no ".$server_data{$ip}->{id}."@".$ip." ".$server_data{$ip}->{port};
        my $conn = "ssh -o StrictHostKeyChecking=no ".$server_data{$ip}->{id}."@".$ip;
        print $conn;
        my $passwd = $server_data{$ip}->{pass};
        my $file_name = "/root/perl_script/log/".$server_data{$ip}->{id}."_ssh_command_".$ip;
        my $timeout=100;
        my $exp=Expect->spawn("$conn");
        $exp->log_file("$file_name","w");

        $exp->expect($timeout,
                [qr'.*?password:', sub{
                                my $lexp = shift;
                                $lexp->send("$passwd\n");
                                printf "password change : $passwd\n";
                                exp_continue;
                        }],
                [qr'.*?]#', sub{
                                my $lexp= shift;
                                $lexp->send("./sftp_send.sh\n");
                                $lexp->send("exit\n");
                                exp_continue;
                        }],
                [timeout => \&timeouterr_ssh]);

        sub timeouterr_ssh
        {
                die "Login Time out\n";
        }

}
