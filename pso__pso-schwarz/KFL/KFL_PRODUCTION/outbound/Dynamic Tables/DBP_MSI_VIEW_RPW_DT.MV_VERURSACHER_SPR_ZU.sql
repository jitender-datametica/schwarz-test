CREATE OR REPLACE MATERIALIZED VIEW dbp_msi_view_rpw_dt.mv_verursacher_spr_zu
OPTIONS(ENABLE_REFRESH = TRUE, REFRESH_INTERVAL_MINUTES = 90) AS
SELECT 7 AS system_id,
 mandant_id,
 verursacher_id,
 spr_id,
 verursacher_bez
FROM kfl_production_dbp_view.v_verursacher_spr_zu
WHERE mandant_id = 1
 AND spr_id = 22;