CREATE OR REPLACE PROCEDURE DBP_MACRO.SP_INS_DEL_MSI_USER_SEC_KZ_KMR (P_SEC_KZ VARCHAR(16777216), P_USER_ID VARCHAR(16777216), P_SEC_FG FLOAT)
RETURNS VARCHAR(16777216)
LANGUAGE JAVASCRIPT
EXECUTE AS OWNER
AS '
 	{
   if (P_SEC_FG == 1) {
      var sql_stmt = `MERGE INTO DBP_MSI_DATA.ts_kmr_user_sec_kz_zu_2 AS target
                     USING (VALUES (? ,?)) AS tab (sec, ldap)
                      ON tab.ldap       = target.user_id 
                       AND tab.sec      = target.sec_kz
                     WHEN NOT MATCHED THEN
                     INSERT
                     VALUES ( tab.ldap ,tab.sec)`;
      snowflake.createStatement({
         sqlText : sql_stmt,
         binds : [P_SEC_KZ, P_USER_ID]
      }).execute();
   } 
   else if (P_SEC_FG == 0) {
      var sql_stmt = `DELETE FROM DBP_MSI_DATA.ts_kmr_user_sec_kz_zu_2
                     WHERE sec_kz =?
                     AND user_id =?`;
      snowflake.createStatement({
         sqlText : sql_stmt,
         binds : [P_SEC_KZ, P_USER_ID]
      }).execute();
   }
   var sql_commit = `COMMIT;`
   snowflake.createStatement({
	   sqlText : sql_commit
	}).execute();
}
 
';