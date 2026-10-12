CREATE OR REPLACE PROCEDURE DBP_MACRO.sp_update_problemmeldung_rfi (PRMSGID STRING, FREIGABE STRING, KREDITOR STRING, DOCCLASS STRING, CRUSER STRING, CAUSER STRING, WERKS STRING, PRCODE STRING, LIFNR STRING, MATNR STRING)
   RETURNS STRING
   LANGUAGE JAVASCRIPT
   EXECUTE AS OWNER
   AS
   $$
 	{
   if (FREIGABE == `update`) {
      var sql_stmt = `UPDATE DBP_MSI_DATA.problemmeldung_rfi 
                      SET
                        freigabe = '` + FREIGABE + `'
                        ,kreditor = '` + KREDITOR + `'
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
      var sql_stmt = `UPDATE DBP_MSI_DATA.problemmeldung_rfi 
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