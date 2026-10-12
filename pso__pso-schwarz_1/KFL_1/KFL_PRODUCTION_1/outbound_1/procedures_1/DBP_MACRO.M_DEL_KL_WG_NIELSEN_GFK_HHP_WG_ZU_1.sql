CREATE OR REPLACE PROCEDURE dbp_macro.m_del_kl_wg_nielsen_gfk_hhp_wg_zu(IN MANDANT_ID FLOAT64, IN KL_WG_ID FLOAT64, IN GFK_WG_ID FLOAT64)
BEGIN
DECLARE sql_stmt STRING;
DECLARE sql_commit STRING;
BEGIN TRANSACTION;
SET sql_stmt  =  '''DELETE FROM dbp_data.kl_wg_nielsen_gfk_hhp_wg_zu_1 WHERE mandant_id= @MANDANT_ID AND kl_wg_id= @KL_WG_ID AND gfk_wg_id=@GFK_WG_ID ''';

EXECUTE IMMEDIATE (sql_stmt) USING MANDANT_ID AS MANDANT_ID,  KL_WG_ID AS KL_WG_ID,  GFK_WG_ID AS GFK_WG_ID;

SET sql_commit  =  'COMMIT TRANSACTION';

EXECUTE IMMEDIATE (sql_commit);
END;
