--
-- rpt_serv_session.sql
-- server process list

select 
    pid,
    usename,
    backend_start,
    concat(wait_event_type, ' : ', wait_event) as wait,
    substr(query, 1, 255) as query
from pg_stat_activity
where true
  and backend_type != 'client backend'
;