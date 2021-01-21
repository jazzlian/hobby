
--
-- rpt_tablespaces
-- show Tablespace

\echo ''
\prompt 'Input Tablespace Name : ' v_tbcname
\echo ''


SELECT spcname AS "Name",
  pg_catalog.pg_get_userbyid(spcowner) AS "Owner",
  pg_catalog.pg_tablespace_location(oid) AS "Location",
  pg_catalog.array_to_string(spcacl, E'\n') AS "Access privileges",
  spcoptions AS "Options",
  pg_catalog.pg_size_pretty(pg_catalog.pg_tablespace_size(oid)) AS "Size",
  pg_catalog.shobj_description(oid, 'pg_tablespace') AS "Description"
FROM pg_catalog.pg_tablespace
where :'v_tbcname' is null
union all
SELECT spcname AS "Name",
  pg_catalog.pg_get_userbyid(spcowner) AS "Owner",
  pg_catalog.pg_tablespace_location(oid) AS "Location",
  pg_catalog.array_to_string(spcacl, E'\n') AS "Access privileges",
  spcoptions AS "Options",
  pg_catalog.pg_size_pretty(pg_catalog.pg_tablespace_size(oid)) AS "Size",
  pg_catalog.shobj_description(oid, 'pg_tablespace') AS "Description"
FROM pg_catalog.pg_tablespace
where :'v_tbcname' is not null
and  spcname ilike concat(:'v_tbcname', '%')
order by 1