CREATE OR REPLACE PROCEDURE dbp_macro.m_ups_kl_wg_nielsen_gfk_hhp_wg_zu(IN MANDANT_ID FLOAT64, IN KL_WG_ID FLOAT64, IN GFK_WG_ID FLOAT64)
BEGIN
DECLARE sql_stmt STRING;
DECLARE sql_commit STRING;

BEGIN TRANSACTION;
SET sql_stmt  =  '''MERGE INTO dbp_data.kl_wg_nielsen_gfk_hhp_wg_zu_1 AS TARGET 
                    USING (SELECT @MANDANT_ID AS mandant_id,   @KL_WG_ID AS kl_wg_id,   @GFK_WG_ID AS gfk_wg_id) AS source 
                    ON TARGET.mandant_id = source.mandant_id AND TARGET.kl_wg_id = source.kl_wg_id AND TARGET.gfk_wg_id = source.gfk_wg_id           WHEN MATCHED THEN UPDATE 
                    SET  kl_wg_id = CAST(@KL_WG_ID_1 AS INTEGER),  gfk_wg_id = CAST(@GFK_WG_ID_1 AS INTEGER) 
                    WHEN NOT MATCHED THEN 
                    INSERT (mandant_id, kl_wg_id, gfk_wg_id) 
                    VALUES(CAST(@MANDANT_ID_1 AS INTEGER), CAST(@KL_WG_ID_1_2 AS INTEGER)  , CAST(@GFK_WG_ID_1_2 AS INTEGER)) ''';

EXECUTE IMMEDIATE (sql_stmt) USING MANDANT_ID AS MANDANT_ID,  KL_WG_ID AS KL_WG_ID,  GFK_WG_ID AS GFK_WG_ID,  KL_WG_ID AS KL_WG_ID_1,  GFK_WG_ID AS GFK_WG_ID_1,  MANDANT_ID AS MANDANT_ID_1,  KL_WG_ID AS KL_WG_ID_1_2,  GFK_WG_ID AS GFK_WG_ID_1_2;

SET sql_commit  =  'COMMIT TRANSACTION';

EXECUTE IMMEDIATE (sql_commit);
END;