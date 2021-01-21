--
-- rpt_databases.sql
--
\echo ''
\prompt 'Input Database Name : ' v_datname
\echo ''

SELECT d.datname as "Name",
       pg_catalog.pg_get_userbyid(d.datdba) as "Owner",
       pg_catalog.pg_encoding_to_char(d.encoding) as "Encoding",
       d.datcollate as "Collate",
       d.datctype as "Ctype",
       age(d.datfrozenxid) as "Age",
       pg_size_pretty(pg_database_size(d.oid)) as "Size",
       t.spcname as "Tblspc", 
       pg_catalog.array_to_string(d.datacl, E'\n') AS "Access privileges",
       s.temp_files,
       s.temp_bytes,
       s.stats_reset
FROM pg_catalog.pg_database d inner join pg_tablespace t on t.oid = d.dattablespace
                              inner join pg_stat_database s on s.datid = d.oid
where :'v_datname' is null
union all
SELECT d.datname as "Name",
       pg_catalog.pg_get_userbyid(d.datdba) as "Owner",
       pg_catalog.pg_encoding_to_char(d.encoding) as "Encoding",
       d.datcollate as "Collate",
       d.datctype as "Ctype",
       age(d.datfrozenxid) as "Age",
       pg_size_pretty(pg_database_size(d.oid)) as "Size",
       t.spcname as "Tblspc", 
       pg_catalog.array_to_string(d.datacl, E'\n') AS "Access privileges",
       s.temp_files,
       s.temp_bytes,
       s.stats_reset
FROM pg_catalog.pg_database d inner join pg_tablespace t on t.oid = d.dattablespace
                              inner join pg_stat_database s on s.datid = d.oid
where :'v_datname' is not null
and d.datname ilike concat(:'v_datname', '%')
;