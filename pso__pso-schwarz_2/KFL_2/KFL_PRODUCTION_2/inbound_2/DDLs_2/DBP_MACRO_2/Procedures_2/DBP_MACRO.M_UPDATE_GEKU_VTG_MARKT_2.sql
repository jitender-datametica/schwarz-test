CREATE OR REPLACE PROCEDURE dbp_macro.m_update_geku_vtg_markt (VERTEILGEBIET_UID FLOAT, WUP_ID FLOAT, MANDANT_ID FLOAT)
   RETURNS STRING
   LANGUAGE JAVASCRIPT
   EXECUTE AS OWNER
   AS
   $$
 	//Conversion warning - One or more identifiers in this statement were considered parameters by default. Referenced table not found.
var sql_stmt = `MERGE INTO dbp_data.geku_verteilgebiet_2 AS target
USING
(-- using select
SELECT
mandant_id,
nils_verteilgebiet_id
FROM dbp_data.vaus_wup_2
WHERE mandant_id = ?
AND wup_id = ?
) using_select 
ON target.VERTEILGEBIET_UID = ?

WHEN MATCHED THEN 
UPDATE SET  target.nils_verteilgebiet_id = using_select.nils_verteilgebiet_id
          , target.mandant_id = using_select.mandant_id`;
snowflake.createStatement({
   sqlText : sql_stmt,
   binds : [MANDANT_ID,WUP_ID,VERTEILGEBIET_UID]
}).execute();
 var sql_commit = `COMMIT;`
   snowflake.createStatement({
	   sqlText : sql_commit
	}).execute();

$$;

