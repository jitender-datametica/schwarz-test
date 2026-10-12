CREATE OR REPLACE PROCEDURE dbp_macro.m_insert_ais_mandant_wup (WUP_ID FLOAT)
   RETURNS STRING
   LANGUAGE JAVASCRIPT
   EXECUTE AS OWNER
   AS
   $$
 	var sql_stmt = `INSERT INTO dbp_msi_data.ais_mandant_wup_1 (MANDANT_ID, WUP_ID, GP_ID)
                  VALUES (1
                          ,?
                       ,5191480)`;
snowflake.createStatement({
   sqlText : sql_stmt,
   binds : [WUP_ID]
}).execute();
 var sql_commit = `COMMIT;`
   snowflake.createStatement({
	   sqlText : sql_commit
	}).execute();

$$;

