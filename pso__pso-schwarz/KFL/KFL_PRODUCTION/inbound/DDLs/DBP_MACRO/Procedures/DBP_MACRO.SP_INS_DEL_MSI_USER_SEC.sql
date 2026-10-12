CREATE OR REPLACE PROCEDURE DBP_MACRO.sp_ins_del_msi_user_sec (MANDANT_ID FLOAT, USER_ID STRING, SEC_FG FLOAT, MSI_PRODUKT_BEZ STRING)
   RETURNS STRING
   LANGUAGE JAVASCRIPT
   EXECUTE AS OWNER
   AS
   $$
 	{
   if (SEC_FG == 1) {
      var sql_stmt = `MERGE INTO DBP_SECURITY.user_mandant_msiprodukt_zu AS target
                     USING (VALUES (? ,? ,?)) AS tab (mandant, ldap, msi_produkt)
                      ON tab.mandant       = target.mandant_id 
                       AND tab.ldap        = target.user_id
                       AND tab.msi_produkt = target.msi_produkt_bez
                     WHEN NOT MATCHED THEN
                     INSERT (MANDANT_ID, USER_ID, MSI_PRODUKT_BEZ)
                     VALUES ( tab.mandant ,tab.ldap ,tab.msi_produkt)`;
      snowflake.createStatement({
         sqlText : sql_stmt,
         binds : [MANDANT_ID,USER_ID,MSI_PRODUKT_BEZ]
      }).execute();
   } 
   else if (SEC_FG == 0) {
      var sql_stmt = `DELETE FROM DBP_SECURITY.user_mandant_msiprodukt_zu
                     WHERE mandant_id =?
                     AND user_id =?
                     AND msi_produkt_bez =?`;
      snowflake.createStatement({
         sqlText : sql_stmt,
         binds : [MANDANT_ID,USER_ID,MSI_PRODUKT_BEZ]
      }).execute();
   }
   var sql_commit = `COMMIT;`
   snowflake.createStatement({
	   sqlText : sql_commit
	}).execute();
}
 
$$;

