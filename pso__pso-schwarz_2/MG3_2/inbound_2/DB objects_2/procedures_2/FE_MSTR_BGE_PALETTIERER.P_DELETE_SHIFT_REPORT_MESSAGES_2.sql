CREATE OR REPLACE PROCEDURE FE_MSTR_BGE_PALETTIERER.P_DELETE_SHIFT_REPORT_MESSAGES (ALERTS_DAY_SHIFT_ID FLOAT)
RETURNS STRING
LANGUAGE JAVASCRIPT
EXECUTE AS OWNER
AS $$
    var sql_command = "DELETE FROM CORE.T_FACT_ALERTS_SHIFT_REPORT_PER_SHIFT_2 WHERE ALERTS_DAY_SHIFT_ID = :1";
    
    snowflake.execute({sqlText: sql_command,
	binds: [ALERTS_DAY_SHIFT_ID]});
	
	var sql_commit = "COMMIT";
    snowflake.createStatement({
       sqlText : sql_commit
    }).execute();
$$
;