SELECT Coalesce(b.datname, '-') AS 데이터베이스,
       setrole::regrole         AS 롤,
       Unnest(setconfig)        AS 설정
FROM   pg_db_role_setting a
       left join pg_database b
              ON a.setdatabase = b.oid 