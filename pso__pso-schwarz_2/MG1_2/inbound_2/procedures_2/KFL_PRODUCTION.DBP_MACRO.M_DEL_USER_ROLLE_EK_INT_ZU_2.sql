CREATE OR REPLACE PROCEDURE KFL_PRODUCTION.DBP_MACRO.M_DEL_USER_ROLLE_EK_INT_ZU(MANDANT_ID FLOAT, USER_ID VARCHAR, ROLLE_ID FLOAT, ZEK_ID VARCHAR, WBL_ID FLOAT, GF_ID FLOAT) 
    RETURNS VARCHAR(16777216) LANGUAGE JAVASCRIPT
    AS $$


 	var sql_stmt = `DELETE FROM dbp_security.user_rolle_ek_int_zu_2
	WHERE mandant_id = ` + MANDANT_ID + `
	AND user_id = '` + USER_ID + `'
	AND rolle_id = ` + ROLLE_ID + `
	AND (zek_id = '` + ZEK_ID + `' or zek_id is null)
	AND (wbl_id = ` + WBL_ID + ` or wbl_id is null)
	AND (gf_id = ` + GF_ID + ` or gf_id is null)`;
	
sql_stmt = sql_stmt.replace(/undefined/g, "NULL");

snowflake.createStatement({
	   sqlText : sql_stmt
	}).execute();
 

var sql_commit = `COMMIT;`
snowflake.createStatement({
	   sqlText : sql_commit
	}).execute();


    $$

