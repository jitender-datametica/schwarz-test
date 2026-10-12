CREATE OR REPLACE PROCEDURE P_LEW_PROCESS_MSTR.CHECK_THREADS_SF()
RETURNS VARCHAR(16777216)
LANGUAGE JAVASCRIPT
EXECUTE AS OWNER
AS '
var LOOP_END = 1;
var LOOP_ROW= 0
var stmnt = `SELECT
CASE 
    WHEN NVL(row_cnt_to_be,-1) = NVL(row_cnt_asis,-2) 
    THEN 1 
    ELSE 0  
END FINISHED_FG0
, CASE WHEN MIN_REQ =-99 THEN FINISHED_FG0 ELSE 1 END FINISHED_FG
, NVL(row_cnt_to_be,-1)
, NVL(row_cnt_asis,-2) 
FROM (SELECT MAX(status_id) as row_cnt_to_be 
      FROM p_lew_process_mstr.t_saule_config_requests_2 
      WHERE req_id =-99 ) a 
CROSS JOIN (SELECT COUNT(1) row_cnt_asis 
            FROM p_lew_process_mstr.t_itemfam_pillar_mainpillar_transaction_2) b            
CROSS JOIN (SELECT MIN(REQ_ID) MIN_REQ FROM p_lew_process_mstr.t_saule_config_requests_2 WHERE REQ_ID = -99)
;`
while (LOOP_ROW<LOOP_END) {
var rs_2 = snowflake.createStatement({sqlText : stmnt}).execute();
rs.next();
var rs1 = rs.getColumnValue("FINISHED_FG");
stmnt1=`CALL SYSTEM$WAIT(15)`
var exec_sql = snowflake.createStatement({sqlText : stmnt1}).execute();
var LOOP_ROW= rs1
}
var stmnt2 = ''CALL P_LEW_PROCESS_MSTR.M_FILL_SAULE_REQUEST_SF();''
  var rs_2 = snowflake.createStatement({
	   sqlText : stmnt2
	}).execute();
';



