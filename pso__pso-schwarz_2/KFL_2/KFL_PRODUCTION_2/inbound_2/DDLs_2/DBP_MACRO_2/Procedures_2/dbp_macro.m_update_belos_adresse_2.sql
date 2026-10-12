CREATE OR REPLACE PROCEDURE dbp_macro.m_update_belos_adresse (BELOS_STANDORT_TYP_ID FLOAT, MANDANT_ID FLOAT, BELOS_ADRESSE_ID VARCHAR(40))
   RETURNS STRING
   LANGUAGE JAVASCRIPT
   EXECUTE AS OWNER
   AS
   $$
 	var sql_stmt = `UPDATE dbp_data.belos_adresse_2 SET belos_standort_typ_id = ?

WHERE mandant_id        = ?
AND belos_adresse_id  = ?`;
snowflake.createStatement({
   sqlText : sql_stmt,
   binds : [BELOS_STANDORT_TYP_ID,MANDANT_ID,BELOS_ADRESSE_ID]
}).execute();
 var sql_commit = `COMMIT;`
   snowflake.createStatement({
	   sqlText : sql_commit
	}).execute();

$$;

