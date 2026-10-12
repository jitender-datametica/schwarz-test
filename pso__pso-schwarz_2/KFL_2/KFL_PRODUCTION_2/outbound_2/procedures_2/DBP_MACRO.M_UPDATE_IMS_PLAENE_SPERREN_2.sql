CREATE OR REPLACE PROCEDURE dbp_macro.m_update_ims_plaene_sperren(IN GJ FLOAT64, IN MANDANT_ID FLOAT64, IN SPERR_FG FLOAT64)
BEGIN
DECLARE sql_stmt STRING;
DECLARE sql_commit STRING;

BEGIN TRANSACTION;
SET sql_stmt  =  '''UPDATE dbp_data.ims_invest_plan_2 SET  sperr_fg = CAST(@SPERR_FG AS INT64) WHERE hr_plan_gesamt_kz = 0 AND mandant_id = @MANDANT_ID AND gj = @GJ ''';

EXECUTE IMMEDIATE (sql_stmt) USING SPERR_FG AS SPERR_FG,  MANDANT_ID AS MANDANT_ID,  GJ AS GJ;

SET sql_commit  =  'COMMIT TRANSACTION';

EXECUTE IMMEDIATE (sql_commit);
END;
