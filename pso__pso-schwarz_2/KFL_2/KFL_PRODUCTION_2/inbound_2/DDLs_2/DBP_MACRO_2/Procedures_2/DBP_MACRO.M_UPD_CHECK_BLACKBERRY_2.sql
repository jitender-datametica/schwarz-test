CREATE OR REPLACE PROCEDURE dbp_macro.m_upd_check_blackberry (MANDANT_ID FLOAT, BB_FG FLOAT)
   RETURNS STRING
   LANGUAGE JAVASCRIPT
   EXECUTE AS OWNER
   AS
   $$
 	var sql_stmt = `UPDATE dbp_msi_data.check_blackberry_2 SET mandant_id = ?, bb_fg= ?
WHERE mandant_id = ? AND dat = CURRENT_DATE -1`;
snowflake.createStatement({
   sqlText : sql_stmt,
   binds : [MANDANT_ID,BB_FG,MANDANT_ID]
}).execute();
 var sql_commit = `COMMIT;`
   snowflake.createStatement({
	   sqlText : sql_commit
	}).execute();

$$;

