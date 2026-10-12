CREATE OR REPLACE VIEW smp_production_data_shared_kfl.dbp_data_art_wg_zu_per_1 (mandant_id, dat_von, art_id, arthiertyp_id
, wg_id, dat_bis, wug_id, td_update, td_insert) AS SELECT mandant_id,
 dat_von,
 art_id,
 arthiertyp_id,
 wg_id,
 dat_bis,
 wug_id,
 td_update,
 td_insert
FROM kfl_production_dbp_data.art_wg_zu_per_1;