CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ivs.mv_l_nutzung_2 AS SELECT nutzung_id,
 nutzung_bez,
 spr_id,
 mandant_id
FROM kfl_production_dbp_view.v_ivs_l_nutzung_2
WHERE spr_id = 22;