CREATE OR REPLACE PROCEDURE p_lew_process.m_unity_routing ()
   RETURNS STRING
   LANGUAGE JAVASCRIPT
   EXECUTE AS CALLER
   AS
   $$
 	var sql_stmt = `   (SELECT
   MsiPath
   FROM p_lew_process_ac.v_ref_unity_routing
 WHERE
 MsiRepId = CAST(getquerybandvalue( 0, 'Msi_RepId') AS CHAR(32))
 OR
 (MsiRepId IS NULL AND POSITION(TRIM(MsiPath) IN GetQueryBandValue(0,'Msi_Path'))>0)
   )`;
var stmt = snowflake.createStatement({
   sqlText : sql_stmt,
   binds : []
});
var res = stmt.execute();
res.next();
var subQueryVariable0 = res.getColumnValue(1);
if (subQueryVariable0 != null) {
   var sql_stmt = `ROLLBACK`;
   var stmt = snowflake.createStatement({
      sqlText : sql_stmt,
      binds : []
   });
   var res = stmt.execute();
   return `Rerouting required`;
}
 
$$;

