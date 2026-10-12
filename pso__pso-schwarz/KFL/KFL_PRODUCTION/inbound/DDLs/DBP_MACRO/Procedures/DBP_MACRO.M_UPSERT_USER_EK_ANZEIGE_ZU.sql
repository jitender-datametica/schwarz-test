CREATE OR REPLACE PROCEDURE dbp_macro.m_upsert_user_ek_anzeige_zu (USER_ID VARCHAR(30), EK_ANZEIGE_FG FLOAT)
   RETURNS STRING
   LANGUAGE JAVASCRIPT
   EXECUTE AS OWNER
   AS
   $$
 	var sql_stmt = `MERGE INTO dbp_security.user_ek_anzeige_zu target
                  USING (SELECT ? AS USER_ID, ? AS EK_ANZEIGE_FG) source
                  ON target.user_id = source.user_id 
                  WHEN MATCHED THEN UPDATE SET target.ek_anzeige_fg = source.ek_anzeige_fg
                  WHEN NOT MATCHED THEN INSERT (USER_ID, EK_ANZEIGE_FG) VALUES (source.user_id , source.ek_anzeige_fg)`;
snowflake.createStatement({
   sqlText : sql_stmt,
   binds : [USER_ID,EK_ANZEIGE_FG]
}).execute();
 
var sql_commit = `COMMIT;`
   snowflake.createStatement({
	   sqlText : sql_commit
	}).execute();

$$;

