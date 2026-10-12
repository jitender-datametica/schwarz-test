CREATE OR REPLACE VIEW kfl_production_dbp_view.v_flw_art_umrech_faktor_per_1 AS SELECT flw_art_id,
 altnv_menge_einh_id,
 mandant_id,
 system_id,
 umrech_faktor,
 gew_einh_id,
 td_insert,
 td_update
FROM kfl_production_dbp_data.flw_art_umrech_faktor_per_1;