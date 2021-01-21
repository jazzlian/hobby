
\x

select * from 
(
select
    userid,
    dbid,
    queryid,
    md5(query) as md5_query_id, 
    substr(query, 1, 255) as query,
    calls,
    total_time,
    min_time,
    max_time,
    mean_time,
    stddev_time,
    (rows / calls)::NUMERIC as rows_per_calls,
    (shared_blks_hit / calls)::NUMERIC as shared_blks_hit_per_calls,
    (shared_blks_read / calls)::NUMERIC as shared_blks_read_per_calls,
    (shared_blks_dirtied / calls)::NUMERIC as shared_blks_dirtied_per_calls,
    (shared_blks_written / calls)::NUMERIC as shared_blks_written_per_calls,
    (local_blks_hit / calls)::NUMERIC as local_blks_hit_per_calls,
    (local_blks_read / calls)::NUMERIC as local_blks_read_per_calls,
    (local_blks_dirtied / calls)::NUMERIC as local_blks_dirtied_per_calls,
    (local_blks_written / calls)::NUMERIC as local_blks_written_per_calls,
    (temp_blks_read / calls)::NUMERIC as temp_blks_read_per_calls,
    (temp_blks_written / calls)::NUMERIC as temp_blks_written_per_calls,
    (blk_read_time / calls)::NUMERIC as blk_read_time_per_calls,
    (blk_write_time / calls)::NUMERIC as blk_write_time_per_calls,
    rows,
    shared_blks_hit,
    shared_blks_read,
    shared_blks_dirtied,
    shared_blks_written,
    local_blks_hit,
    local_blks_read,
    local_blks_dirtied,
    local_blks_written,
    temp_blks_read,
    temp_blks_written,
    blk_read_time,
    blk_write_time 
from 
    pg_stat_statements
) AA
order by AA.mean_time desc
;

\x