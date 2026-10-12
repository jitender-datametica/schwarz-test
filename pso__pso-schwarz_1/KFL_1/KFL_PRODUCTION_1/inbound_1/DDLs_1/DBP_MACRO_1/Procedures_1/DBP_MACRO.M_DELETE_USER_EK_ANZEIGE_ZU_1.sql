CREATE OR REPLACE PROCEDURE dbp_macro.m_delete_user_ek_anzeige_zu (USER_ID VARCHAR(30))
   RETURNS STRING
   LANGUAGE JAVASCRIPT
   EXECUTE AS OWNER
   AS
   $$
 	var sql_stmt = `DELETE FROM dbp_security.user_ek_anzeige_zu_1
WHERE user_id = ?`;
snowflake.createStatement({
   sqlText : sql_stmt,
   binds : [USER_ID]
}).execute();
 var sql_commit = `COMMIT;`
   snowflake.createStatement({
	   sqlText : sql_commit
	}).execute();

$$;

