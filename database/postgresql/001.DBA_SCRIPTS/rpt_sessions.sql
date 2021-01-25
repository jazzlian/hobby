--
-- rpt_session.sql
-- session list 

\echo ''
\prompt 'Input Database Name (all input ''%''): ' v_datname
\prompt 'Input User Name (all input ''%''): ' v_usename
\prompt 'Input Session State (all input ''%''): ' v_state
\echo ''

select datname,
       pid,
       pg_blocking_pids(pid) as blocking_pid,
       usename,
       application_name,
       client_addr,
       client_hostname,
       client_port,
       backend_start,
       current_timestamp - backend_start as duration_time,
       xact_start,
       query_start,
       GREATEST((CURRENT_TIMESTAMP - xact_start), (current_timestamp - query_start)) as query_elaps_time,
       state_change,
       case
           when wait_event is not null then
               concat(wait_event_type, ' : ', wait_event)
           end               as wait,
       state,
       substr(query, 1, 1024) as query
from pg_stat_activity
where true
  and pid != pg_backend_pid()
  and backend_type = 'client backend'
  and datname ilike concat(:'v_datname', '%')
  and usename ilike concat(:'v_usename', '%')
  and state ilike concat(:'v_state', '%')
;


