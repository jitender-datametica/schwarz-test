CREATE OR REPLACE PROCEDURE DBP_MACRO.sp_update_problemmeldung_rfi (PRMSGID STRING, FREIGABE STRING, KREDITOR_2 STRING, DOCCLASS STRING, CRUSER STRING, CAUSER STRING, WERKS STRING, PRCODE STRING, LIFNR STRING, MATNR STRING)
   RETURNS STRING
   LANGUAGE JAVASCRIPT
   EXECUTE AS OWNER
   AS
   $$
 	{
   if (FREIGABE == `update`) {
      var sql_stmt = `UPDATE DBP_MSI_DATA.problemmeldung_rfi_2 
                      SET
                        freigabe = '` + FREIGABE + `'
                        ,kreditor_2 = '` + KREDITOR_2 + `'
                        ,docclass = '` + DOCCLASS + `'
                        ,cruser = '` + CRUSER + `'
                        ,causer = '` + CAUSER + `'
                        ,werks = '` + WERKS + `'
                        ,prcode = '` + PRCODE + `'
                        ,lifnr = '` + LIFNR + `'
                        ,matnr = '` + MATNR + `'
                        WHERE prmsgid = '` + PRMSGID + `'`;

      sql_stmt = sql_stmt.replace(/'undefined'/g, "NULL");
      
      snowflake.createStatement({sqlText : sql_stmt}).execute();
      
      var sql_commit = `COMMIT;`
                snowflake.createStatement({
	   sqlText : sql_commit}).execute();
   } else {
      var sql_stmt = `UPDATE DBP_MSI_DATA.problemmeldung_rfi_2 
                     SET freigabe = '` + FREIGABE + `'
                     WHERE prmsgid = '` + PRMSGID + `'`;
      snowflake.createStatement({
         sqlText : sql_stmt}).execute();
    
      var sql_commit = `COMMIT;`
                snowflake.createStatement({
	   sqlText : sql_commit}).execute();
   }
}
$$;