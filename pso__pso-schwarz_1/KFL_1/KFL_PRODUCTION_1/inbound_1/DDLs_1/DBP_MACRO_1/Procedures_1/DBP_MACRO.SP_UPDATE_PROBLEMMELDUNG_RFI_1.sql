CREATE OR REPLACE PROCEDURE DBP_MACRO.sp_update_problemmeldung_rfi (PRMSGID STRING, FREIGABE STRING, KREDITOR_1 STRING, DOCCLASS STRING, CRUSER STRING, CAUSER STRING, WERKS STRING, PRCODE STRING, LIFNR STRING, MATNR STRING)
   RETURNS STRING
   LANGUAGE JAVASCRIPT
   EXECUTE AS OWNER
   AS
   $$
 	{
   if (FREIGABE == `update`) {
      var sql_stmt = `UPDATE DBP_MSI_DATA.problemmeldung_rfi_1 
                      SET
                        freigabe = '` + FREIGABE + `'
                        ,kreditor_1 = '` + KREDITOR_1 + `'
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
      var sql_stmt = `UPDATE DBP_MSI_DATA.problemmeldung_rfi_1 
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