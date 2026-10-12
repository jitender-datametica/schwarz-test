CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_log.mv_l_tms_tour_service_1 (tour_service_id, tour_service_bez) AS
SELECT 'TK' AS tour_service_id,
 'Tiko' AS tour_service_bez
UNION ALL
SELECT 'GK' AS tour_service_id,
 'Gekühlt' AS tour_service_bez
UNION ALL
SELECT 'TE' AS tour_service_id,
 'Temperaturgeführt' AS tour_service_bez
UNION ALL
SELECT 'UK' AS tour_service_id,
 'Ungekühlt' AS tour_service_bez;