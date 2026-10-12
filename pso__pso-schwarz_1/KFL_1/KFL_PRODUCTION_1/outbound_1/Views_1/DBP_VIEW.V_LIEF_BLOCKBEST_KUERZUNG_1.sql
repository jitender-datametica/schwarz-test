CREATE OR REPLACE VIEW kfl_production_dbp_view.v_lief_blockbest_kuerzung_1 AS SELECT mandant_id,
 versandstelle_id,
 dat_lief_wunsch,
 lief_beleg_id,
 lief_beleg_pos_id,
 art_id,
 menge_best_kolli,
 menge_lief_ist_kolli,
 td_update,
 td_insert
FROM kfl_production_dbp_data.lief_blockbest_kuerzung_1;