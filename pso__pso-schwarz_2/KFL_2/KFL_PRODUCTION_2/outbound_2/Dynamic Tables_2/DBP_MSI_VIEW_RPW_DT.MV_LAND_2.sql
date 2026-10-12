CREATE OR REPLACE MATERIALIZED VIEW dbp_msi_view_rpw_dt.mv_land_2
OPTIONS(ENABLE_REFRESH = TRUE, REFRESH_INTERVAL_MINUTES = 90) AS
SELECT land_bez,
 land_iso,
 eu_land_fg,
 land_id,
 mandant_id,
 7 AS system_id
FROM kfl_production_dbp_view.v_land_2
WHERE mandant_id = 1;