--
-- cr_roles
-- create roles

\echo ''
\prompt 'Input Role Name : ' v_rolname
\echo ''

create role :v_rolname
with nologin
;