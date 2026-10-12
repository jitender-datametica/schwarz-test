CREATE OR REPLACE PROCEDURE dbp_macro.m_update_l_aktion_thema (AKTION_THEMA_ID CHAR(4), MANDANT_ID FLOAT, AKTION_THEMA_GRUPPE_ID FLOAT)
   RETURNS STRING
   LANGUAGE JAVASCRIPT
   EXECUTE AS OWNER
   AS
   $$
 	var sql_stmt = `UPDATE dbp_data.l_aktion_thema SET aktion_thema_gruppe_id=CASE WHEN ? = -1 THEN NULL ELSE ? END
WHERE aktion_thema_id = ?
AND mandant_id = ?`;
snowflake.createStatement({
   sqlText : sql_stmt,
   binds : [AKTION_THEMA_GRUPPE_ID,AKTION_THEMA_GRUPPE_ID,AKTION_THEMA_ID,MANDANT_ID]
}).execute();
 var sql_commit = `COMMIT;`
   snowflake.createStatement({
	   sqlText : sql_commit
	}).execute();

$$;

