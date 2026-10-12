CREATE OR REPLACE VIEW kfl_production_dbp_view.v_art_per_2 AS SELECT art_id,
 mandant_id,
 dat_von,
 dat_bis,
 mutter_wb_id,
 posten_id,
 ipn_id,
 mwst_id,
 oug_id,
 iwt_id
FROM kfl_production_dbp_data.art_per_2;