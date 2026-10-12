CREATE OR REPLACE VIEW kfl_production_dbp_view.v_flw_pruef_los_1 AS SELECT mandant_id,
 prueflos_id,
 best_beleg_id,
 best_beleg_pos_id,
 werk_id,
 flw_art_id,
 herkunft,
 flw_lief_id,
 pruefart_id,
 system_id,
 td_insert,
 td_update
FROM kfl_production_dbp_data.flw_pruef_los_1;