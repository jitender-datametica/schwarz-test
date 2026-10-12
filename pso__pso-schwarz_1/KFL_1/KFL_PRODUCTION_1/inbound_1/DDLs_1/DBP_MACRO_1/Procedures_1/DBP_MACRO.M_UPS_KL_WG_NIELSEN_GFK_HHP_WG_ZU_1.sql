CREATE OR REPLACE PROCEDURE dbp_macro.m_ups_kl_wg_nielsen_gfk_hhp_wg_zu (MANDANT_ID FLOAT, KL_WG_ID FLOAT, GFK_WG_ID FLOAT)
   RETURNS STRING
   LANGUAGE JAVASCRIPT
   EXECUTE AS OWNER
   AS
   $$
 	var sql_stmt = `MERGE INTO dbp_data.kl_wg_nielsen_gfk_hhp_wg_zu_1 as target
                  USING (
                     SELECT ? AS mandant_id
                           ,? AS kl_wg_id
                           ,? AS gfk_wg_id
                  ) as source
                   ON target.mandant_id = source.mandant_id
                  AND target.kl_wg_id   = source.kl_wg_id
                  AND target.gfk_wg_id  = source.gfk_wg_id
                  WHEN MATCHED THEN 
                     UPDATE SET  kl_wg_id = ?
                              , gfk_wg_id = ? 
                  WHEN NOT MATCHED THEN 
                     INSERT (MANDANT_ID,KL_WG_ID,GFK_WG_ID)
                     VALUES (?,?,?)`;
snowflake.createStatement({
   sqlText : sql_stmt,
   binds : [MANDANT_ID,KL_WG_ID,GFK_WG_ID
         ,KL_WG_ID,GFK_WG_ID
         ,MANDANT_ID,KL_WG_ID,GFK_WG_ID]
}).execute();
 
var sql_commit = `COMMIT;`
   snowflake.createStatement({
	   sqlText : sql_commit
	}).execute();

$$;

