CREATE OR REPLACE PROCEDURE DBP_MACRO.M_DELETE_TS_AUTODISPO_DIF_AGG("DATEINAME" VARCHAR(255), "DELETE_FG" FLOAT)
RETURNS VARCHAR(16777216)
LANGUAGE JAVASCRIPT
EXECUTE AS OWNER
AS $$

 	var sql_stmt = `
     DELETE FROM dbp_data.ts_autodispo_dif
     WHERE 
     dateiname           = ?
       AND 1                   = ?
       `;

sql_stmt = sql_stmt.replace(/undefined/g, "NULL");

snowflake.createStatement({
	   sqlText : sql_stmt,
       binds: [DATEINAME, DELETE_FG]
	}).execute();

var sql_commit = `COMMIT;`
snowflake.createStatement({
	   sqlText : sql_commit
	}).execute();

$$;