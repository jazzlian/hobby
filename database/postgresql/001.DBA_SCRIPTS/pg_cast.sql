SELECT castsource::regtype AS "기존자료형", 
       casttarget::regtype AS "대상자료형", 
       castfunc::regproc AS "함수", 
       CASE 
         WHEN ca.castcontext = 'a' THEN '대입' 
         WHEN ca.castcontext = 'i' THEN '묵시' 
         ELSE '명시' 
       END        AS "사용상황", 
       CASE 
         WHEN ca.castmethod = 'i' THEN '입출력' 
         WHEN ca.castmethod = 'f' THEN '함수' 
         ELSE '그냥' 
       END        AS "종류" 
FROM   pg_cast ca
ORDER  BY 1 