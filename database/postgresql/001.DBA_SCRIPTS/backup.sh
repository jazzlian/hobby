#!/bin/bash

export  PGHOME=/usr/edb/as13
export  PGHOST=localhost
export  PGUSER=enterprisedb
export  PGPORT=5444
export  PGDATABASE=postgres

export  PATH=$PGHOME/bin:$PATH
export  LD_LIBRARY_PATH=$PGHOME/lib:/lib64:/usr/lib64:.

export  PSQLCMD='psql'

input=$1

if [ $input -eq 1 ] 
then
        CMDSQL="select 'BEGIN_BACKUP' as process, to_char(now(), 'YYYY-MM-DD hh24:mi:ss') as today, pg_start_backup('FULL_BACKUP');"
elif [ $input -eq 0 ] 
then
        CMDSQL="select 'END_BACKUP' as process ,to_char(now(), 'YYYY-MM-DD hh24:mi:ss') as today, pg_stop_backup();"
elif [ $input -gt 1 ] 
then
        CMDSQL="select to_char(now(), 'YYYY-MM-DD hh24:mi:ss') as today, pg_is_in_backup();"
fi
             
$PSQLCMD <<EOF
$CMDSQL
EOF