CREATE OR REPLACE PROCEDURE dbp_macro.m_upsert_ncs_log (STATUS_2 FLOAT, SERVICE_NAME VARCHAR(300))
   RETURNS STRING
   LANGUAGE JAVASCRIPT
   EXECUTE AS OWNER
   AS
   $$
 	var sql_stmt = `MERGE INTO dbp_msi_data.ncs_log_2 target
                  USING (SELECT ? AS SERVICE_NAME, ? AS STATUS_2) source
                     ON target.service_name = source.SERVICE_NAME
                     AND target.date_start = CURRENT_DATE 
                  WHEN MATCHED THEN 
                     UPDATE SET 
                        target.service_id = CURRENT_USER, 
                        target.time_start = CURRENT_TIME, 
                        target.date_end = '9999-12-31', 
                        target.time_end = '99:99:99', 
                        target.status_2 = source.STATUS_2
                  WHEN NOT MATCHED THEN 
                     INSERT (DATE_START
                            ,SERVICE_ID
                            ,TIME_START
                            ,DATE_END
                            ,TIME_END
                            ,STATUS_2
                            ,SERVICE_NAME)
                     VALUES (CURRENT_DATE
                           , CURRENT_USER
                           , CURRENT_TIME
                           , '9999-12-31'
                           , '99:99:99'
                           , source.STATUS_2
                           , source.SERVICE_NAME)`;
snowflake.createStatement({
   sqlText : sql_stmt,
   binds : [SERVICE_NAME,STATUS_2]
}).execute();
 
var sql_commit = `COMMIT;`
   snowflake.createStatement({
	   sqlText : sql_commit
	}).execute();

$$;

