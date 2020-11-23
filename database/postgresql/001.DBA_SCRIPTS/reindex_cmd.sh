#!/usr/bin/bash

#
# 아래의 환경 변수는 해당 시스템에 맞게 수정 하세요
#

# User specific aliases and functions
export PGHOME=/opt/PostgreSQL/9.6
export PGHOST=/tmp
export PGPORT=5434
export PGUSER=postgres
export PGPASSWORD=rockplace
export PGDATA=$PGHOME/data
export PGDATABASE=demo
#
export PATH=$PGHOME/bin:$PATH
export LD_LIBRARY_PATH=$PGHOME/lib:/lib64:/usr/lib64
#
export PSQL=$PGHOME/bin/psql
#
echo 'Start Index Rebuild Process : ' `date '+%Y-%m-%d %H:%M:%S'`


# 대상 인덱스를 추출
echo '01.REBUILD INDEX LIST: ' `date '+%Y-%m-%d %H:%M:%S'`

$PSQL -t -X << EOF
\o reindex.sql

select 
   'set session work_mem to ''128MB'';' -- 세션의 정렬메모리량 시스템 상황에 맞게 적절히 
union all
select 
   'set session maintenance_work_mem to ''1024MB'';' -- 세션의 인덱스 생성시 사용하는 메모리량 시스템 상황에 맞게 적절히 
union all
select 
 	concat('reindex(verbose) index ', dd.schname, '.', dd.indname, '; -- index size is ', pg_size_pretty(inssize)) as cmd
from 
(
select
    idxs.schemaname as schname, 
	cls.relname as indname,
	pg_indexes_size(ind.indrelid) as inssize
from
	pg_catalog.pg_class cls
inner join pg_catalog.pg_index ind on
	ind.indexrelid = cls.oid
inner join pg_catalog.pg_indexes idxs on
	idxs.indexname = cls.relname
	and idxs.schemaname = 'bookings' -- 원하는 스티마를 지정 
order by 1, 2
) dd
where dd.inssize > 8 * 1024 * 1024 -- MB 단위로 설정(8MB 이상인거)
;

\q

EOF

# 추출한 인덱스 리빌드 
echo '02.REINDEX : ' `date '+%Y-%m-%d %H:%M:%S'`
$PSQL -X << EOF

begin TRANSACTION;

\i reindex.sql  -- 테스트 할때는 이부분을 주석 처리 하고 reindex.sql 에 대상이 제대로 나왔는지 확인 

commit;

\q
EOF

echo 'End Time : ' `date '+%Y-%m-%d %H:%M:%S'`
