#
# https://teamsmiley.github.io/2020/11/09/proxysql/ 에서 발취
#
-- server add
INSERT INTO mysql_servers(hostgroup_id,hostname,port, weight) VALUES (10,'10.65.50.246',3306, 99);
INSERT INTO mysql_servers(hostgroup_id,hostname,port, weight) VALUES (10,'10.65.50.247',3306, 1);

INSERT INTO mysql_servers(hostgroup_id,hostname,port, weight) VALUES (20,'10.65.50.246',3306, 1);
INSERT INTO mysql_servers(hostgroup_id,hostname,port, weight) VALUES (20,'10.65.50.247',3306, 99);

load mysql servers to runtime;
save mysql servers to disk;

-- connection setting

UPDATE global_variables SET variable_value='root' WHERE variable_name='mysql-monitor_username';
UPDATE global_variables SET variable_value='audtlr2' WHERE variable_name='mysql-monitor_password';

-- 주기적으로 확인하는것을 2초로 함.
UPDATE global_variables SET variable_value='2000' WHERE variable_name IN ('mysql-monitor_connect_interval','mysql-monitor_ping_interval','mysql-monitor_read_only_interval');

-- 관련 옵션들을 다 확인하자.
SELECT * FROM global_variables WHERE variable_name LIKE 'mysql-monitor_%';

LOAD MYSQL VARIABLES TO RUNTIME;
SAVE MYSQL VARIABLES TO DISK;


-- connect check
SHOW TABLES FROM monitor;

SELECT * FROM monitor.mysql_server_connect_log ORDER BY time_start_us DESC LIMIT 10;
SELECT * FROM monitor.mysql_server_ping_log ORDER BY time_start_us DESC LIMIT 10;

LOAD MYSQL SERVERS TO RUNTIME;
SAVE MYSQL SERVERS TO DISK;


-- work user add


INSERT INTO mysql_users(username,password,default_hostgroup) VALUES ('root','audtlr2',10); -- r/w user
INSERT INTO mysql_users(username,password,default_hostgroup) VALUES ('readonly','readonly',20); -- r/o user

SELECT * FROM mysql_users;        

LOAD MYSQL USERS TO RUNTIME;
SAVE MYSQL USERS TO DISK;

-- check connect
mysql -u root -ppassword -h 127.0.0.1 -P6033 -e "SELECT 1"; -- 포트번호 주의
mysql -u root -ppassword -h 127.0.0.1 -P6033 -e "SELECT @@hostname";

--r/w port 구분 으로

SET mysql-interfaces='0.0.0.0:6401;0.0.0.0:6402';
## save it on disk and restart proxysql
SAVE MYSQL VARIABLES TO DISK;
PROXYSQL RESTART;

select * from mysql_query_rules;

INSERT INTO mysql_query_rules (rule_id,active,proxy_port,destination_hostgroup,apply)
VALUES (1,1,6401,10,1), (2,1,6402,20,1);

LOAD MYSQL QUERY RULES TO RUNTIME;
SAVE MYSQL QUERY RULES TO DISK;

-- r/w pattern 구분으로

DELETE FROM mysql_query_rules;
UPDATE mysql_users SET default_hostgroup=10; # by default, all goes to HG10

LOAD MYSQL USERS TO RUNTIME;
SAVE MYSQL USERS TO DISK; # if you want this change to be permanent

INSERT INTO mysql_query_rules (rule_id,active,match_digest,destination_hostgroup,apply)
VALUES
  (1,1,'^SELECT.*FOR UPDATE$',10,1),
  (2,1,'^SELECT',20,1);

LOAD MYSQL QUERY RULES TO RUNTIME;
SAVE MYSQL QUERY RULES TO DISK; #


-- query digest 로 

-- Find the top 5 queries based on total execution time:
SELECT digest,SUBSTR(digest_text,0,25),count_star,sum_time FROM stats_mysql_query_digest WHERE digest_text LIKE 'SELECT%' ORDER BY sum_time DESC LIMIT 5;

-- Find the top 5 queries based on count:
SELECT digest,SUBSTR(digest_text,0,25),count_star,sum_time FROM stats_mysql_query_digest WHERE digest_text LIKE 'SELECT%' ORDER BY count_star DESC LIMIT 5;

-- Find the top 5 queries based on maximum execution time:
SELECT digest,SUBSTR(digest_text,0,25),count_star,sum_time,sum_time/count_star avg_time, min_time, max_time FROM stats_mysql_query_digest WHERE digest_text LIKE 'SELECT%' ORDER BY max_time DESC LIMIT 5;

-- Find the top 5 queries ordered by total execution time, and with a minimum execution time of at least 1 millisecond:
SELECT digest,SUBSTR(digest_text,0,20),count_star,sum_time,sum_time/count_star avg_time, min_time, max_time FROM stats_mysql_query_digest WHERE digest_text LIKE 'SELECT%' AND min_time > 1000 ORDER BY sum_time DESC LIMIT 5;

-- Find the top 5 queries ordered by total execution time, with an average execution time of at least 1 second. Also show the percentage of the total execution time
SELECT digest,SUBSTR(digest_text,0,25),count_star,sum_time,sum_time/count_star avg_time, ROUND(sum_time*100.00/(SELECT SUM(sum_time) FROM stats_mysql_query_digest),3) pct FROM stats_mysql_query_digest WHERE digest_text LIKE 'SELECT%' AND sum_time/count_star > 1000000 ORDER BY sum_time DESC LIMIT 5;

-- Find the top 5 queries ordered by total execution time, with an average execution time of at least 15 milliseconds. Also show the percentage of the total execution time:
SELECT digest,SUBSTR(digest_text,0,25),count_star,sum_time,sum_time/count_star avg_time, ROUND(sum_time*100.00/(SELECT SUM(sum_time) FROM stats_mysql_query_digest WHERE digest_text LIKE 'SELECT%'),3) pct FROM stats_mysql_query_digest WHERE digest_text LIKE 'SELECT%' AND sum_time/count_star > 15000 ORDER BY sum_time DESC LIMIT 5;


INSERT INTO mysql_query_rules (rule_id,active,digest,destination_hostgroup,apply)
VALUES
(1,1,'0x38BE36BDFFDBE638',20,1);

-- select count는 20번 그룹으로 

SELECT digest,digest_text,count_star,sum_time,sum_time/count_star avg_time, ROUND(sum_time*100.00/(SELECT SUM(sum_time) FROM stats_mysql_query_digest WHERE digest_text LIKE 'SELECT%'),3) pct FROM stats_mysql_query_digest WHERE digest_text LIKE 'SELECT COUNT%' ORDER BY sum_time DESC;

INSERT INTO mysql_query_rules (rule_id,active,match_digest,destination_hostgroup,apply)
VALUES
(1,1,'^SELECT COUNT\(\*\)',20,1);

LOAD MYSQL QUERY RULES TO RUNTIME;

SAVE MYSQL QUERY RULES TO DISK;


-- conf 저장

SAVE CONFIG TO FILE  /tmp/backup.cfg
SELECT CONFIG FILE #/etc/proxysql.cnf 을 보여줌

mysql -padmin -uadmin -h127.0.0.1 -P6032 -e 'select config file' #/etc/proxysql.cnf 을 보여줌