--
-- rpt_schemas
-- 
\echo ''
\prompt 'Input Schema Name : ' v_schname
\echo ''

SELECT n.nspname AS "Name",
  pg_catalog.pg_get_userbyid(n.nspowner) AS "Owner"
FROM pg_catalog.pg_namespace n
WHERE :'v_schname' is null
union all
SELECT n.nspname AS "Name",
  pg_catalog.pg_get_userbyid(n.nspowner) AS "Owner"
FROM pg_catalog.pg_namespace n
WHERE :'v_schname' is not null 
and n.nspname !~ '^pg_' 
AND n.nspname <> 'information_schema'
and n.nspname ilike concat(:'v_schname', '%')