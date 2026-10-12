CREATE OR REPLACE PROCEDURE DBP_MACRO.M_DELETE_NACHLIEFERUNGPROCESS(REQUEST_ID FLOAT, ACTIVE_FG FLOAT)
RETURNS VARCHAR(16777216)
LANGUAGE JAVASCRIPT
EXECUTE AS OWNER
AS 
'
var sql_stmt = `UPDATE dbp_msi_data.ts_nachlieferung_2 
                SET 
                    active_fg = :2 // active_fg
                WHERE nachlieferung_request_id = :1 // request_id`;

snowflake.createStatement({
   sqlText : sql_stmt,
   binds : [REQUEST_ID, ACTIVE_FG]
}).execute();
 var sql_commit = `COMMIT;`
   snowflake.createStatement({
	   sqlText : sql_commit
	}).execute();
';