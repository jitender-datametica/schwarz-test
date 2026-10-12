CREATE OR REPLACE PROCEDURE dbp_macro.sp_ins_del_msi_user_sec_kz_kmr(IN P_SEC_KZ STRING, IN P_USER_ID STRING, IN P_SEC_FG FLOAT64)
BEGIN

DECLARE sql_commit STRING;
DECLARE sql_stmt STRING;
BEGIN TRANSACTION;

IF P_SEC_FG = 1 THEN
    BEGIN
    
    
    SET sql_stmt  =  '''MERGE INTO dbp_msi_data.ts_kmr_user_sec_kz_zu_2 AS TARGET 
                        USING (SELECT @P_SEC_KZ AS sec,   @P_USER_ID AS ldap) AS t0 
                        ON t0.ldap = TARGET.user_id 
                        AND t0.sec = CAST(TARGET.sec_kz AS STRING) 
                        WHEN NOT MATCHED THEN INSERT 
                        VALUES(t0.ldap , CAST(t0.sec AS INT64));''';

    EXECUTE IMMEDIATE (sql_stmt) USING P_SEC_KZ AS P_SEC_KZ,  P_USER_ID AS P_USER_ID;

    END;
ELSE
    BEGIN

    IF P_SEC_FG = 0 THEN
        BEGIN
      
        SET sql_stmt  =  '''DELETE FROM dbp_msi_data.ts_kmr_user_sec_kz_zu_2 WHERE sec_kz = CAST(@P_SEC_KZ AS FLOAT64) AND user_id = @P_USER_ID ''';

        EXECUTE IMMEDIATE (sql_stmt) USING P_SEC_KZ AS P_SEC_KZ,  P_USER_ID AS P_USER_ID;

        END;
    END IF;

    END;
END IF;

SET sql_commit  =  'COMMIT TRANSACTION';

EXECUTE IMMEDIATE (sql_commit);
END;