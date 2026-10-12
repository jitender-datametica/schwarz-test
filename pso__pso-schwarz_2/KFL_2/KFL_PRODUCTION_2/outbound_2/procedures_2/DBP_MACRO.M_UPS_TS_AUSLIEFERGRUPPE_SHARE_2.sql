CREATE OR REPLACE PROCEDURE dbp_macro.m_ups_ts_ausliefergruppe_share(IN MANDANT_ID FLOAT64, IN AUSLIEFERGRUPPE_ID STRING, IN RANK_SHARE FLOAT64, IN SHARE_WERT FLOAT64)
BEGIN
DECLARE sql_stmt STRING;
DECLARE sql_delete STRING;
DECLARE sql_commit STRING;

BEGIN TRANSACTION;
SET sql_stmt  =  '''MERGE INTO dbp_data.ts_wbs_ausliefergruppe_share AS TARGET 
                    USING (SELECT @MANDANT_ID AS mandant_id,@AUSLIEFERGRUPPE_ID AS ausliefergruppe_id,@RANK_SHARE AS rank_share,
                    @SHARE_WERT AS share_wert) AS source 
                    ON TARGET.mandant_id = source.mandant_id AND TARGET.ausliefergruppe_id = source.ausliefergruppe_id 
                    AND TARGET.rank_share    = source.rank_share 
                    WHEN MATCHED THEN UPDATE 
                    SET  share_wert = ROUND(CAST(source.share_wert AS BIGNUMERIC), 0) 
                    WHEN NOT MATCHED THEN INSERT (mandant_id, ausliefergruppe_id, rank_share, share_wert) 
                    VALUES(ROUND(CAST(source.mandant_id AS BIGNUMERIC)   , 0), source.ausliefergruppe_id, 
                    ROUND(CAST(source.rank_share AS BIGNUMERIC), 0), ROUND(CAST(source.share_wert AS BIGNUMERIC)   , 0)) ''';

EXECUTE IMMEDIATE (sql_stmt) USING IF(MANDANT_ID = CAST(NULL AS FLOAT64), CAST(NULL AS FLOAT64), MANDANT_ID) AS MANDANT_ID,  IF(AUSLIEFERGRUPPE_ID = CAST(NULL AS STRING), CAST(NULL AS STRING), AUSLIEFERGRUPPE_ID) AS AUSLIEFERGRUPPE_ID,  IF(RANK_SHARE = CAST(NULL AS FLOAT64), CAST(NULL AS FLOAT64), RANK_SHARE) AS RANK_SHARE,  IF(SHARE_WERT = CAST(NULL AS FLOAT64), CAST(NULL AS FLOAT64), SHARE_WERT) AS SHARE_WERT;

SET sql_delete  =  '''DELETE FROM dbp_data.ts_wbs_ausliefergruppe_share WHERE mandant_id = @MANDANT_ID  AND  ausliefergruppe_id = @AUSLIEFERGRUPPE_ID AND rank_share = @RANK_SHARE AND share_wert = @SHARE_WERT''';

EXECUTE IMMEDIATE (sql_delete) USING IF(MANDANT_ID = CAST(NULL AS FLOAT64), CAST(NULL AS FLOAT64), MANDANT_ID) AS MANDANT_ID,  IF(AUSLIEFERGRUPPE_ID = CAST(NULL AS STRING), CAST(NULL AS STRING), AUSLIEFERGRUPPE_ID) AS AUSLIEFERGRUPPE_ID,  IF(RANK_SHARE = CAST(NULL AS FLOAT64), CAST(NULL AS FLOAT64), RANK_SHARE) AS RANK_SHARE,  IF(SHARE_WERT = CAST(NULL AS FLOAT64), CAST(NULL AS FLOAT64), SHARE_WERT) AS SHARE_WERT;

SET sql_commit  =  'COMMIT TRANSACTION';

EXECUTE IMMEDIATE (sql_commit);
END;