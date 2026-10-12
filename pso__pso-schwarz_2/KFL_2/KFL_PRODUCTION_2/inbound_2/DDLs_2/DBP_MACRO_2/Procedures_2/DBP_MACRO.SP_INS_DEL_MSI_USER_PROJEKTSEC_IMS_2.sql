CREATE OR REPLACE PROCEDURE DBP_MACRO.SP_INS_DEL_MSI_USER_PROJEKTSEC_IMS (IT_PROJEKT_ID VARCHAR(16777216), USER_ID VARCHAR(16777216), SEC_FG FLOAT)
RETURNS VARCHAR(16777216)
LANGUAGE JAVASCRIPT
EXECUTE AS OWNER
AS '
 	{
   if (SEC_FG == 1) {
      var sql_stmt = `MERGE INTO DBP_SECURITY.l_ims_user_it_projekt_2 AS target
                     USING (VALUES (? ,?)) AS tab (ldap, it_projekt_2)
                      ON tab.ldap       = target.user_id 
                       AND tab.it_projekt_2        = target.it_projekt_id
                     WHEN NOT MATCHED THEN
                     INSERT
                     VALUES ( tab.ldap ,tab.it_projekt_2, NULL, NULL)`;
      snowflake.createStatement({
         sqlText : sql_stmt,
         binds : [USER_ID,IT_PROJEKT_ID]
      }).execute();
   } 
   else if (SEC_FG == 0) {
      var sql_stmt = `DELETE FROM DBP_SECURITY.l_ims_user_it_projekt_2
                     WHERE user_id =?
                     AND it_projekt_id =?`;
      snowflake.createStatement({
         sqlText : sql_stmt,
         binds : [USER_ID,IT_PROJEKT_ID]
      }).execute();
   }
   var sql_commit = `COMMIT;`
   snowflake.createStatement({
	   sqlText : sql_commit
	}).execute();
}
 
';