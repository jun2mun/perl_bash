#!/usr/bin/perl

use Expect;
use warnings;
use strict;

my %server_data = (
        "$ip" => {id=>'$user',pass=>'$password',port=>'22'}
);


foreach my $ip (sort keys %server_data){
        printf "IP:%16s ID: %10s PW:%16s PORT:%16s sftp\n", $ip,$server_data{$ip}->{id},$server_data{$ip}->{pass},$server_data{$ip}->{port};
        my $conn_sftp = "sftp -P ".$server_data{$ip}->{port}." -o StrictHostKeyChecking=no ".$server_data{$ip}->{id}."@".$ip;
        my $passwd = $server_data{$ip}->{pass};
        my $file_name = "/root/perl_script/log/".$server_data{$ip}->{id}."_sftp_upload_".$ip."sftp";
        my $timeout=100;
        my $exp=Expect->spawn("$conn_sftp");
        $exp->log_file("$file_name","w");
        print "first $passwd\n";
        $exp->expect($timeout,
                [qr'.*?password:', sub{
                                my $lexp = shift;
                                $lexp->send("$passwd\n");
                                printf "password change : $passwd\n";
                                exp_continue;
                        }],
                [qr'sftp>', sub{
                                my $lexp= shift;
                                $lexp->send("put /root/perl_script/sftp_send.sh\n");
                                $lexp->send("exit\n");
                                exp_continue;
                        }],
                [timeout => \&timeouterr]);

        sub timeouterr
        {
                die "Login Time out\n";
        }

}
