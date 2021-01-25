--
-- rpt_hba_rules.sql
--
\echo ''
\prompt 'Input Client Address IP : ' v_address
\echo ''


select *
from pg_catalog.pg_hba_file_rules
where :'v_address' is null 
union all
select *
from pg_catalog.pg_hba_file_rules
where :'v_address' is not null 
and address ilike concat(:'v_address', '%')
;