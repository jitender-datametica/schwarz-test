CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_log.mv_l_tms_richtung_2 (richtung_id, richtung_bez) AS SELECT 1 AS
 richtung_id,
 'OneWay' AS richtung_bez
UNION ALL
SELECT 2 AS richtung_id,
 'Rundlauf' AS richtung_bez
UNION ALL
SELECT 3 AS richtung_id,
 'Sonstige' AS richtung_bez
UNION ALL
SELECT 4 AS richtung_id,
 'Industrieabholung' AS richtung_bez;