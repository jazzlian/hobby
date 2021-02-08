

select
    proname,
    (aclexplode(proacl)).grantor::regrole AS "부여자",
    (aclexplode(proacl)).grantee::regrole AS "수여자",
    (aclexplode(proacl)).privilege_type   AS "권한",
    (aclexplode(proacl)).is_grantable     AS "상속여부"
from
    pg_proc
;