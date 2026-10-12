CREATE OR REPLACE PROCEDURE dbp_macro.m_update_in_lieferant (MANDANT_ID FLOAT, IN_LIEF_ID FLOAT, IN_LIEF_ID_INT FLOAT, LOESCH_FG FLOAT)
   RETURNS STRING
   LANGUAGE JAVASCRIPT
   EXECUTE AS OWNER
   AS
   $$
 	var sql_stmt = `UPDATE dbp_data.in_lieferant SET  in_lief_id_int = ?
WHERE mandant_id = ?
AND in_lief_id = ?
AND 0 = ?`;
snowflake.createStatement({
   sqlText : sql_stmt,
   binds : [IN_LIEF_ID_INT,MANDANT_ID,IN_LIEF_ID,LOESCH_FG]
}).execute();
var sql_stmt = `UPDATE dbp_data.in_lieferant SET in_lief_id_int = -1
WHERE mandant_id = ?
AND in_lief_id = ?
AND 1 = ?`;
snowflake.createStatement({
   sqlText : sql_stmt,
   binds : [MANDANT_ID,IN_LIEF_ID,LOESCH_FG]
}).execute();
 var sql_commit = `COMMIT;`
   snowflake.createStatement({
	   sqlText : sql_commit
	}).execute();

$$
   ;

