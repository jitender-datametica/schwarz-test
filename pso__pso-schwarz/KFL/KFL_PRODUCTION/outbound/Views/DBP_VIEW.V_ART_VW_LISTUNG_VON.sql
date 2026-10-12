CREATE OR REPLACE VIEW kfl_production_dbp_view.v_art_vw_listung_von AS SELECT mandant_id,
 vw_id,
 art_id,
 dat_von,
 sm_id,
 dat_erst_listung,
 ksm_id
FROM kfl_production_dbp_data.art_vw_listung_von;