CREATE OR REPLACE VIEW kfl_production_dbp_view.v_profit_center_grp AS SELECT pc_grp_id,
 mandant_id,
 system_id,
 pc_hiertyp_id,
 pc_grp_mutter_id,
 pc_grp_id_kons,
 kl_pc_grp_id,
 ebene_id,
 ebene_pos_id
FROM kfl_production_dbp_data.profit_center_grp;