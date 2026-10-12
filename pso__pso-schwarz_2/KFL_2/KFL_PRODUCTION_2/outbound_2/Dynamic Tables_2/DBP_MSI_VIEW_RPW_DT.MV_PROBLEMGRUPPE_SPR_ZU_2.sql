CREATE OR REPLACE MATERIALIZED VIEW dbp_msi_view_rpw_dt.mv_problemgruppe_spr_zu_2
OPTIONS(ENABLE_REFRESH = TRUE, REFRESH_INTERVAL_MINUTES = 90) AS
SELECT 7 AS system_id,
 mandant_id,
 problemgruppe_id,
 spr_id,
 problemgruppe_bez
FROM kfl_production_dbp_view.v_problemgruppe_spr_zu_2
WHERE spr_id = 22
 AND mandant_id = 1;