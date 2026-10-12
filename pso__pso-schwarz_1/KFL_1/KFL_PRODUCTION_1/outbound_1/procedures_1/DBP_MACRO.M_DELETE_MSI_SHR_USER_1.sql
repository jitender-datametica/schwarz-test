CREATE OR REPLACE PROCEDURE dbp_macro.m_delete_msi_shr_user(IN USER_ID STRING, IN MSI_PRODUKT_BEZ STRING, IN LOESCH_FG FLOAT64)


BEGIN

DECLARE sql_stmt STRING;
DECLARE sql_commit STRING;

BEGIN TRANSACTION;
--DELETE FROM dbx_fed.user_hr_objekt_id_zu_test

SET sql_stmt  =  '''DELETE FROM dbp_security.user_hr_objekt_id_zu_1 WHERE @LOESCH_FG = 1 AND user_id = @USER_ID ''';

EXECUTE IMMEDIATE (sql_stmt) USING USER_ID AS USER_ID,  LOESCH_FG AS LOESCH_FG;

--DELETE FROM dbx_fed.l_msi_user_1
SET sql_stmt  =  '''DELETE FROM dbp_security.l_msi_user_1 WHERE @LOESCH_FG = 1 AND user_id =@USER_ID AND msi_produkt_bez = @MSI_PRODUKT_BEZ ''';

EXECUTE IMMEDIATE (sql_stmt) USING USER_ID AS USER_ID,  MSI_PRODUKT_BEZ AS MSI_PRODUKT_BEZ,  LOESCH_FG AS LOESCH_FG;

SET sql_commit  =  'COMMIT TRANSACTION';

EXECUTE IMMEDIATE (sql_commit);
END;