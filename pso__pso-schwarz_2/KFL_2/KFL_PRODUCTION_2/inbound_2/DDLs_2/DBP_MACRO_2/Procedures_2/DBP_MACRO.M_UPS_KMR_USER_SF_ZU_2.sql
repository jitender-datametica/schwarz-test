CREATE OR REPLACE PROCEDURE dbp_macro.m_ups_kmr_user_sf_zu (SF_ID FLOAT, USER_ID VARCHAR(30))
   RETURNS STRING
   LANGUAGE JAVASCRIPT
   EXECUTE AS OWNER
   AS
   $$
 	var sql_stmt = `MERGE INTO dbp_security.ts_kmr_user_security_filter_zu_2 a 
    USING 
    (SELECT ? AS SF_ID
           , ? AS USER_ID) b 
      ON a.user_id = b.user_id
   WHEN MATCHED THEN 
      UPDATE SET a.sf_id = b.sf_id
    WHEN NOT MATCHED THEN 
      INSERT (USER_ID, SF_ID)
      VALUES (upper(substr(b.user_id,1, 2)) || lower(substr(b.user_id, 3, length(b.user_id) - 2))
              , b.sf_id)`;
snowflake.createStatement({
   sqlText : sql_stmt,
   binds : [SF_ID,USER_ID]
}).execute();
 var sql_commit = `COMMIT;`
   snowflake.createStatement({
	   sqlText : sql_commit
	}).execute();

$$
   ;

