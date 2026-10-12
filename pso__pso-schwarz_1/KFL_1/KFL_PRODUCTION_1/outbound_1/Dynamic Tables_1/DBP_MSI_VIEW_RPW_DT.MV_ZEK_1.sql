CREATE OR REPLACE MATERIALIZED VIEW dbp_msi_view_rpw_dt.mv_zek_1
OPTIONS(ENABLE_REFRESH = TRUE, REFRESH_INTERVAL_MINUTES = 90) AS
SELECT mandant_id,
 zek_id,
 wbl_id,
 zek_name,
 zek_abt_bez,
 7 AS system_id
FROM kfl_production_dbp_view.v_zek_1
WHERE mandant_id = 1;