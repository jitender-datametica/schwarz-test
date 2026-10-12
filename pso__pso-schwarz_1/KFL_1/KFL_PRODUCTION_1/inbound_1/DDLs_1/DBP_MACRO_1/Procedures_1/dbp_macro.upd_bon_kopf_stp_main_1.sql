CREATE OR REPLACE PROCEDURE dbp_macro.upd_bon_kopf_stp_main ()
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
   var mandant_id_l;
   var wup_id_l;
   //Conversion warning - One or more identifiers in this statement were considered parameters by default. Referenced table not found.
   var sql_stmt = `SELECT
? AS s_mandant_id,
wup_id AS s_wup_id
FROM dbp_ods."ods_bon_kopf_bu_prod_delta_190313#mrau"
group by 1,2
order by 1,2`;
   snowflake.createStatement({
      sqlText : sql_stmt,
      binds : [MANDANT_ID]
   }).execute();
   var res = stmt.execute();
   while ( res.next() ) {
      var loop1 = {
         s_mandant_id : res.getColumnValue(1),
         s_wup_id : res.getColumnValue(2)
      };
      mandant_id_l = loop1.s_mandant_id;
      wup_id_l = loop1.s_wup_id;
      var sql_stmt = `CALL dbp_macro.upd_bon_kopf_stp (?, ?)`;
      snowflake.createStatement({
         sqlText : sql_stmt,
         binds : [mandant_id_l,wup_id_l]
      }).execute();
   }
var sql_commit = `COMMIT;`
   snowflake.createStatement({
	   sqlText : sql_commit
	}).execute();

}
 
$$;

