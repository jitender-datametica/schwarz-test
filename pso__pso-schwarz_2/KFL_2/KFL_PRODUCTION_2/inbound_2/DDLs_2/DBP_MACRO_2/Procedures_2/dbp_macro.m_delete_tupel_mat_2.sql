CREATE OR REPLACE PROCEDURE dbp_macro.m_delete_tupel_mat (MANDANT_ID FLOAT, MATCHING_ID FLOAT)
   RETURNS STRING
   LANGUAGE JAVASCRIPT
   EXECUTE AS OWNER
   AS
   $$
 	var sql_stmt = `DELETE FROM dbp_data.tupel_mat_2
WHERE 	mandant_id =?
	AND	matching_id =?`;
snowflake.createStatement({
   sqlText : sql_stmt,
   binds : [MANDANT_ID,MATCHING_ID]
}).execute();
 
$$;

