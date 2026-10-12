CREATE OR REPLACE PROCEDURE dbp_macro.m_update_bon_mp_leergut_zu (MANDANT_ID FLOAT, MP_ODS_ID FLOAT, ALERT_FG FLOAT)
   RETURNS STRING
   LANGUAGE JAVASCRIPT
   EXECUTE AS OWNER
   AS
   $$
 	var sql_stmt = `UPDATE dbp_data.bon_mp_leergut_zu_2 SET alert_fg = ?
WHERE mandant_id = ?
AND mp_ods_id = ?`;
snowflake.createStatement({
   sqlText : sql_stmt,
   binds : [ALERT_FG,MANDANT_ID,MP_ODS_ID]
}).execute();
 var sql_commit = `COMMIT;`
   snowflake.createStatement({
	   sqlText : sql_commit
	}).execute();

$$
   ;

