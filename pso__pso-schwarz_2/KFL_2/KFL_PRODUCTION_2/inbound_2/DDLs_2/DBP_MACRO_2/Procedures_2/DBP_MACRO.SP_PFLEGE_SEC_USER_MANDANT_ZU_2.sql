CREATE OR REPLACE PROCEDURE dbp_macro.sp_pflege_sec_user_mandant_zu (MANDANT_ID FLOAT, USER_ID STRING, LOESCH_FG FLOAT, MSI_PRODUKT STRING)
   RETURNS STRING
   LANGUAGE JAVASCRIPT
   EXECUTE AS OWNER
   AS
   $$
 	{
   var var_loesch_fg;
   var_loesch_fg = LOESCH_FG;
   if (var_loesch_fg == 1) {
      var sql_stmt = `DELETE FROM dbp_security.user_mandant_msiprodukt_zu_2  WHERE mandant_id =?  AND user_id =?  AND 1 =?  AND msi_produkt_bez = ?`;
      snowflake.createStatement({
         sqlText : sql_stmt,
         binds : [MANDANT_ID,USER_ID,LOESCH_FG,MSI_PRODUKT]
      }).execute();
   }
   if (var_loesch_fg == 0) {
      var sql_stmt = `INSERT INTO dbp_security.user_mandant_msiprodukt_zu_2 (MANDANT_ID, USER_ID, MSI_PRODUKT_BEZ)
                     VALUES (  ?   ,?   , ?)`;
      snowflake.createStatement({
         sqlText : sql_stmt,
         binds : [MANDANT_ID,USER_ID,MSI_PRODUKT]
      }).execute();
   }
   var sql_stmt = `DELETE FROM dbp_security.ios_mandant_usersequenz_zu_2`;
   snowflake.createStatement({
      sqlText : sql_stmt,
      binds : []
   }).execute();
   //Conversion warning - One or more identifiers in this statement were considered parameters by default. Referenced table not found.
   var sql_stmt = `INSERT INTO dbp_security.ios_mandant_usersequenz_zu_2 (MANDANT_ID, USERSEQUENZ)
   SELECT
      mandant_id, 
      LISTAGG(TRIM(user_id) || ',')  WITHIN GROUP (ORDER BY USER_ID) as usersequenz
   FROM dbp_security.user_mandant_msiprodukt_zu_2
   WHERE msi_produkt_bez like 'IOS'
   GROUP BY 1`;
   snowflake.createStatement({
      sqlText : sql_stmt,
      binds : []
   }).execute();
var sql_commit = `COMMIT;`
   snowflake.createStatement({
	   sqlText : sql_commit
	}).execute();
}
 
$$;

