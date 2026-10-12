CREATE OR REPLACE MATERIALIZED VIEW dbp_msi_view_rpw_dt.mv_artkz_leist_1
OPTIONS(ENABLE_REFRESH = TRUE, REFRESH_INTERVAL_MINUTES = 90) AS
SELECT leist_id,
 leist_bez,
 mandant_id,
 spr_id,
 7 AS system_id
FROM kfl_production_dbp_view.v_artkz_leist_1
WHERE mandant_id = 1;