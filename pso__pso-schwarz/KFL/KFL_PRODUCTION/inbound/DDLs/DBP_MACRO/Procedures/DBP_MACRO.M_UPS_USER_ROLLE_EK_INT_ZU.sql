CREATE OR REPLACE PROCEDURE dbp_macro.m_ups_user_rolle_ek_int_zu (MANDANT_ID FLOAT, USER_ID VARCHAR(30), ROLLE_ID FLOAT, ZEK_ID VARCHAR(3), WBL_ID FLOAT, GF_ID FLOAT)
   RETURNS STRING
   LANGUAGE JAVASCRIPT
   EXECUTE AS OWNER
   AS
   $$
 	var sql_stmt = `MERGE INTO dbp_security.user_rolle_ek_int_zu as target
                  USING (
                     SELECT ? AS mandant_id
                           ,CASE ? WHEN 'adminkis' THEN ? ELSE UPPER(LEFT(?,2)) || LOWER(SUBSTR(?,3,LENGTH(?)-2)) END AS user_id
                           ,? AS rolle_id
                           ,? AS zek_id
                           ,? AS wbl_id
                           ,? AS gf_id
                  ) AS source
                    ON target.mandant_id = source.mandant_id
                   AND target.user_id = source.user_id
                   AND target.rolle_id = source.rolle_id
                   AND (target.zek_id = source.zek_id OR source.zek_id is NULL)
                   AND (target.wbl_id = source.wbl_id OR source.wbl_id is NULL)
                   AND (target.gf_id  = source.gf_id OR source.gf_id is NULL) 
                  WHEN MATCHED THEN 
                     UPDATE SET target.rolle_bez = NULL 
                  WHEN NOT MATCHED THEN 
                     INSERT (mandant_id, USER_ID,ROLLE_ID,ROLLE_BEZ,ZEK_ID,WBL_ID,GF_ID)
                     VALUES (
                        source.mandant_id
                        , source.user_id
                        , source.rolle_id
                        , NULL
                        , DECODE(source.rolle_id, 1, source.zek_id, NULL)
                        , DECODE(source.rolle_id, 2, source.wbl_id, NULL)
                        , DECODE(source.rolle_id, 3, source.gf_id, NULL))`;

snowflake.createStatement({
   sqlText : sql_stmt,
   binds : [MANDANT_ID,USER_ID,USER_ID,USER_ID,USER_ID,USER_ID,ROLLE_ID,ZEK_ID,WBL_ID,GF_ID]
   .map(function(x){return x === undefined ? null : x})
}).execute();
 
var sql_commit = `COMMIT;`
   snowflake.createStatement({
	   sqlText : sql_commit
	}).execute();

$$;

