CREATE OR REPLACE MATERIALIZED VIEW dbp_msi_view_rpw_dt.mv_owg_spr_zu_2
OPTIONS(ENABLE_REFRESH = TRUE, REFRESH_INTERVAL_MINUTES = 90) AS
SELECT owg_id,
 spr_id,
 arthiertyp_id,
 mandant_id,
 owg_bez,
 7 AS system_id
FROM kfl_production_dbp_view.v_owg_spr_zu_2
WHERE mandant_id = 1
 AND spr_id = 22
 AND arthiertyp_id = 2
 AND owg_id >= -3;