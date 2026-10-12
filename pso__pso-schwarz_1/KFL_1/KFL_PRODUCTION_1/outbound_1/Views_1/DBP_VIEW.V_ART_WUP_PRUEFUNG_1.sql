CREATE OR REPLACE VIEW kfl_production_dbp_view.v_art_wup_pruefung_1 AS SELECT mandant_id,
 pruef_prozess_typ_kz,
 wup_id,
 nb_id,
 art_id,
 dat_erstellung,
 pruef_id,
 z_arbeitsgebiet_id,
 pruef_status_id,
 dat_pruefung
FROM kfl_production_dbp_data.art_wup_pruefung_1;