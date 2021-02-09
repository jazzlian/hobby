SELECT datname                       AS "이름", 
       pg_get_userbyid(datdba)       AS "소유주", 
       pg_encoding_to_char(encoding) AS "인코딩", 
       datcollate                    AS "lc_collate", 
       datctype                      AS "lc_ctype", 
       datistemplate                 AS "템플릿?", 
       datallowconn                  AS "접속허용?", 
       datconnlimit                  AS "접속제한수", 
       datlastsysoid                 AS "마지막OID", 
       age(datfrozenxid)   AS "나이", 
       datminmxid, 
       t.spcname                     AS "테이블스페이스" 
FROM   pg_database 
       JOIN pg_tablespace t 
         ON pg_database.dattablespace = t.oid 
ORDER  BY 1