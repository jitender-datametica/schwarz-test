CREATE OR REPLACE PROCEDURE DBP_MACRO.M_UPDATE_SPARTE_STANDORT(SPARTE_ID FLOAT, MANDANT_ID FLOAT, STANDORT_ID FLOAT)
RETURNS VARCHAR(16777216)
LANGUAGE JAVASCRIPT
EXECUTE AS OWNER
AS '
 	
var sql_stmt = `UPDATE dbp_data.ims_standort_2 SET sparte_id = ?
               WHERE mandant_id = ? 
               AND standort_id  = CASE WHEN LENGTH(CAST(? AS VARCHAR(40))) < 4
               THEN TO_VARCHAR(?, ''FM0000'')
    ELSE CAST(? AS VARCHAR(40))
END`;
snowflake.createStatement({
   sqlText : sql_stmt,
   binds : [SPARTE_ID,MANDANT_ID,STANDORT_ID,STANDORT_ID,STANDORT_ID]
}).execute();
 var sql_commit = `COMMIT;`
   snowflake.createStatement({
	   sqlText : sql_commit
	}).execute();

';