CREATE OR REPLACE MATERIALIZED VIEW dbp_msi_view_rpw_dt.mv_belegart_spr_zu
OPTIONS(ENABLE_REFRESH = TRUE, REFRESH_INTERVAL_MINUTES = 90) AS
SELECT mandant_id,
 belegart_id,
 spr_id,
 belegart_bez,
 system_id
FROM kfl_production_dbp_view.v_belegart_spr_zu
WHERE mandant_id = 1
 AND spr_id = 22;