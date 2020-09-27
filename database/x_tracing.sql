-- view a log of previous actions. can retrieve SQL_ADDRESS and SQL_ID.
SELECT * FROM V$SESSION;

-- view query history. PARSING_SCHEMA_NAME refers to the user. can find SQL_ID from here.
SELECT * FROM V$SQLAREA WHERE PARSING_SCHEMA_NAME = 'APP_ADMIN' AND SQL_FULLTEXT LIKE '%APP_ADMIN.temp%';

-- view predicates of the queries with certain SQL_ID.
SELECT * FROM V$VPD_POLICY WHERE SQL_ID = '2bjsnmtskw87x';

-- retrieve path of the trace file for the current session
SELECT VALUE FROM V$DIAG_INFO WHERE NAME = 'Default Trace File';

-- get a comprehensive error log

ALTER SESSION SET EVENTS '10053 trace name context forever, level 1';
-- now execute the query with error
ALTER SESSION SET EVENTS '10053 trace name context OFF';

-- SQL> host tail -10 /opt/oracle/diag/rdbms/cs5322/cs5322/trace/cs5322_s000_7344.trc