CREATE OR REPLACE VIEW smp_production_data_shared_kfl.dbp_data_art_bonuskauf_wup_zu_per_1 (mandant_id, wup_id, nb_id,
art_id, bonuskauf_id, dat_von, dat_bis, td_insert, td_update) AS SELECT mandant_id,
 wup_id,
 nb_id,
 art_id,
 bonuskauf_id,
 dat_von,
 dat_bis,
 td_insert,
 td_update
FROM kfl_production_dbp_data.art_bonuskauf_wup_zu_per_1;