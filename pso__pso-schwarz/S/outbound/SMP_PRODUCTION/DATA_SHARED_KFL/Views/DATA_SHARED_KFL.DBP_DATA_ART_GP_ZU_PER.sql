CREATE OR REPLACE VIEW smp_production_data_shared_kfl.dbp_data_art_gp_zu_per (dat_von, mandant_id, art_id, gp_id,
einkaufsorganisation_id, gp_art_id, dat_bis, herst_id, mhd_zeitraum_dz, mutter_ek_id, td_insert, td_update) AS SELECT
 dat_von,
 mandant_id,
 art_id,
 gp_id,
 einkaufsorganisation_id,
 gp_art_id,
 dat_bis,
 herst_id,
 mhd_zeitraum_dz,
 mutter_ek_id,
 td_insert,
 td_update
FROM kfl_production_dbp_data.art_gp_zu_per;