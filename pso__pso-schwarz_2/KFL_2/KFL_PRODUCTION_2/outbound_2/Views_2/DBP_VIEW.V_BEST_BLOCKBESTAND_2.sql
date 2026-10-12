CREATE OR REPLACE VIEW kfl_production_dbp_view.v_best_blockbestand_2 AS SELECT mandant_id,
 best_beleg_id,
 best_beleg_pos_id,
 prozess_id,
 wup_id,
 nb_id,
 art_id,
 menge_block,
 menge_block_we,
 dat_best_beleg
FROM kfl_production_dbp_data.best_blockbestand_2;