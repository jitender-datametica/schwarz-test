CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw.mv_l_flw_pruef_los_1 (mandant_id, prueflos_id, best_beleg_id,
best_beleg_pos_id, werk_id, in_art_id, herkunft, in_lief_id, pruefart_id) AS SELECT mandant_id,
 prueflos_id,
 best_beleg_id,
 best_beleg_pos_id,
 werk_id,
 flw_art_id AS in_art_id,
 herkunft,
 flw_lief_id AS in_lief_id,
 pruefart_id
FROM kfl_production_dbp_view.v_flw_pruef_los_1;