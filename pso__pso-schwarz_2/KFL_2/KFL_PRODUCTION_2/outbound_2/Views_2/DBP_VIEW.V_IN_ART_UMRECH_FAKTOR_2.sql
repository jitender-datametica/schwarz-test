CREATE OR REPLACE VIEW kfl_production_dbp_view.v_in_art_umrech_faktor_2 AS SELECT in_art_id,
 altnv_menge_einh_id,
 mandant_id,
 umrech_faktor,
 gew_einh_id,
 td_update,
 td_insert
FROM kfl_production_dbp_data.in_art_umrech_faktor_2;