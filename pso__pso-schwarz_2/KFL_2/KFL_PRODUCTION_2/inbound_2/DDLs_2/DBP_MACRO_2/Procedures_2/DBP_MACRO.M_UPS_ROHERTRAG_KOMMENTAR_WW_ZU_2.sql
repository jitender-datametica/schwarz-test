CREATE OR REPLACE PROCEDURE dbp_macro.m_ups_rohertrag_kommentar_ww_zu (MANDANT_ID FLOAT, KJWO_WW FLOAT, KOMMENTAR VARCHAR (160))
   RETURNS STRING
   LANGUAGE JAVASCRIPT
   EXECUTE AS OWNER
   AS
   $$
 	var sql_stmt = `MERGE INTO dbp_msi_view_reb.ts_rohertrag_kommentar_ww_zu_2 AS target
                  USING (
                     SELECT ? AS mandant_id
                           ,? AS kjwo_ww
                           ,? AS kommentar
                  ) AS source
                  ON  target.mandant_id = source.mandant_id
                  AND target.kjwo_ww    = source.kjwo_ww
                  WHEN MATCHED THEN 
                     UPDATE SET  target.kommentar = ? 
                  WHEN NOT MATCHED THEN 
                     INSERT (MANDANT_ID, KJWO_WW, KOMMENTAR)
                      VALUES (?, ?, ?)`;
snowflake.createStatement({
   sqlText : sql_stmt,
   binds : [MANDANT_ID,KJWO_WW,KOMMENTAR,KOMMENTAR,MANDANT_ID,KJWO_WW,KOMMENTAR]
}).execute();
 
var sql_commit = `COMMIT;`
   snowflake.createStatement({
	   sqlText : sql_commit
	}).execute();

$$;

