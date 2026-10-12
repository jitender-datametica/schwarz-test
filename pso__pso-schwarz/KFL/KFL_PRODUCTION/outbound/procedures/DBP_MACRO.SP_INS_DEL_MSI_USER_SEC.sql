CREATE OR REPLACE PROCEDURE dbp_macro.sp_ins_del_msi_user_sec(IN MANDANT_ID FLOAT64, IN USER_ID STRING, IN SEC_FG FLOAT64, IN MSI_PRODUKT_BEZ STRING)
BEGIN
DECLARE sql_commit STRING;
DECLARE sql_stmt STRING;
BEGIN TRANSACTION;
BEGIN

IF SEC_FG = 1 THEN
    BEGIN
    SET sql_stmt = '''MERGE INTO dbp_security.user_mandant_msiprodukt_zu AS target
                      USING (SELECT cast(@MANDANT_ID as INT64) AS mandant, @USER_ID AS ldap, @MSI_PRODUKT_BEZ AS msi_produkt) AS tab ON tab.mandant = target.mandant_id AND tab.ldap = target.user_id AND tab.msi_produkt = target.msi_produkt_bez WHEN NOT MATCHED THEN   INSERT (MANDANT_ID, USER_ID, MSI_PRODUKT_BEZ)   VALUES (tab.mandant, tab.ldap, tab.msi_produkt)''';   

    EXECUTE IMMEDIATE (sql_stmt) USING MANDANT_ID AS MANDANT_ID,  USER_ID AS USER_ID,  MSI_PRODUKT_BEZ AS MSI_PRODUKT_BEZ;

    END;
ELSE
    BEGIN

    IF SEC_FG = 0 THEN
        BEGIN
        SET sql_stmt  =  '''DELETE FROM dbp_security.user_mandant_msiprodukt_zu WHERE mandant_id = cast(@MANDANT_ID as INT64) AND user_id = @USER_ID AND msi_produkt_bez = @MSI_PRODUKT_BEZ''';

        EXECUTE IMMEDIATE (sql_stmt) USING MANDANT_ID AS MANDANT_ID,  USER_ID AS USER_ID,  MSI_PRODUKT_BEZ AS MSI_PRODUKT_BEZ;

        END;
    END IF;

    END;
END IF;

SET sql_commit  =  'COMMIT TRANSACTION';

EXECUTE IMMEDIATE (sql_commit);
END;
END;

