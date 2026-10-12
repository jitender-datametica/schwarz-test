CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_rpw.mv_gp_branche_spr_zu_2 (mandant_id, gp_branche_id, spr_id,
gp_branche_bez, system_id) AS SELECT mandant_id,
 gp_branche_id,
 spr_id,
 gp_branche_bez,
 7 AS system_id
FROM kfl_production_dbp_view.v_gp_branche_spr_zu_2
WHERE mandant_id = 1
 AND spr_id = 22;