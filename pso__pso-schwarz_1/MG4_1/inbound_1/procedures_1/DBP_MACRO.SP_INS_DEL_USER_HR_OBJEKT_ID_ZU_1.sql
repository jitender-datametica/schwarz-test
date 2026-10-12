CREATE OR REPLACE PROCEDURE DBP_MACRO.SP_INS_DEL_USER_HR_OBJEKT_ID_ZU
(MANDANT_ID FLOAT, HR_OBJEKT_EBENE1_ID FLOAT, USER_ID VARCHAR, PFLEGE_FG FLOAT)
RETURNS VARCHAR(16777216)
LANGUAGE JAVASCRIPT
EXECUTE AS OWNER
AS $$
 	{
	   if (PFLEGE_FG == 1) {
	      //MERGE INTO dbe_fed.user_hr_objekt_id_zu_test
	      var sql_stmt = `MERGE INTO dbp_security.user_hr_objekt_id_zu_1 as t1_1 
                        USING VALUES (` + MANDANT_ID + `
                                    ,` + HR_OBJEKT_EBENE1_ID + `
                                    ,'` + USER_ID + `' ) AS tab 
                    ON 	t1.mandant_id = ` + MANDANT_ID + ` 
                    AND	t1.user_id = '` + USER_ID + `' 
                    AND	t1.hr_objekt_ebene1_id = ` + HR_OBJEKT_EBENE1_ID + `
		            WHEN NOT MATCHED THEN
                	INSERT (MANDANT_ID, HR_OBJEKT_EBENE1_ID, USER_ID)
	                    VALUES (` + MANDANT_ID + `
                                , ` + HR_OBJEKT_EBENE1_ID + `
                                , '` + USER_ID + `')`;
	      snowflake.createStatement({
	         sqlText : sql_stmt
	      }).execute();
	   } else if (PFLEGE_FG == 0) {
	      //Conversion warning - One or more identifiers in this statement were considered parameters by default. Referenced table not found.
	      //DELETE FROM dbe_fed.user_hr_objekt_id_zu_test
	      var sql_stmt = `DELETE FROM dbp_security.user_hr_objekt_id_zu_1
                    	WHERE mandant_id =` + MANDANT_ID + `
	                    AND user_id ='` + USER_ID + `'
	                    AND hr_objekt_ebene1_id =` + HR_OBJEKT_EBENE1_ID;
	      snowflake.createStatement({
	         sqlText : sql_stmt
	      }).execute();
	   }

	   var sql_commit = `COMMIT;`
   snowflake.createStatement({
	   sqlText : sql_commit
	}).execute();
	}
 
$$;