CREATE OR REPLACE PROCEDURE dbp_macro.m_delete_in_lieferant_int (IN_LIEF_ID_INT FLOAT, LIEFERANT_INT_LOESCH_FG FLOAT)
   RETURNS STRING
   LANGUAGE JAVASCRIPT
   EXECUTE AS OWNER
   AS
   $$
 	var sql_stmt = `DELETE FROM dbp_data.in_lieferant_int_1
                  WHERE in_lief_id_int = ?
                  AND 1 = ?`;
snowflake.createStatement({
   sqlText : sql_stmt,
   binds : [IN_LIEF_ID_INT,LIEFERANT_INT_LOESCH_FG]
}).execute();
var sql_stmt = `UPDATE dbp_data.in_lieferant_1 
               SET in_lief_id_int = -1
               WHERE in_lief_id_int = ?
                 AND 1 = ?`;
snowflake.createStatement({
   sqlText : sql_stmt,
   binds : [IN_LIEF_ID_INT,LIEFERANT_INT_LOESCH_FG]
}).execute();
 var sql_commit = `COMMIT;`
   snowflake.createStatement({
	   sqlText : sql_commit
	}).execute();

$$
   ;

