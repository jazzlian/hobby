SELECT conname                             AS "변환규칙", 
       regnamespaceout(connamespace)       AS "스키마", 
       pg_get_userbyid(conowner)           AS "소유주", 
       pg_encoding_to_char(conforencoding) AS "원래인코딩", 
       pg_encoding_to_char(contoencoding)  AS "대상인코딩", 
       conproc                             AS "함수", 
       condefault                          AS "기본값" 
FROM   pg_conversion 
ORDER  BY 1; 