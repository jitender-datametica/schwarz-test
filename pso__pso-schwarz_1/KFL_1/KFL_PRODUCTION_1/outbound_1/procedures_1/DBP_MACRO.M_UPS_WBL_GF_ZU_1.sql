CREATE OR REPLACE PROCEDURE dbp_macro.m_ups_wbl_gf_zu(IN MANDANT_ID FLOAT64, IN WBL_ID FLOAT64, IN GF_ID FLOAT64)
BEGIN
DECLARE sql_stmt STRING;
DECLARE sql_commit STRING;

BEGIN TRANSACTION;
SET sql_stmt  =  '''MERGE INTO dbp_security.wbl_gf_zu_1 AS TARGET 
                    USING (SELECT @MANDANT_ID AS mandant_id,   @WBL_ID AS wbl_id,   @GF_ID AS gf_id) AS source 
                    ON TARGET.mandant_id = source.mandant_id AND TARGET.wbl_id = source.wbl_id 
                    WHEN MATCHED THEN UPDATE 
                    SET  gf_id = CAST(source.gf_id AS INTEGER) 
                    WHEN NOT MATCHED THEN INSERT (mandant_id, wbl_id, gf_id) 
                    VALUES(CAST(source.mandant_id AS INTEGER), CAST(source.wbl_id AS INTEGER)  , CAST(source.gf_id AS INTEGER)) ''';

EXECUTE IMMEDIATE (sql_stmt) USING MANDANT_ID AS MANDANT_ID,  WBL_ID AS WBL_ID,  GF_ID AS GF_ID;

SET sql_commit  =  'COMMIT TRANSACTION';

EXECUTE IMMEDIATE (sql_commit);
END;