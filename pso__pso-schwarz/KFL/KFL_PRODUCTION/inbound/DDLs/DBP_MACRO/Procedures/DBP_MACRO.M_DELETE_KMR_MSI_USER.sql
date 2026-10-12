CREATE OR REPLACE PROCEDURE dbp_macro.m_delete_kmr_msi_user (USER_ID CHAR(30), MSI_PRODUKT_BEZ VARCHAR(10), LOESCH_FG FLOAT)
   RETURNS STRING
   LANGUAGE JAVASCRIPT
   EXECUTE AS OWNER
   AS
   $$
 	var sql_stmt = `DELETE FROM dbp_security.ts_kmr_user_security_filter_zu
WHERE user_id =?
AND ? = 1`;
snowflake.createStatement({
   sqlText : sql_stmt,
   binds : [USER_ID,LOESCH_FG]
}).execute();
var sql_stmt = `DELETE FROM dbp_security.l_msi_user
WHERE user_id =?
AND msi_produkt_bez =?
AND ? = 1`;
snowflake.createStatement({
   sqlText : sql_stmt,
   binds : [USER_ID,MSI_PRODUKT_BEZ,LOESCH_FG]
}).execute();
 var sql_commit = `COMMIT;`
   snowflake.createStatement({
	   sqlText : sql_commit
	}).execute();

$$
   ;

