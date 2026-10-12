CREATE OR REPLACE PROCEDURE dbp_macro.sp_ins_del_msi_user_projektsec_ims(IN IT_PROJEKT_ID STRING, IN USER_ID STRING, IN SEC_FG FLOAT64)
BEGIN
DECLARE sql_commit STRING;
DECLARE sql_stmt STRING;
BEGIN
BEGIN TRANSACTION;
IF SEC_FG = 1 THEN
    BEGIN
    SET sql_stmt  =  '''MERGE INTO dbp_security.l_ims_user_it_projekt_2 AS TARGET USING (SELECT @USER_ID AS ldap,   @IT_PROJEKT_ID AS it_projekt_2) AS tab ON tab.ldap = TARGET.user_id AND tab.it_projekt_2 = TARGET.it_projekt_id WHEN NOT MATCHED THEN INSERT VALUES(tab.ldap, tab.it_projekt_2, CAST(NULL AS TIMESTAMP), CAST(NULL AS TIMESTAMP)  ) ''';

    EXECUTE IMMEDIATE (sql_stmt) USING USER_ID AS USER_ID,  IT_PROJEKT_ID AS IT_PROJEKT_ID;

    END;
ELSE
    BEGIN

    IF SEC_FG = 0 THEN
        BEGIN
        SET sql_stmt  =  '''DELETE FROM dbp_security.l_ims_user_it_projekt_2 WHERE user_id= @USER_ID AND it_projekt_id = @IT_PROJEKT_ID ''';

        EXECUTE IMMEDIATE (sql_stmt) USING USER_ID AS USER_ID,  IT_PROJEKT_ID AS IT_PROJEKT_ID;

        END;
    END IF;

    END;
END IF;

SET sql_commit  =  'COMMIT TRANSACTION';

EXECUTE IMMEDIATE (sql_commit);
END;
END;
