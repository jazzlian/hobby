--
-- cr_user
-- create user

\echo ''
\prompt 'Input User Name : ' v_usename
\prompt 'Input password  : ' v_password
\echo ''

create user :v_usename
with login encrypted password :'v_password' 
;
