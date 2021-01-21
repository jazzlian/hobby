--
-- rpt_sess_count
-- session count

select usename,
       state,
       count(*)
from pg_catalog.pg_stat_activity
where backend_type = 'client backend'
group by usename, rollup (state)
order by usename, state
;