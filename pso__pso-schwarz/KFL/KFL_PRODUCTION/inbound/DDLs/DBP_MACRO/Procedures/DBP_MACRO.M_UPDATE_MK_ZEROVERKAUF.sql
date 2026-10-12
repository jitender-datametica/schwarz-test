CREATE OR REPLACE PROCEDURE dbp_macro.m_update_mk_zeroverkauf (WUP_ID FLOAT, MANDANT_ID FLOAT, ART_ID FLOAT, DAT DATE, ZEITFENSTER_ID FLOAT, ART_FEHLGRUND_BEZ VARCHAR(100), ART_FEHLGRUND_TEXT VARCHAR(500))
   RETURNS STRING
   LANGUAGE JAVASCRIPT
   EXECUTE AS OWNER
   AS
   $$
 	var sql_stmt = `UPDATE dbp_data.mk_zeroverkauf 
                  SET art_fehlgrund_id   = CASE WHEN ? IS NULL
                                          THEN art_fehlgrund_id                            --  bisherigen Grund beibehalten
                                          ELSE SUBSTRING(?, 1, 2)
                                          END
                  ,art_fehlgrund_text = ?
                  ,dat_erfasst        = CURRENT_TIMESTAMP(0)
WHERE mandant_id         = ?
AND wup_id             = ?
AND dat                = ?
AND zeitfenster_id     = ?
AND art_id             = ?
AND (SUBSTRING(?, 1, 2) <> 0  OR ? IS NULL)`;
snowflake.createStatement({
   sqlText : sql_stmt,
   binds : [ART_FEHLGRUND_BEZ,ART_FEHLGRUND_BEZ,ART_FEHLGRUND_TEXT,MANDANT_ID,WUP_ID,DAT.toISOString(),ZEITFENSTER_ID,ART_ID,ART_FEHLGRUND_BEZ,ART_FEHLGRUND_BEZ]
}).execute();
 var sql_commit = `COMMIT;`
   snowflake.createStatement({
	   sqlText : sql_commit
	}).execute();

$$;

