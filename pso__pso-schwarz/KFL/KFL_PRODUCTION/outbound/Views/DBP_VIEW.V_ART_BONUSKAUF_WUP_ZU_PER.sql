CREATE OR REPLACE VIEW kfl_production_dbp_view.v_art_bonuskauf_wup_zu_per AS SELECT mandant_id,
 wup_id,
 nb_id,
 art_id,
 bonuskauf_id,
 dat_von,
 dat_bis
FROM kfl_production_dbp_data.art_bonuskauf_wup_zu_per;