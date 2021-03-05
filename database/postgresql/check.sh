#!/usr/bin/bash

export	PGDATA=/var/lib/postgresql/12/main
export	PGUSER=postgres
export	PGDATABASE=postgres

echo '+++++++++++++++++++++++++++++++++++++'
echo 'start : ' `date +'%Y-%m-%d %H:%M:%S'`
echo '+++++++++++++++++++++++++++++++++++++'
echo

echo '##### 01.hostname #####'
hostname
echo

echo '##### 02.kernel version  #####'
uname -a
echo

echo '##### 03.file system  #####'
df -h
echo

echo '##### 04.limit  #####'
echo 'limits.conf'
cat /etc/security/limits.conf 
echo
echo 'ulimit -a'
ulimit -a
echo

echo '##### 05.network  #####'
ip addr
echo
ip route
echo

echo '##### 06.host file  #####'
cat /etc/hosts
echo

echo '##### 07.db process #####'
ps -ef|grep postgres | grep -v grep
echo

echo '##### 08.db version #####'
psql -U postgres -d postgres <<EOF
select version();
EOF
echo

echo '##### 09.db list #####'
psql -U postgres -d postgres <<EOF
\l+
EOF
echo

echo '##### 10.session list #####'
psql -U postgres -d postgres <<EOF
select usename,
       state,
       count(*)
from pg_catalog.pg_stat_activity
where backend_type = 'client backend'
group by usename, rollup (state)
order by usename, state
;
EOF
echo

echo '##### 11.tablespace list #####'
psql -U postgres -d postgres <<EOF
SELECT spcname AS "Name",
  pg_catalog.pg_get_userbyid(spcowner) AS "Owner",
  pg_catalog.pg_tablespace_location(oid) AS "Location",
  pg_catalog.array_to_string(spcacl, E'\n') AS "Access privileges",
  spcoptions AS "Options",
  pg_catalog.pg_size_pretty(pg_catalog.pg_tablespace_size(oid)) AS "Size",
  pg_catalog.shobj_description(oid, 'pg_tablespace') AS "Description"
FROM pg_catalog.pg_tablespace
order by 1
;
EOF
echo

echo '##### 12.lock list #####'
psql -U postgres -d postgres <<EOF
SELECT blocked_locks.pid     AS blocked_pid,
         blocked_activity.usename  AS blocked_user,
         blocking_locks.pid     AS blocking_pid,
         blocking_activity.usename AS blocking_user,
         blocked_activity.query    AS blocked_statement,
         blocking_activity.query   AS current_statement_in_blocking_process,
         blocked_activity.application_name AS blocked_application,
         blocking_activity.application_name AS blocking_application
   FROM  pg_catalog.pg_locks         blocked_locks
    JOIN pg_catalog.pg_stat_activity blocked_activity  ON blocked_activity.pid = blocked_locks.pid
    JOIN pg_catalog.pg_locks         blocking_locks 
        ON blocking_locks.locktype = blocked_locks.locktype
        AND blocking_locks.DATABASE IS NOT DISTINCT FROM blocked_locks.DATABASE
        AND blocking_locks.relation IS NOT DISTINCT FROM blocked_locks.relation
        AND blocking_locks.page IS NOT DISTINCT FROM blocked_locks.page
        AND blocking_locks.tuple IS NOT DISTINCT FROM blocked_locks.tuple
        AND blocking_locks.virtualxid IS NOT DISTINCT FROM blocked_locks.virtualxid
        AND blocking_locks.transactionid IS NOT DISTINCT FROM blocked_locks.transactionid
        AND blocking_locks.classid IS NOT DISTINCT FROM blocked_locks.classid
        AND blocking_locks.objid IS NOT DISTINCT FROM blocked_locks.objid
        AND blocking_locks.objsubid IS NOT DISTINCT FROM blocked_locks.objsubid
        AND blocking_locks.pid != blocked_locks.pid
    JOIN pg_catalog.pg_stat_activity blocking_activity ON blocking_activity.pid = blocking_locks.pid
   WHERE NOT blocked_locks.GRANTED;
EOF
echo

echo '#### 13.pg_hba.conf #####'
cat /etc/postgresql/12/main/pg_hba.conf
echo

echo '#### 14.postgresql.conf ####'
cat /etc/postgresql/12/main/postgresql.conf 
echo

echo '+++++++++++++++++++++++++++++++++++++'
echo 'end : ' `date +'%Y-%m-%d %H:%M:%S'`
echo '+++++++++++++++++++++++++++++++++++++'
echo
