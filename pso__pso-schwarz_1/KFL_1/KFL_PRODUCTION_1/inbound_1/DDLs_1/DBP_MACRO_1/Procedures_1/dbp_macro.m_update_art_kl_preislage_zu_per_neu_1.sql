CREATE OR REPLACE PROCEDURE dbp_macro.m_update_art_kl_preislage_zu_per_neu (MANDANT_ID FLOAT, ART_MATCHING_ID FLOAT, KJMO FLOAT, KJWO_UPDATE FLOAT)
   RETURNS STRING
   LANGUAGE JAVASCRIPT
   EXECUTE AS OWNER
   AS
   $$
 	var sql_stmt = `UPDATE dbp_data.art_kl_preislage_zu_per_neu_1 SET art_matching_id = ?

WHERE mandant_id        = ?
AND art_matching_id  = ?`;
snowflake.createStatement({
   sqlText : sql_stmt,
   binds : [ART_MATCHING_ID,MANDANT_ID,ART_MATCHING_ID]
}).execute();
 var sql_commit = `COMMIT;`
   snowflake.createStatement({
	   sqlText : sql_commit
	}).execute();

$$;

