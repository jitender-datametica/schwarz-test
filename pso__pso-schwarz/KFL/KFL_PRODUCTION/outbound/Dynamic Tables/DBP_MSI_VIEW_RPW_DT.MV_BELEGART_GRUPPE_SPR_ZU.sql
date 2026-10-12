CREATE OR REPLACE MATERIALIZED VIEW dbp_msi_view_rpw_dt.mv_belegart_gruppe_spr_zu
OPTIONS(ENABLE_REFRESH = TRUE, REFRESH_INTERVAL_MINUTES = 90) AS
SELECT 7 AS system_id,
 mandant_id,
 spr_id,
 belegart_gruppe_id,
 belegart_gruppe_bez
FROM kfl_production_dbp_view.v_belegart_gruppe_spr_zu
WHERE spr_id = 22
 AND mandant_id = 1;