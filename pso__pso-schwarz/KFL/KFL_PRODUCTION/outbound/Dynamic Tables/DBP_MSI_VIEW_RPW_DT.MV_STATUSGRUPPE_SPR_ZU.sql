CREATE OR REPLACE MATERIALIZED VIEW dbp_msi_view_rpw_dt.mv_statusgruppe_spr_zu
OPTIONS(ENABLE_REFRESH = TRUE, REFRESH_INTERVAL_MINUTES = 90) AS
SELECT mandant_id,
 statusgruppe_id,
 spr_id,
 statusgruppe_bez,
 7 AS system_id
FROM kfl_production_dbp_view.v_statusgruppe_spr_zu
WHERE mandant_id = 1
 AND spr_id = 22;