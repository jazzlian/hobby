--
-- create tablespace
--

\echo ''
\prompt 'Input Tablespace Name : ' v_tbcname
\echo ''


create tablespace :v_tbcname
owner {username | current_user | session_user}
location '/data/'

