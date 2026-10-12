CREATE OR REPLACE PROCEDURE dbp_macro.m_ups_zek_wbl_zu (MANDANT_ID FLOAT, ZEK_ID FLOAT, WBL_ID FLOAT)
   RETURNS STRING
   LANGUAGE JAVASCRIPT
   EXECUTE AS OWNER
   AS
   $$
 	var sql_stmt = `MERGE INTO dbp_security.zek_wbl_zu_1 target
                  USING (SELECT ? AS MANDANT_ID, ? AS ZEK_ID, ? AS WBL_ID) source
                     ON target.mandant_id = source.MANDANT_ID
                     AND target.zek_id = source.ZEK_ID
                  WHEN MATCHED THEN UPDATE SET  target.wbl_id = source.WBL_ID
                  WHEN NOT MATCHED THEN INSERT (MANDANT_ID,ZEK_ID,WBL_ID)  VALUES (source.MANDANT_ID, source.ZEK_ID, source.WBL_ID)`;
snowflake.createStatement({
   sqlText : sql_stmt,
   binds : [MANDANT_ID,ZEK_ID,WBL_ID]
}).execute();
 
var sql_commit = `COMMIT;`
   snowflake.createStatement({
	   sqlText : sql_commit
	}).execute();

$$;

