CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ivs.mv_l_flaecheart_2 AS SELECT flaecheart_id,
 flaecheart_bez,
 spr_id,
 mandant_id
FROM kfl_production_dbp_view.v_ivs_l_flaecheart_2
WHERE spr_id = 22;