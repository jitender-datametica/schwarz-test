CREATE OR REPLACE PROCEDURE dbp_macro.m_update_geku_verteilgebiet (VERTEILGEBIET_UID FLOAT, NILS_VERTEILGEBIET_ID FLOAT, MANDANT_ID FLOAT)
   RETURNS STRING
   LANGUAGE JAVASCRIPT
   EXECUTE AS OWNER
   AS
   $$
 	var sql_stmt = `UPDATE dbp_data.geku_verteilgebiet_1 SET  nils_verteilgebiet_id = ?
,mandant_id =?
WHERE verteilgebiet_uid = ?`;
snowflake.createStatement({
   sqlText : sql_stmt,
   binds : [NILS_VERTEILGEBIET_ID,MANDANT_ID,VERTEILGEBIET_UID]
}).execute();
 var sql_commit = `COMMIT;`
   snowflake.createStatement({
	   sqlText : sql_commit
	}).execute();

$$;

