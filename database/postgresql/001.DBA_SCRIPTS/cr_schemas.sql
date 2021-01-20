--
-- cr_schemas
-- create schema

\echo ''
\prompt 'Input Schema Name : ' v_schname
\echo ''

create schema if not exists :v_schname
AUTHORIZATION :v_schname
;