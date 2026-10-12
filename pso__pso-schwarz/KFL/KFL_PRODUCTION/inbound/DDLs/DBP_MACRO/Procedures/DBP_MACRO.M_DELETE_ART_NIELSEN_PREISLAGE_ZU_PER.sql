CREATE OR REPLACE PROCEDURE dbp_macro.m_delete_art_nielsen_preislage_zu_per (MANDANT_ID FLOAT, ART_MATCHING_ID FLOAT)
   RETURNS STRING
   LANGUAGE JAVASCRIPT
   EXECUTE AS OWNER
   AS
   $$
 	var sql_stmt = `DELETE FROM dbp_data.art_nielsen_preislage_zu_per
WHERE 	mandant_id =?
	AND	art_matching_id =?`;
snowflake.createStatement({
   sqlText : sql_stmt,
   binds : [MANDANT_ID,ART_MATCHING_ID]
}).execute();
 var sql_commit = `COMMIT;`
   snowflake.createStatement({
	   sqlText : sql_commit
	}).execute();

$$;

