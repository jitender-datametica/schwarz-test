-- 2024-04-22, AP0179753, dknop, initial

CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_scm_materialized.mv_art_gp_nm_zu_akt (mandant_id, art_id, wup_id,
nb_id, dat_von, akt_gp_id, einkaufsorganisation_id, dat_bis) AS SELECT mandant_id,
 art_id,
 wup_id,
 nb_id,
 dat_von,
 gp_id AS akt_gp_id,
 einkaufsorganisation_id,
 dat_bis
FROM kfl_production_dbp_view.v_art_gp_nm_zu_per AS V01
WHERE dat_bis = DATE '9999-12-31';