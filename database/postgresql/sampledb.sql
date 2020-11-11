create user scott  with login ENCRYPTED password 'tiger';


create database scottdb with 
owner = scott
TEMPLATE = template0
ENCODING = 'UTF-8'
LC_COLLATE = 'C'
LC_CTYPE = 'C'
;


psql scottdb scott


START TRANSACTION;

create schema if not exists scott AUTHORIZATION CURRENT_USER;

CREATE TABLE if not exists scott.DEPT
(

    DEPTNO numeric(2) not null CONSTRAINT PK_DEPT PRIMARY KEY,
    DNAME VARCHAR(14) ,
    LOC VARCHAR(13) 
) ;


CREATE TABLE if not exists scott.EMP
(

    EMPNO numeric(4) not null CONSTRAINT PK_EMP PRIMARY KEY,
    ENAME VARCHAR(10),
    JOB VARCHAR(9),
    MGR numeric(4),
    HIREDATE DATE,
    SAL numeric(7,2),
    COMM numeric(7,2),
    DEPTNO numeric(2) CONSTRAINT FK_DEPTNO REFERENCES DEPT
);


INSERT INTO scott.DEPT VALUES 
    (10,'ACCOUNTING','NEW YORK'),
    (20,'RESEARCH','DALLAS'),
    (30,'SALES','CHICAGO'),
    (40,'OPERATIONS','BOSTON');

INSERT INTO scott.EMP VALUES
(7369,'SMITH','CLERK',7902,to_date('17-12-1980','dd-mm-yyyy'),800,NULL,20),
(7499,'ALLEN','SALESMAN',7698,to_date('20-2-1981','dd-mm-yyyy'),1600,300,30),
(7521,'WARD','SALESMAN',7698,to_date('22-2-1981','dd-mm-yyyy'),1250,500,30),
(7566,'JONES','MANAGER',7839,to_date('2-4-1981','dd-mm-yyyy'),2975,NULL,20),
(7654,'MARTIN','SALESMAN',7698,to_date('28-9-1981','dd-mm-yyyy'),1250,1400,30),
(7698,'BLAKE','MANAGER',7839,to_date('1-5-1981','dd-mm-yyyy'),2850,NULL,30),
(7782,'CLARK','MANAGER',7839,to_date('9-6-1981','dd-mm-yyyy'),2450,NULL,10),
(7788,'SCOTT','ANALYST',7566,to_date('13-7-1987','dd-mm-yyyy'),3000,NULL,20),
(7839,'KING','PRESIDENT',NULL,to_date('17-11-1981','dd-mm-yyyy'),5000,NULL,10),
(7844,'TURNER','SALESMAN',7698,to_date('8-9-1981','dd-mm-yyyy'),1500,0,30),
(7876,'ADAMS','CLERK',7788,to_date('13-7-1987', 'dd-mm-yyyy'),1100,NULL,20),
(7900,'JAMES','CLERK',7698,to_date('3-12-1981','dd-mm-yyyy'),950,NULL,30),
(7902,'FORD','ANALYST',7566,to_date('3-12-1981','dd-mm-yyyy'),3000,NULL,20),
(7934,'MILLER','CLERK',7782,to_date('23-1-1982','dd-mm-yyyy'),1300,NULL,10);


CREATE TABLE if not exists scott.BONUS
(

    ENAME VARCHAR(10),
    JOB VARCHAR(9),
    SAL numeric,
    COMM numeric
) ;


CREATE TABLE if not exists scott.SALGRADE
( 
    GRADE numeric not null CONSTRAINT PK_SALGRADE PRIMARY KEY,
    LOSAL numeric,
    HISAL numeric 
);


INSERT INTO scott.SALGRADE VALUES 
    (1,700,1200),
    (2,1201,1400),
    (3,1401,2000),
    (4,2001,3000),
    (5,3001,9999);

COMMIT;


--
-- 통계정보
--

vacuum analyze scott.emp;
vacuum analyze scott.dept;
vacuum analyze scott.BONUS;
vacuum analyze scott.SALGRADE;