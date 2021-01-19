--
-- rpt_users
-- 
\echo 'Input User Name : ' :v_usename

\set v_usename %1

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