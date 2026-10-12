CREATE OR REPLACE PROCEDURE dbp_macro.m_upd_artikel_zuordnung(IN S_MANDANT_ID FLOAT64, IN S_EAN_ID FLOAT64, IN S_ART_ID FLOAT64, IN S_WG_ID FLOAT64, IN S_WUG_ID FLOAT64)
BEGIN
DECLARE sql_stmt STRING;
DECLARE sql_commit STRING;
BEGIN TRANSACTION;
--ABORT 'ACHTUNG: eingegebene EAN_1  existiert bereits.'
--WHERE :s_ean_id IN (SELECT ean_id FROM );
-- Neuen Satz hinzufÃ¼gen
SET sql_stmt  =  '''INSERT INTO dbp_data.ts_artikel_zuordnung_1 (mandant_id, ean_id, art_id, wg_id, wug_id) (SELECT CAST(@S_MANDANT_ID AS INTEGER) AS mandant_id,   CAST(@S_EAN_ID AS INT64)  AS ean_id,   CAST(@S_ART_ID AS INTEGER) AS art_id,   CAST(@S_WG_ID AS INTEGER) AS wg_id,   CAST(@S_WUG_ID AS INTEGER) AS wug_id) ''';

EXECUTE IMMEDIATE (sql_stmt) USING S_MANDANT_ID AS S_MANDANT_ID,  S_EAN_ID AS S_EAN_ID,  S_ART_ID AS S_ART_ID,  S_WG_ID AS S_WG_ID,  S_WUG_ID AS S_WUG_ID;

SET sql_commit  =  'COMMIT TRANSACTION';

EXECUTE IMMEDIATE (sql_commit);
END;
