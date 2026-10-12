CREATE OR REPLACE PROCEDURE dbp_macro.sp_del_user_ts_lin_gf_org_ebene(IN P_USER_ID STRING, IN P_HR_OBJEKT_EBENE2_ID FLOAT64, IN P_HR_OBJEKT_EBENE3_ID FLOAT64, IN P_HR_OBJEKT_EBENE4_ID FLOAT64, IN P_LOESCH_FG FLOAT64)
BEGIN
DECLARE sql_commit STRING;
DECLARE SQL_delete STRING;
BEGIN TRANSACTION;
IF  P_LOESCH_FG  =  1
 THEN
    BEGIN

    IF P_HR_OBJEKT_EBENE2_ID IS NOT NULL THEN
        BEGIN
        SET SQL_delete  =  '''DELETE FROM dbp_msi_data.ts_lin_gf_org_ebene_zu WHERE user_id = @P_USER_ID AND hr_objekt_ebene2_id = @P_HR_OBJEKT_EBENE2_ID ''';

        EXECUTE IMMEDIATE (SQL_delete) USING P_USER_ID AS P_USER_ID,  P_HR_OBJEKT_EBENE2_ID AS P_HR_OBJEKT_EBENE2_ID;

        END;
    ELSE
        BEGIN

        IF P_HR_OBJEKT_EBENE3_ID IS NOT NULL THEN
            BEGIN
            SET SQL_delete  =  '''DELETE FROM dbp_msi_data.ts_lin_gf_org_ebene_zu WHERE user_id = @P_USER_ID AND hr_objekt_ebene3_id = @P_HR_OBJEKT_EBENE3_ID ''';

            EXECUTE IMMEDIATE (SQL_delete) USING P_USER_ID AS P_USER_ID,  P_HR_OBJEKT_EBENE3_ID AS P_HR_OBJEKT_EBENE3_ID;

            END;
        ELSE
            BEGIN

            IF P_HR_OBJEKT_EBENE4_ID IS NOT NULL THEN
                BEGIN
                SET SQL_delete  =  '''DELETE FROM dbp_msi_data.ts_lin_gf_org_ebene_zu WHERE user_id = @P_USER_ID AND hr_objekt_ebene4_id = @P_HR_OBJEKT_EBENE4_ID ''';

                EXECUTE IMMEDIATE (SQL_delete) USING P_USER_ID AS P_USER_ID,  P_HR_OBJEKT_EBENE4_ID AS P_HR_OBJEKT_EBENE4_ID;

                END;
            END IF;

            END;
        END IF;

        END;
    END IF;

    SET sql_commit  =  'COMMIT TRANSACTION'    ;

    EXECUTE IMMEDIATE (sql_commit );
    END;
END IF;

END;
BEGIN
CALL `dbp_macro.sp_del_user_ts_lin_gf_org_ebene`(
  'USER_ID_12345',  -- P_USER_ID (STRING)
  10.0,             -- P_HR_OBJEKT_EBENE2_ID (FLOAT64)
  105.0,            -- P_HR_OBJEKT_EBENE3_ID (FLOAT64)
  10501.0,          -- P_HR_OBJEKT_EBENE4_ID (FLOAT64)
  1.0               -- P_LOESCH_FG (FLOAT64: 1.0 for delete, 0.0 for ignore)
);
END;
