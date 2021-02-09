SELECT oid,
       defaclrole::regrole           AS "해당롤",
       defaclnamespace::regnamespace AS "해당스키마",
       CASE
              WHEN defaclobjtype = 'r' THEN '릴레이션'
              WHEN defaclobjtype = 'S' THEN '시퀀스'
              WHEN defaclobjtype = 'f' THEN '함수'
              WHEN defaclobjtype = 'T' THEN '자료형'
              WHEN defaclobjtype = 'n' THEN '스키마'
       END                                      AS "대상종류",
       (aclexplode(defaclacl)).grantor::regrole AS "부여자",
       (aclexplode(defaclacl)).grantee::regrole AS "수여자",
       (aclexplode(defaclacl)).privilege_type   AS "권한",
       (aclexplode(defaclacl)).is_grantable     AS "상속여부"
FROM   pg_default_acl