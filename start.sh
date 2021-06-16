#!/bin/sh
PATH=$PATH:/usr/bin:/usr/sbin:/bin:/sbin

perl bin/automation_version3_1.pl
echo "complete\n"
perl bin/automation_version3_2.pl
echo "complete\n"
perl bin/automation_version3_3.pl
echo "complete\n"
