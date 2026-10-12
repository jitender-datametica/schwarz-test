CREATE OR REPLACE PROCEDURE dbp_macro.sp_pflege_sec_user_mandant_zu(IN MANDANT_ID FLOAT64, IN USER_ID STRING, IN LOESCH_FG FLOAT64, IN MSI_PRODUKT STRING)
BEGIN
DECLARE var_loesch_fg FLOAT64;
DECLARE sql_stmt STRING;
DECLARE sql_commit STRING;
BEGIN
BEGIN TRANSACTION;
SET var_loesch_fg  =  LOESCH_FG;

IF CAST(var_loesch_fg AS FLOAT64) = 1 THEN
    BEGIN
    SET sql_stmt  =  '''DELETE FROM dbp_security.user_mandant_msiprodukt_zu WHERE mandant_id = @MANDANT_ID AND user_id = @USER_ID AND 1 = @LOESCH_FG AND msi_produkt_bez = @MSI_PRODUKT ''';

    EXECUTE IMMEDIATE (sql_stmt) USING MANDANT_ID AS MANDANT_ID,  USER_ID AS USER_ID,  LOESCH_FG AS LOESCH_FG,  MSI_PRODUKT AS MSI_PRODUKT;

    END;
END IF;


IF CAST(var_loesch_fg AS FLOAT64) = 0 THEN
    BEGIN
    SET sql_stmt  =  '''INSERT INTO dbp_security.user_mandant_msiprodukt_zu (mandant_id, user_id, msi_produkt_bez) (SELECT CAST(@MANDANT_ID AS INTEGER) AS mandant_id,   @USER_ID AS user_id,   @MSI_PRODUKT AS msi_produkt_bez) ''';

    EXECUTE IMMEDIATE (sql_stmt) USING MANDANT_ID AS MANDANT_ID,  USER_ID AS USER_ID,  MSI_PRODUKT AS MSI_PRODUKT;

    END;
END IF;

SET sql_stmt  =  '''TRUNCATE TABLE dbp_security.ios_mandant_usersequenz_zu ''';

EXECUTE IMMEDIATE (sql_stmt);
--Conversion warning - One or more identifiers in this statement were considered parameters by default. Referenced table not found.
SET sql_stmt  =  '''INSERT INTO dbp_security.ios_mandant_usersequenz_zu (mandant_id, usersequenz) (SELECT mandant_id,   STRING_AGG(TRIM(user_id) || "," ORDER BY user_id IS NULL, user_id) AS usersequenz  FROM dbp_security.user_mandant_msiprodukt_zu  WHERE msi_produkt_bez LIKE "IOS"  GROUP BY mandant_id) ''';

EXECUTE IMMEDIATE (sql_stmt);
SET sql_commit  =  'COMMIT TRANSACTION';

EXECUTE IMMEDIATE (sql_commit);
END;
END;

