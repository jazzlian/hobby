SELECT collname                          AS "규칙이름", 
       regnamespaceout(collnamespace)    AS "스키마", 
       pg_get_userbyid(collowner)        AS "소유주", 
       CASE 
         WHEN collprovider = 'd' THEN '기본' 
         WHEN collprovider = 'c' THEN 'libc' 
         ELSE 'icu' 
       END                               AS "제공자", 
       pg_encoding_to_char(collencoding) AS "인코딩", 
       collcollate                       AS lc_collate, 
       collctype                         AS lc_ctype, 
       collversion                       AS "버전" 
FROM   pg_collation 
ORDER  BY 1