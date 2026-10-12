CREATE OR REPLACE PROCEDURE dbp_macro.m_ups_bis_einkaeufer_ldap_zu (MANDANT_ID FLOAT, MA_LDAP VARCHAR(10), EINKAEUFER_BIS_ID VARCHAR(10), HAT_EINKAEUFER_GRP_FG FLOAT, EIGENE_GRUPPE_FG FLOAT)
   RETURNS STRING
   LANGUAGE JAVASCRIPT
   EXECUTE AS OWNER
   AS
   $$
 	var sql_stmt = `MERGE INTO dbp_security.bis_einkaeufer_ldap_zu AS target
                   USING (SELECT ? AS mandant_id
                               , ? AS ma_ldap
                               , ? AS einkaeufer_bis_id
                               , ? AS eigene_gruppe_fg
                  ) as source
                     ON  target.mandant_id        = source.mandant_id
                     AND target.ma_ldap           = source.ma_ldap
                     AND target.einkaeufer_bis_id = source.einkaeufer_bis_id
                  WHEN MATCHED THEN 
                  UPDATE 
                     SET target.eigene_gruppe_fg = CASE WHEN ? IS NULL THEN 0 ELSE ? END 
                  WHEN NOT MATCHED THEN
                   INSERT (MANDANT_ID
                          ,MA_LDAP
                          ,EINKAEUFER_BIS_ID
                          ,EIGENE_GRUPPE_FG)
                      VALUES (?
                             ,?
                             ,?
                             , CASE WHEN ? IS NULL THEN 0 ELSE ? END)`;
snowflake.createStatement({
   sqlText : sql_stmt,
   binds : [MANDANT_ID,MA_LDAP,EINKAEUFER_BIS_ID,EIGENE_GRUPPE_FG,EIGENE_GRUPPE_FG,EIGENE_GRUPPE_FG,MANDANT_ID,MA_LDAP,EINKAEUFER_BIS_ID,EIGENE_GRUPPE_FG,EIGENE_GRUPPE_FG]
}).execute();

var sql_stmt = `DELETE FROM dbp_security.bis_einkaeufer_ldap_zu
                WHERE mandant_id = ?
                  AND ma_ldap = ?
                  AND einkaeufer_bis_id = ?
                  AND ? IN (0)`;
snowflake.createStatement({
   sqlText : sql_stmt,
   binds : [MANDANT_ID,MA_LDAP,EINKAEUFER_BIS_ID,HAT_EINKAEUFER_GRP_FG]
}).execute();

 var sql_commit = `COMMIT;`
   snowflake.createStatement({
	   sqlText : sql_commit
	}).execute();
$$;