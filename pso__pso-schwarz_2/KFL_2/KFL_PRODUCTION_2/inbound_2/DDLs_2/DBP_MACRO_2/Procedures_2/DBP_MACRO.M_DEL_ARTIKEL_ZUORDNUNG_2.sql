CREATE OR REPLACE PROCEDURE dbp_macro.m_del_artikel_zuordnung (S_MANDANT_ID FLOAT, S_EAN_ID FLOAT, S_ART_ID FLOAT, S_WG_ID FLOAT, S_WUG_ID FLOAT)
   RETURNS STRING
   LANGUAGE JAVASCRIPT
   EXECUTE AS OWNER
   AS
   $$
 	var sql_stmt = `DELETE FROM dbp_data.ts_artikel_zuordnung_2
WHERE mandant_id = ?
AND ean_id = ?
AND art_id = ?
AND wg_id = ?
AND wug_id = ?`;
snowflake.createStatement({
   sqlText : sql_stmt,
   binds : [S_MANDANT_ID,S_EAN_ID,S_ART_ID,S_WG_ID,S_WUG_ID]
}).execute();

var sql_commit = `COMMIT;`
   snowflake.createStatement({
	   sqlText : sql_commit
	}).execute();
 
$$;

