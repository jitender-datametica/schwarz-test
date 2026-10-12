CREATE OR REPLACE PROCEDURE dbp_macro.m_ups_wbl_gf_zu (MANDANT_ID FLOAT, WBL_ID FLOAT, GF_ID FLOAT)
   RETURNS STRING
   LANGUAGE JAVASCRIPT
   EXECUTE AS OWNER
   AS
   $$
 	var sql_stmt = `MERGE INTO dbp_security.wbl_gf_zu AS target
                  USING (
                     SELECT ? AS mandant_id
                           ,? AS wbl_id
                           ,? AS gf_id
                  ) AS source
                  ON  target.mandant_id = source.mandant_id
                  AND target.wbl_id = source.wbl_id 
                  WHEN MATCHED THEN
                     UPDATE SET target.gf_id = source.gf_id
                  WHEN NOT MATCHED THEN
                     INSERT (mandant_id,wbl_id,gf_id)
                        VALUES (
                          source.mandant_id
                        , source.wbl_id
                        , source.gf_id)`;
snowflake.createStatement({
   sqlText : sql_stmt,
   binds : [MANDANT_ID,WBL_ID,GF_ID]
}).execute();
 
var sql_commit = `COMMIT;`
   snowflake.createStatement({
	   sqlText : sql_commit
	}).execute();

$$;

