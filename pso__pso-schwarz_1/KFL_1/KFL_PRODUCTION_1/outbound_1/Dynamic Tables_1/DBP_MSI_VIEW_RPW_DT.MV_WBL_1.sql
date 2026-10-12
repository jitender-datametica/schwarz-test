CREATE OR REPLACE MATERIALIZED VIEW dbp_msi_view_rpw_dt.mv_wbl_1
OPTIONS(ENABLE_REFRESH = TRUE, REFRESH_INTERVAL_MINUTES = 90) AS
SELECT wbl_id,
 mandant_id,
 wbl_dat_von,
 wbl_name,
 gf_id,
 ek_fg,
 7 AS system_id
FROM kfl_production_dbp_view.v_wbl_1
WHERE mandant_id = 1;