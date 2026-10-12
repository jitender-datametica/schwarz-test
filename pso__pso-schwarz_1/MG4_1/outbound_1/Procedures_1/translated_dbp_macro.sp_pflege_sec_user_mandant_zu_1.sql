CREATE OR REPLACE PROCEDURE kfl_production_dbp_macro.sp_pflege_sec_user_mandant_zu(IN MANDANT_ID FLOAT64, IN USER_ID STRING, IN LOESCH_FG FLOAT64, IN MSI_PRODUKT STRING)
BEGIN
BEGIN TRANSACTION;
DECLARE var_loesch_fg FLOAT64;
DECLARE sql_stmt STRING;
DECLARE sql_commit STRING;
SET var_loesch_fg  =  LOESCH_FG;

BEGIN TRANSACTION;

IF CAST(var_loesch_fg AS FLOAT64) = 1 THEN
    BEGIN

    set sql_stmt = '''DELETE FROM kfl_production_dbp_security.user_mandant_msiprodukt_zu_1
WHERE mandant_id = ?  AND user_id = ?  AND 1 = ?  AND msi_produkt_bez = ?''';

    EXECUTE IMMEDIATE (sql_stmt) USING MANDANT_ID,  USER_ID,  LOESCH_FG,  MSI_PRODUKT;

    END;
END IF;


IF CAST(var_loesch_fg AS FLOAT64) = 0 THEN
    BEGIN

    SET sql_stmt  =  '''INSERT INTO kfl_production_dbp_security.user_mandant_msiprodukt_zu_1 (mandant_id, user_id, msi_produkt_bez)
                     VALUES (  ?   ,?   , ?)''';

    EXECUTE IMMEDIATE (sql_stmt) USING MANDANT_ID ,  USER_ID ,  MSI_PRODUKT ;

    END;
END IF;

SET sql_stmt  =  '''TRUNCATE TABLE kfl_production_dbp_security.ios_mandant_usersequenz_zu_1;''';

EXECUTE IMMEDIATE (sql_stmt);
--Conversion warning - One or more identifiers in this statement were considered parameters by default. Referenced table not found.
SET sql_stmt = ''' INSERT INTO kfl_production_dbp_security.ios_mandant_usersequenz_zu_1 (mandant_id, usersequenz)
(select mandant_id,
  string_agg(trim(user_id) || ',' order by user_id is null, user_id) as usersequenz
 from kfl_production_dbp_security.user_mandant_msiprodukt_zu_1
 where msi_produkt_bez like 'ios'
 group by mandant_id);''';

EXECUTE IMMEDIATE (sql_stmt);
SET sql_commit  =  'COMMIT TRANSACTION';

EXECUTE IMMEDIATE (sql_commit);
END;
