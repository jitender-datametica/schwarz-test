CREATE OR REPLACE VIEW kfl_production_dbp_view.v_art_sm_vw_zu_per_2 AS SELECT art_id,
 vw_id,
 mandant_id,
 dat_von,
 dat_bis,
 sm_id,
 ksm_id,
 td_update,
 td_insert
FROM kfl_production_dbp_data.art_sm_vw_zu_per_2;