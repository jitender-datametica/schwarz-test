CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_lbs.mv_monat_status (status_id, status_bez) AS SELECT status_id,
 status_bez
FROM (SELECT 1 AS status_id,
    'abgeschlossene Monate' AS status_bez
   UNION ALL
   SELECT 0 AS status_id,
    'nicht abgeschlossene Monate' AS status_bez);