CREATE OR REPLACE PROCEDURE dbp_macro.m_delete_l_bis_ldap (MA_LDAP CHAR(10), LDAP_LOESCH_FG FLOAT)
   RETURNS STRING
   LANGUAGE JAVASCRIPT
   EXECUTE AS OWNER
   AS
   $$
 	var sql_stmt = `DELETE FROM dbp_security.l_bis_ldap
WHERE ma_ldap = ?
AND 1 = ?`;
snowflake.createStatement({
   sqlText : sql_stmt,
   binds : [MA_LDAP,LDAP_LOESCH_FG]
}).execute();
var sql_stmt = `DELETE FROM dbp_security.bis_einkaeufer_ldap_zu
WHERE ma_ldap = ?
AND 1 = ?`;
snowflake.createStatement({
   sqlText : sql_stmt,
   binds : [MA_LDAP,LDAP_LOESCH_FG]
}).execute();
 var sql_commit = `COMMIT;`
   snowflake.createStatement({
	   sqlText : sql_commit
	}).execute();

$$
   ;

