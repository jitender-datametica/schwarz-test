CREATE OR REPLACE PROCEDURE dbp_macro.m_upd_mis_lieferquote (MANDANT_ID FLOAT, LIEFERQUOTE FLOAT, DATENQUOTE FLOAT)
   RETURNS STRING
   LANGUAGE JAVASCRIPT
   EXECUTE AS OWNER
   AS
   $$
 	var sql_stmt = `UPDATE dbp_msi_data.mis_lieferquote_1 SET mandant_id = ?, lieferquote = ?, datenquote = ?
WHERE mandant_id = ?`;
snowflake.createStatement({
   sqlText : sql_stmt,
   binds : [MANDANT_ID,LIEFERQUOTE,DATENQUOTE,MANDANT_ID]
}).execute();
 var sql_commit = `COMMIT;`
   snowflake.createStatement({
	   sqlText : sql_commit
	}).execute();

$$;

