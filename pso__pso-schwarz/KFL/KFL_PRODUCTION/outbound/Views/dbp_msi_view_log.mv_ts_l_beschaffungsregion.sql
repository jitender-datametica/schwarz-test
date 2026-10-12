CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_log.mv_ts_l_beschaffungsregion (besch_region_id, besch_region_bez) AS
SELECT besch_region_id,
 besch_region_bez
FROM kfl_production_dbp_msi_data.ts_l_beschaffungsregion
UNION DISTINCT
SELECT - 1,
 'n/a';