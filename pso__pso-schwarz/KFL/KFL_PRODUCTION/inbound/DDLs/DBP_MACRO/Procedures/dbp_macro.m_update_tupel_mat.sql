CREATE OR REPLACE PROCEDURE dbp_macro.m_update_tupel_mat (MANDANT_ID FLOAT, A500_KJWO_UPDATE FLOAT, MATCHING_ID FLOAT, A425_KJMO FLOAT)
   RETURNS STRING
   LANGUAGE JAVASCRIPT
   EXECUTE AS OWNER
   AS
   $$
 	var sql_stmt = `UPDATE dbp_data.tupel_mat 
                  SET  matching_id = ?
                  WHERE mandant_id        = ?`;
snowflake.createStatement({
   sqlText : sql_stmt,
   binds : [MATCHING_ID,MANDANT_ID]
}).execute();
 
$$;

