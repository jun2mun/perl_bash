#!/usr/bin/perl

use Expect;
use warnings;
use strict;

my %server_data = (
                "$ip" => {id=>'$user' pass=>'$password',port=>'22'}
);

foreach my $ip (sort keys %server_data){
        printf "IP:%16s ID: %10s PW:%16s sftp download\n", $ip,$server_data{$ip}->{id},$server_data{$ip}->{pass};
        my $passwd = $server_data{$ip}->{pass};
        my $conn_sftp = "sftp -P ".$server_data{$ip}->{port}." -o StrictHostKeyChecking=no ".$server_data{$ip}->{id}."@".$ip;
        my $file_name = "/root/perl_script/log/".$server_data{$ip}->{id}."_sftp_download_".$ip;
        my $timeout=100;
        my $exp=Expect->spawn("$conn_sftp");
        $exp->log_file("$file_name","w");


        $exp->expect($timeout,
                [qr'.*?password:', sub{
                                my $lexp = shift;
                                $lexp->send("$passwd\n");
                                print $passwd;
                                exp_continue;
                        }],
                [qr'sftp>', sub{
                                my $lexp= shift;
                                $lexp->send("get ./*product_name.txt\n");
                                $lexp->send("exit\n");
                                exp_continue;
                        }],
                [timeout => \&timeouterr_sftp_download]);
        sub inputpassword_sftp_download
        {
                die "Login Time out\n";
        }

}
