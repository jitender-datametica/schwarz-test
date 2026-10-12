CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_log.mv_in_lagerort_1 (in_lagerort_id, werk_id, in_lagerort_bez) AS
SELECT in_lagerort_id,
 werk_id,
 in_lagerort_bez
FROM kfl_production_dbp_view.v_in_lagerort_1
GROUP BY in_lagerort_id,
 werk_id,
 in_lagerort_bez;