CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_rpw.mv_spr (spr_id, spr_name, spr_iso, dwh_spr, system_id) AS SELECT
 spr_id,
 spr_name,
 spr_iso,
 dwh_spr,
 7 AS system_id
FROM kfl_production_dbp_view.v_spr
WHERE spr_id = 22;