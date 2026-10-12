CREATE OR REPLACE PROCEDURE dbp_macro.m_del_kl_wg_nielsen_gfk_hhp_wg_zu (MANDANT_ID FLOAT, KL_WG_ID FLOAT, GFK_WG_ID FLOAT)
   RETURNS STRING
   LANGUAGE JAVASCRIPT
   EXECUTE AS OWNER
   AS
   $$
 	var sql_stmt = `DELETE FROM dbp_data.kl_wg_nielsen_gfk_hhp_wg_zu_1
WHERE mandant_id = ?
AND kl_wg_id = ?
AND gfk_wg_id = ?`;
snowflake.createStatement({
   sqlText : sql_stmt,
   binds : [MANDANT_ID,KL_WG_ID,GFK_WG_ID]
}).execute();
 

 var sql_commit = `COMMIT;`
snowflake.createStatement({
	   sqlText : sql_commit
	}).execute();
$$;

