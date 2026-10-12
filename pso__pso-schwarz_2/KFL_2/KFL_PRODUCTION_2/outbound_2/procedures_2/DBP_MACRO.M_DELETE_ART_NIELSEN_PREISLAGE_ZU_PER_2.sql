CREATE OR REPLACE PROCEDURE dbp_macro.m_delete_art_nielsen_preislage_zu_per(IN MANDANT_ID FLOAT64, IN ART_MATCHING_ID FLOAT64)
BEGIN
DECLARE sql_stmt STRING;
DECLARE sql_commit STRING;
BEGIN TRANSACTION;
SET sql_stmt  =  '''DELETE FROM dbp_data.art_nielsen_preislage_zu_per_2 WHERE mandant_id = @MANDANT_ID AND art_matching_id = @ART_MATCHING_ID''';

EXECUTE IMMEDIATE (sql_stmt) USING MANDANT_ID AS MANDANT_ID,  ART_MATCHING_ID AS ART_MATCHING_ID;

SET sql_commit  =  'COMMIT TRANSACTION';

EXECUTE IMMEDIATE (sql_commit);
END;
