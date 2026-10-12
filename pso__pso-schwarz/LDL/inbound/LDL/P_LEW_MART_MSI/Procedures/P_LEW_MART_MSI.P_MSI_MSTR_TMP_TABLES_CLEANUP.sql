/*
#----------------------------------------------------------------------------
# © LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# History:
# NR  | DATE       | 1st AND 2nd NAME | DESCRIPTION OF CHANGES
#
# 1.1   16-01-2024   Aleksander Bialek   Initial Version of procedure cleaning up leftover MSTR created tables in P_LEW_MSI_TEMP (AD WI:568244)
# 1.2   19-01-2024	 Aleksander Bialek   Additional condition added to asure that only P_LEW_MSI_TEMP is being cleaned (show tables include also public schema objects)
# 1.3   11-09-2025	 Aleksander Bialek   Additional condition added to asure that EK_Security related tables are not being dropped (AD WI:
#                                       
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE PROCEDURE P_LEW_MART_MSI.P_MSI_MSTR_TMP_TABLES_CLEANUP()
RETURNS VARCHAR(16777216)
LANGUAGE JAVASCRIPT
EXECUTE AS CALLER
AS '
var stmnt = `USE SCHEMA P_LEW_MSI_TEMP;`
snowflake.createStatement({sqlText : stmnt}).execute();

var stmnt = `COMMIT;`
snowflake.createStatement({sqlText : stmnt}).execute();

var stmnt = `SHOW TABLES LIMIT 2000;`
snowflake.createStatement({sqlText : stmnt}).execute();

var stmnt = `CREATE OR REPLACE TEMPORARY TABLE P_LEW_MSI_TEMP.t_tmp_cleanup_syntax
AS
SELECT ''DROP TABLE ''||schema_name||''.''||name||'';'' syntax
, TIMESTAMPDIFF( ''hour'' , created_on , current_timestamp() ) AS HOURS_SINCE_CREATION
FROM table(result_scan(last_query_id()))
WHERE  HOURS_SINCE_CREATION > 2
AND schema_name =''P_LEW_MSI_TEMP''
AND name NOT ILIKE ''T_SEC_EKWA_NRV_EK%''
GROUP BY 1,2 ORDER BY HOURS_SINCE_CREATION DESC;`
snowflake.createStatement({sqlText : stmnt}).execute();

var stmnt = `COMMIT;`
snowflake.createStatement({sqlText : stmnt}).execute();

var stmnt0 = `select COALESCE(COUNT(1),0) V_LOOP from P_LEW_MSI_TEMP.t_tmp_cleanup_syntax;`
var rs0 = snowflake.createStatement({sqlText : stmnt0}).execute();
rs0.next();
var LOOP_END = rs0.getColumnValue(1);
var LOOP_ROW= 0
var stmnt = `select syntax from P_LEW_MSI_TEMP.t_tmp_cleanup_syntax;`
var rs = snowflake.createStatement({sqlText : stmnt}).execute();
while (LOOP_ROW<LOOP_END) {
rs.next();
try {
stmnt1 = rs.getColumnValue(1);
var exec = snowflake.createStatement({sqlText : stmnt1}).execute();
var stmnt = `COMMIT;`
snowflake.createStatement({sqlText : stmnt}).execute();
var LOOP_ROW= LOOP_ROW+1
}
catch(err) {
var LOOP_ROW= LOOP_ROW+1
} }
';