CREATE OR REPLACE VIEW kfl_production_dbp_view.v_spr (spr_id, spr_name, spr_iso, dwh_spr) AS SELECT spr_id,
 spr_name,
 spr_iso,
 dwh_spr
FROM kfl_production_dbp_data.spr;