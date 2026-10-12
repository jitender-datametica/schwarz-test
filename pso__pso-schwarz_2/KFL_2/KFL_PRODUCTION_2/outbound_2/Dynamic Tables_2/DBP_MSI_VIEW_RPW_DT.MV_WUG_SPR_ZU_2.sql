CREATE OR REPLACE MATERIALIZED VIEW dbp_msi_view_rpw_dt.mv_wug_spr_zu_2
OPTIONS(ENABLE_REFRESH = TRUE, REFRESH_INTERVAL_MINUTES = 90) AS
SELECT mandant_id,
 arthiertyp_id,
 wg_id,
 spr_id,
 wug_id,
 wug_bez,
 7 AS system_id
FROM kfl_production_dbp_view.v_wug_spr_zu_2
WHERE mandant_id = 1
 AND spr_id = 22
 AND arthiertyp_id = 2;