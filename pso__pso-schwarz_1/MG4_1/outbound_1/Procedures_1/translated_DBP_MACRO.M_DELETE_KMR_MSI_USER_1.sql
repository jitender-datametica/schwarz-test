CREATE OR REPLACE PROCEDURE kfl_production_dbp_macro.m_delete_kmr_msi_user(IN USER_ID STRING, IN MSI_PRODUKT_BEZ STRING, IN LOESCH_FG FLOAT64)
BEGIN
DECLARE sql_stmt STRING;
DECLARE sql_stmt1 STRING;
DECLARE sql_commit STRING;
SET sql_stmt  =  '''DELETE FROM kfl_production_dbp_security.ts_kmr_user_security_filter_zu_1 WHERE @LOESCH_FG = 1 AND user_id =@USER_ID;''';

EXECUTE IMMEDIATE (sql_stmt) USING USER_ID AS USER_ID,  LOESCH_FG AS LOESCH_FG;

SET sql_stmt1  =  '''DELETE FROM kfl_production_dbp_security.l_msi_user_1 WHERE user_id = @USER_ID_1 AND @LOESCH_FG_1 = 1 AND msi_produkt_bez =@MSI_PRODUKT_BEZ;''';

EXECUTE IMMEDIATE (sql_stmt1) USING USER_ID AS USER_ID,  MSI_PRODUKT_BEZ AS MSI_PRODUKT_BEZ,  LOESCH_FG AS LOESCH_FG;

SET sql_commit  =  '''COMMIT TRANSACTION;''';

EXECUTE IMMEDIATE (sql_commit);
END;