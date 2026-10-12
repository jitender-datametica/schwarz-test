CREATE OR REPLACE VIEW kfl_production_dbp_view.v_art_gp_nm_zu_per (mandant_id, art_id, wup_id, nb_id, dat_von, gp_id,
einkaufsorganisation_id, dat_bis, vz_wup_id, bq_findung_id, bezugsweg_id) AS SELECT mandant_id,
 art_id,
 wup_id,
 nb_id,
 dat_von,
 gp_id,
 einkaufsorganisation_id,
 dat_bis,
 vz_wup_id,
 bq_findung_id,
 bezugsweg_id
FROM kfl_production_dbp_data.art_gp_nm_zu_per;