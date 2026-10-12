CREATE OR REPLACE VIEW kfl_production_dbp_view.v_art_gp_zu_per_1 (dat_von, mandant_id, art_id, gp_id,
einkaufsorganisation_id, gp_art_id, dat_bis, herst_id, mhd_zeitraum_dz, mutter_ek_id) AS SELECT dat_von,
 mandant_id,
 art_id,
 gp_id,
 einkaufsorganisation_id,
 gp_art_id,
 dat_bis,
 herst_id,
 mhd_zeitraum_dz,
 mutter_ek_id
FROM kfl_production_dbp_data.art_gp_zu_per_1;