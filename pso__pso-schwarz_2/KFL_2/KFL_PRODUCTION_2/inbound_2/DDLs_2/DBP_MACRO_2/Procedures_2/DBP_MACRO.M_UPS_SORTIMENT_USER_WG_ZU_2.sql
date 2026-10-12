CREATE OR REPLACE PROCEDURE dbp_macro.m_ups_sortiment_user_wg_zu (MANDANT_ID FLOAT, USER_ID VARCHAR(30), WG_ID FLOAT)
   RETURNS STRING
   LANGUAGE JAVASCRIPT
   EXECUTE AS OWNER
   AS
   $$
 	var sql_stmt = `MERGE INTO dbp_security.sortiment_user_wg_zu_2 as target
                  USING (
                     SELECT ? AS mandant_id
                           ,UPPER(LEFT(?,2)) || LOWER(SUBSTR(?,3,LENGTH(?)-2)) AS user_id
                           ,? AS wg_id
                  ) as source
                     ON  target.mandant_id = source.mandant_id 
                     AND target.user_id = source.user_id 
                     AND target.wg_id = source.wg_id 
                  WHEN MATCHED THEN 
                     UPDATE SET  mandant_id = ?
                  WHEN NOT MATCHED THEN 
                     INSERT (mandant_id, user_id, wg_id)
                     VALUES (
                                 ?
                                 ,UPPER(LEFT(?,2)) || LOWER(SUBSTR(?,3,LENGTH(?)-2))
                                 ,?)`;
snowflake.createStatement({
   sqlText : sql_stmt,
   binds : [MANDANT_ID,USER_ID,USER_ID,USER_ID,WG_ID,MANDANT_ID,MANDANT_ID,USER_ID,USER_ID,USER_ID,WG_ID]
}).execute();
 
var sql_commit = `COMMIT;`
   snowflake.createStatement({
	   sqlText : sql_commit
	}).execute();

$$;

