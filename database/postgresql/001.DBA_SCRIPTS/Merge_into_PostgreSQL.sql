---------------------------
--PostgreSQL Merge into
---------------------------

insert into member_staging ( member_id,first_name,last_name, rank )
select  member_id,first_name,last_name, rank from members
    on CONFLICT (member_id)
    do update set FIRST_name = excluded.FIRST_name, last_name = excluded.last_name, rank = excluded.rank
    ;


