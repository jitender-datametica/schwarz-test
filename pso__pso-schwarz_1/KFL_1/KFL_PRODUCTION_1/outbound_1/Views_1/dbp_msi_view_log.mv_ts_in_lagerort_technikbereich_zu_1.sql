CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_log.mv_ts_in_lagerort_technikbereich_zu_1 (mandant_id, werk_id,
in_lagerort_id, technikbereich_bez) AS SELECT mandant_id,
 werk_id,
 in_lagerort_id,
 technikbereich_bez
FROM kfl_production_dbp_msi_view_log.v_ts_in_lagerort_technikbereich_zu_1;