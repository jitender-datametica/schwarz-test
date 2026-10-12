CREATE OR REPLACE PROCEDURE dbp_macro.sp_in_user_ts_lin_gf_org_ebene(IN P_USER_ID STRING, IN P_HR_OBJEKT_EBENE2_ID FLOAT64, IN P_HR_OBJEKT_EBENE3_ID FLOAT64, IN P_HR_OBJEKT_EBENE4_ID FLOAT64)
BEGIN
DECLARE sql_commit STRING;
DECLARE SQL_INSERT STRING;
BEGIN TRANSACTION;
IF P_HR_OBJEKT_EBENE2_ID IS NOT NULL THEN
    BEGIN
    SET SQL_INSERT  =  '''INSERT INTO dbp_msi_data.ts_lin_gf_org_ebene_zu_1 (user_id, hr_objekt_ebene2_id) 
                          (SELECT @P_USER_ID AS user_id,   CAST(@P_HR_OBJEKT_EBENE2_ID AS INTEGER) AS hr_objekt_ebene2_id) ''';

    EXECUTE IMMEDIATE (SQL_INSERT) USING P_USER_ID AS P_USER_ID,  P_HR_OBJEKT_EBENE2_ID AS P_HR_OBJEKT_EBENE2_ID;

    END;
ELSE
    BEGIN

    IF P_HR_OBJEKT_EBENE3_ID IS NOT NULL THEN
        BEGIN
        SET SQL_INSERT  =  '''INSERT INTO dbp_msi_data.ts_lin_gf_org_ebene_zu_1 (user_id, hr_objekt_ebene3_id) 
                              (SELECT @P_USER_ID AS user_id,   CAST(@P_HR_OBJEKT_EBENE3_ID AS INTEGER) AS hr_objekt_ebene3_id) ''';

        EXECUTE IMMEDIATE (SQL_INSERT) USING P_USER_ID AS P_USER_ID,  P_HR_OBJEKT_EBENE3_ID AS P_HR_OBJEKT_EBENE3_ID;

        END;
    ELSE
        BEGIN

        IF P_HR_OBJEKT_EBENE4_ID IS NOT NULL THEN
            BEGIN
            SET SQL_INSERT  =  '''INSERT INTO dbp_msi_data.ts_lin_gf_org_ebene_zu_1 (user_id, hr_objekt_ebene4_id) 
                                  (SELECT @P_USER_ID AS user_id,   CAST(@P_HR_OBJEKT_EBENE4_ID AS INTEGER) AS hr_objekt_ebene4_id) ''';

            EXECUTE IMMEDIATE (SQL_INSERT) USING P_USER_ID AS P_USER_ID,  P_HR_OBJEKT_EBENE4_ID AS P_HR_OBJEKT_EBENE4_ID;

            END;
        END IF;

        END;
    END IF;

    END;
END IF;

SET sql_commit  =  'COMMIT TRANSACTION';

EXECUTE IMMEDIATE (sql_commit);
END;