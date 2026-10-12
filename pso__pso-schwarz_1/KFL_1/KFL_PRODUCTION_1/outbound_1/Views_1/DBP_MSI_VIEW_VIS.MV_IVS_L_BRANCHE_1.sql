CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_ivs_l_branche_1 AS SELECT mandant_id,
 branche_id,
 branche_bez,
 spr_id
FROM kfl_production_dbp_view.v_ivs_l_branche_1
WHERE spr_id = 22;