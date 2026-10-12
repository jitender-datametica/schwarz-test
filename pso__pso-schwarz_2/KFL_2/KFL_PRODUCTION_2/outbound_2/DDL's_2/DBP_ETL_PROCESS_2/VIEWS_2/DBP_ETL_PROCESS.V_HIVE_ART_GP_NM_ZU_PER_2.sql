CREATE OR REPLACE VIEW kfl_production_dbp_etl_process.v_hive_art_gp_nm_zu_per_2 (mandant_id, art_id, wup_id, nb_id,
dat_von, gp_id, einkaufsorganisation_id, dat_bis, vz_wup_id, bq_findung_id, bezugsweg_id, td_update, td_insert) AS
SELECT *
FROM kfl_production_dbp_process.hive_art_gp_nm_zu_per_2;