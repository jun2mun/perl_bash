#!/bin/sh
PATH=$PATH:/usr/bin:/usr/sbin:/bin:/sbin

perl bin/automation_sftp_upload.pl
echo "complete\n"
perl bin/automation_ssh_command.pl
echo "complete\n"
perl bin/automation_sftp_download.pl
echo "complete\n"
