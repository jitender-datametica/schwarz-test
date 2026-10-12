CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_log.mv_kunde_2 (kunde_id, aktuell_wup_id, is_akt_wup_id_fg,
mandant_id_kunde, nb_id, kunde_bez, dat_von, dat_bis, wup_typ_id) AS SELECT *
FROM kfl_production_dbp_msi_view_log.mv_dt_kunde_2;