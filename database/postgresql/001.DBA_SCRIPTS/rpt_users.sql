--
-- rpt_users
-- 
\echo ''
\prompt 'Input User Name : ' v_usename
\echo ''

select  
    usename, 
    usesysid, 
    usecreatedb, 
    usesuper, 
    userepl, 
    usebypassrls,
    passwd,
    valuntil,
    useconfig
from pg_catalog.pg_user
where :'v_usename' is null
union all
select  
    usename, 
    usesysid, 
    usecreatedb, 
    usesuper, 
    userepl, 
    usebypassrls,
    passwd,
    valuntil,
    useconfig
from pg_catalog.pg_user
where :'v_usename' is not NULL
and usename ilike concat(:'v_usename', '%')
;