CREATE OR REPLACE PROCEDURE dbp_macro.sp_ins_del_user_hr_objekt_id_zu(IN MANDANT_ID FLOAT64, IN HR_OBJEKT_EBENE1_ID FLOAT64, IN USER_ID STRING, IN PFLEGE_FG FLOAT64)
BEGIN
DECLARE sql_commit STRING;
DECLARE sql_stmt STRING;
BEGIN
BEGIN TRANSACTION;

IF PFLEGE_FG = 1 THEN
    BEGIN
    --MERGE INTO dbe_fed.user_hr_objekt_id_zu_test

    SET sql_stmt  =  '''MERGE INTO dbp_security.user_hr_objekt_id_zu as t1 
                        USING ( SELECT CAST(@MANDANT_ID AS INT64) AS mandant_id
                                    ,CAST(@HR_OBJEKT_EBENE1_ID AS INT64) AS hr_objekt_ebene1_id
                                    ,@USER_ID AS user_id  ) AS tab 
                    ON 	t1.mandant_id = tab.mandant_id 
                    AND	t1.user_id = tab.user_id 
                    AND	t1.hr_objekt_ebene1_id = tab.hr_objekt_ebene1_id
		            WHEN NOT MATCHED THEN
                	INSERT (mandant_id, hr_objekt_ebene1_id, user_id)
	                    VALUES (tab.mandant_id
                                    ,tab.hr_objekt_ebene1_id
                                    ,tab.user_id)''';

                                    
                                
    EXECUTE IMMEDIATE (sql_stmt) USING MANDANT_ID AS MANDANT_ID, HR_OBJEKT_EBENE1_ID AS HR_OBJEKT_EBENE1_ID, USER_ID AS USER_ID,  PFLEGE_FG AS PFLEGE_FG;
    END;
    
ELSE
    BEGIN
    IF PFLEGE_FG = 0 THEN
        BEGIN

        --Conversion warning - One or more identifiers in this statement were considered parameters by default. Referenced table not found.
        --DELETE FROM dbe_fed.user_hr_objekt_id_zu_test

SET sql_stmt  =  '''DELETE FROM dbp_security.user_hr_objekt_id_zu WHERE user_id = @USER_ID AND mandant_id = CAST(@MANDANT_ID AS INT64) AND hr_objekt_ebene1_id = CAST(@HR_OBJEKT_EBENE1_ID AS INT64) ''';

        EXECUTE IMMEDIATE (sql_stmt) USING MANDANT_ID AS MANDANT_ID, HR_OBJEKT_EBENE1_ID AS HR_OBJEKT_EBENE1_ID, USER_ID AS USER_ID;
        END;
    END IF;

    END;
END IF;

SET sql_commit  =  'COMMIT TRANSACTION';

EXECUTE IMMEDIATE (sql_commit);
END;
END;