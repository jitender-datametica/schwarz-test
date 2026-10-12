CREATE OR REPLACE VIEW kfl_production_dbp_view.v_art_wup_status_referenz_1 (mandant_id, art_id, wup_id, nb_id, art_id_ref
, wup_id_ref, nb_id_ref, dat_bis_ref, faktor_ref) AS SELECT mandant_id,
 art_id,
 wup_id,
 nb_id,
 art_id_ref,
 wup_id_ref,
 nb_id_ref,
 dat_bis_ref,
 faktor_ref
FROM kfl_production_dbp_data.art_wup_status_referenz_1;