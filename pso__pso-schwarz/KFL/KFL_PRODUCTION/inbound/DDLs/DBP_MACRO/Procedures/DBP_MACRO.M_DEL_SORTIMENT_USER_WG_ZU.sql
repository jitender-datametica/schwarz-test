CREATE OR REPLACE PROCEDURE dbp_macro.m_del_sortiment_user_wg_zu (MANDANT_ID FLOAT, USER_ID VARCHAR(30), WG_ID FLOAT)
   RETURNS STRING
   LANGUAGE JAVASCRIPT
   EXECUTE AS OWNER
   AS
   $$
 	//Conversion warning - One or more identifiers in this statement were considered parameters by default. Referenced table not found.
var sql_stmt = `DELETE FROM dbp_security.sortiment_user_wg_zu
WHERE mandant_id = ?
AND user_id = UPPER(LEFT(?,2)) || LOWER(SUBSTR(?,3,LENGTH(?)-2))
AND wg_id = ?`;
snowflake.createStatement({
   sqlText : sql_stmt,
   binds : [MANDANT_ID,USER_ID,USER_ID,USER_ID,WG_ID]
}).execute();
 
var sql_commit = `COMMIT;`
snowflake.createStatement({
	   sqlText : sql_commit
	}).execute();

$$;

