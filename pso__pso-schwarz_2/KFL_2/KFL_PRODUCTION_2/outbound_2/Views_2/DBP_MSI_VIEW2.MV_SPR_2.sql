CREATE OR REPLACE VIEW kfl_production_dbp_msi_view2.mv_spr_2 (spr_id, spr_name, spr_iso, dwh_spr) AS SELECT spr_id,
 spr_name,
 spr_iso,
 dwh_spr
FROM kfl_production_dbp_view.v_spr_2
WHERE spr_id = 22;