define _editor=vim

set term on
HOST echo "set linesize" $(stty -a|head -n1|cut -f7 -d' '|cut -f1 -d';') > .tmp.sql
@.tmp.sql
HOST rm -f .tmp.sql
set pagesize 40

set trimout on
set trimspool on

