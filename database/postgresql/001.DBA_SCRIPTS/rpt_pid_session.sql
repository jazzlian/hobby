--
-- rpt_pid_session.sql
-- session pid list 

\echo ''
\prompt 'Input Process PID List : ' v_pids
\echo ''

\x

select datname,
       pid,
       pg_blocking_pids(pid) as blocking_pid,
       concat('pg_terminate_backend(', pid, ');') as terminate,
       usename,
       application_name,
       client_addr,
       client_hostname,
       client_port,
       backend_start,
       xact_start,
       query_start,
       state_change,
       case
           when wait_event is not null then
               concat(wait_event_type, ' : ', wait_event)
           end               as wait,
       state,
       query
from pg_stat_activity
where true
  and pid in (:v_pids)
;

\x
