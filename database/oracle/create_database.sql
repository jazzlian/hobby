CREATE DATABASE prod
USER SYS IDENTIFIED BY oracle
USER SYSTEM IDENTIFIED BY oracle
CONTROLFILE REUSE
LOGFILE GROUP 1 ('/opt/oracle/app/oradata/prod/redo01a.log'
                ,'/opt/oracle/app/oradata/prod/redo01b.log') SIZE 100M REUSE,
        GROUP 2 ('/opt/oracle/app/oradata/prod/redo02a.log'
                ,'/opt/oracle/app/oradata/prod/redo02b.log') SIZE 100M REUSE
EXTENT MANAGEMENT LOCAL
DATAFILE '/opt/oracle/app/oradata/prod/system01.dbf' SIZE 400M REUSE AUTOEXTEND ON
SYSAUX
DATAFILE '/opt/oracle/app/oradata/prod/sysaux01.dbf' SIZE 200M REUSE AUTOEXTEND ON
DEFAULT TEMPORARY TABLESPACE TEMP
TEMPFILE '/opt/oracle/app/oradata/prod/temp01.dbf' SIZE 100M REUSE AUTOEXTEND ON
UNDO TABLESPACE UNDOTBS1
DATAFILE '/opt/oracle/app/oradata/prod/undotbs01.dbf' SIZE 200M REUSE AUTOEXTEND ON
CHARACTER SET AL32UTF8
NATIONAL CHARACTER SET AL16UTF16;

@?/rdbms/admin/catalog.sql
@?/rdbms/admin/cataproc.sql