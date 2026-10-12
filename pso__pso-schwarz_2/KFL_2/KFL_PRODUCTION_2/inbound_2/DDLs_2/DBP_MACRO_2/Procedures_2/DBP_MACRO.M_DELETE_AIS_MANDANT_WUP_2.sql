CREATE OR REPLACE PROCEDURE dbp_macro.m_delete_ais_mandant_wup (WUP_ID FLOAT)
   RETURNS STRING
   LANGUAGE JAVASCRIPT
   EXECUTE AS OWNER
   AS
   $$
 	var sql_stmt = `DELETE FROM dbp_msi_data.ais_mandant_wup_2
WHERE wup_id = ?
AND mandant_id = 1
AND gp_id = 5191480`;
snowflake.createStatement({
   sqlText : sql_stmt,
   binds : [WUP_ID]
}).execute();
 

 var sql_commit = `COMMIT;`
snowflake.createStatement({
	   sqlText : sql_commit
	}).execute();
$$;

