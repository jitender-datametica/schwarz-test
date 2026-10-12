CREATE OR REPLACE PROCEDURE dbp_macro.m_ups_rohertrag_kommentar_ww_zu(IN MANDANT_ID FLOAT64, IN KJWO_WW FLOAT64, IN KOMMENTAR STRING)
BEGIN
DECLARE sql_stmt STRING;
DECLARE sql_commit STRING;

BEGIN TRANSACTION;
SET sql_stmt  =  '''MERGE INTO dbp_msi_view_reb.ts_rohertrag_kommentar_ww_zu_1 AS TARGET 
                    USING (SELECT @MANDANT_ID AS mandant_id,   @KJWO_WW AS kjwo_ww,   @KOMMENTAR AS kommentar) AS source 
                    ON TARGET.mandant_id = source.mandant_id AND TARGET.kjwo_ww = source.kjwo_ww 
                    WHEN MATCHED THEN UPDATE 
                    SET  kommentar = @KOMMENTAR_1 
                    WHEN NOT MATCHED THEN INSERT 
                    VALUES(CAST(@MANDANT_ID_1 AS INTEGER), CAST(@KJWO_WW_1 AS INTEGER), @KOMMENTAR_1_2) ''';

EXECUTE IMMEDIATE (sql_stmt) USING MANDANT_ID AS MANDANT_ID,  KJWO_WW AS KJWO_WW,  KOMMENTAR AS KOMMENTAR,  KOMMENTAR AS KOMMENTAR_1,  MANDANT_ID AS MANDANT_ID_1,  KJWO_WW AS KJWO_WW_1,  KOMMENTAR AS KOMMENTAR_1_2;

SET sql_commit  =  'COMMIT TRANSACTION';

EXECUTE IMMEDIATE (sql_commit);
END;