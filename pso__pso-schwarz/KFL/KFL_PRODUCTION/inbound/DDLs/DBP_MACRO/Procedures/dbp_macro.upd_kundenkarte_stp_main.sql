CREATE OR REPLACE PROCEDURE dbp_macro.upd_kundenkarte_stp_main (START_WUP FLOAT)
   RETURNS STRING
   LANGUAGE JAVASCRIPT
   EXECUTE AS OWNER
   AS
   $$
 	//IN db_nm CHAR(30) , 
//IN tbl_nm CHAR(30) ) 
{
   /* 
      call dbp_macro.upd_kundenkarte_stp_main(wup_id);
      Beispiel:
      call dbp_macro.upd_kundenkarte_stp_main(1000);

   */
   var wup_id_l;
   //Conversion warning - One or more identifiers in this statement were considered parameters by default. Referenced table not found.
   var sql_stmt = `SELECT
wup_id AS s_wup_id
FROM dbp_data.wup
WHERE mandant_id = 7
and wup_id >= ?
and nb_id=0
ORDER BY 1`;
   snowflake.createStatement({
      sqlText : sql_stmt,
      binds : [START_WUP]
   }).execute();
   var res = stmt.execute();
   while ( res.next() ) {
      var loop1 = {
         s_wup_id : res.getColumnValue(1)
      };
      wup_id_l = loop1.s_wup_id;
      var sql_stmt = `CALL dbp_macro.upd_kundenkarte_stp (?)`;
      snowflake.createStatement({
         sqlText : sql_stmt,
         binds : [wup_id_l]
      }).execute();
   }
   var sql_commit = `COMMIT;`
   snowflake.createStatement({
	   sqlText : sql_commit
	}).execute();

}
 
$$;