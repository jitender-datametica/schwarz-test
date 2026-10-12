CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_scm_materialized.mv_pmr_werbethema (pmr_werbethema_id,
pmr_werbethema_bez) AS SELECT pmr_werbethema_id,
 pmr_werbethema_bez
FROM kfl_production_dbp_view.v_pmr_werbethema AS V01
UNION ALL
SELECT '0',
 ' ';