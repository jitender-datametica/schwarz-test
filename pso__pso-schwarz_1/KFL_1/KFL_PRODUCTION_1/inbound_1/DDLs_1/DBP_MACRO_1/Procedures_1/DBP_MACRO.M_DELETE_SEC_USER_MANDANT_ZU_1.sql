CREATE OR REPLACE PROCEDURE dbp_macro.m_delete_sec_user_mandant_zu (USER_ID VARCHAR(30), LOESCH_FG FLOAT, MSI_PRODUKT VARCHAR(10))
   RETURNS STRING
   LANGUAGE JAVASCRIPT
   EXECUTE AS OWNER
   AS
   $$
 	var sql_stmt = `DELETE FROM dbp_security.user_mandant_msiprodukt_zu_1
WHERE user_id =?
AND 1=?
AND msi_produkt_bez = ?`;
snowflake.createStatement({
   sqlText : sql_stmt,
   binds : [USER_ID,LOESCH_FG,MSI_PRODUKT]
}).execute();
var sql_stmt = `DELETE FROM dbp_security.l_msi_user_1
WHERE user_id =?
AND 1=?
AND msi_produkt_bez = ?`;
snowflake.createStatement({
   sqlText : sql_stmt,
   binds : [USER_ID,LOESCH_FG,MSI_PRODUKT]
}).execute();
 var sql_commit = `COMMIT;`
   snowflake.createStatement({
	   sqlText : sql_commit
	}).execute();

$$;

