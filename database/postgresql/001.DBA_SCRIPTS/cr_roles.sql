--
-- cr_roles
-- create roles

create role developer
with login encrypted password 'hjin1234' 
in role pg_monitor
;