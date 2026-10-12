CREATE OR REPLACE PROCEDURE dbp_macro.m_upd_artikel_zuordnung (S_MANDANT_ID FLOAT, S_EAN_ID FLOAT, S_ART_ID FLOAT, S_WG_ID FLOAT, S_WUG_ID FLOAT)
   RETURNS STRING
   LANGUAGE JAVASCRIPT
   EXECUTE AS OWNER
   AS
   $$
 	//ABORT 'ACHTUNG: eingegebene EAN  existiert bereits.'
//WHERE :s_ean_id IN (SELECT ean_id FROM );
// Neuen Satz hinzufÃ¼gen
var sql_stmt = `INSERT INTO dbp_data.ts_artikel_zuordnung (MANDANT_ID, EAN_ID, ART_ID, WG_ID, WUG_ID)
                VALUES (?,?,?,?,?)`;
snowflake.createStatement({
   sqlText : sql_stmt,
   binds : [S_MANDANT_ID,S_EAN_ID,S_ART_ID,S_WG_ID,S_WUG_ID]
}).execute();
 var sql_commit = `COMMIT;`
   snowflake.createStatement({
	   sqlText : sql_commit
	}).execute();

$$;

