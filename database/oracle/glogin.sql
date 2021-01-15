-- -----------------------------------------------------------------------------------
-- File Name    : https://oracle-base.com/dba/miscellaneous/login.sql
-- Author       : Tim Hall
-- Description  : Resets the SQL*Plus prompt when a new connection is made.
-- Call Syntax  : @login
-- Last Modified: 04/03/2004
-- -----------------------------------------------------------------------------------
define _editor=vi

SET FEEDBACK OFF
SET TERMOUT OFF

COLUMN X NEW_VALUE Y
SELECT LOWER(USER || '@' || SYS_CONTEXT('userenv', 'instance_name')) X FROM dual;
SET SQLPROMPT '&Y> '

ALTER SESSION SET NLS_DATE_FORMAT='YYYY-MM-DD HH24:MI:SS'; 
ALTER SESSION SET NLS_TIMESTAMP_FORMAT='YYYY-MM-DD HH24:MI:SS.FF'; 

SET SERVEROUTPUT OFF
SET TERMOUT ON
SET FEEDBACK ON
SET LINESIZE 100
SET PAGESIZE 999
SET TAB OFF
SET TRIM ON
SET TRIMSPOOL ON
SET TIME ON
SET TIMING ON
SET VERIFY OFF
SET LONG 32000
SET NULL "{null}"

col TABLE_NAME format a30
col COLUMN_NAME format a30
