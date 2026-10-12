CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_lil_data_delivery_classification_2 (client_id, src_region_cd, src_period_nr,
period_year, period_type_id, dsc_nr, lfl_id, dwh_load_id, dwh_created, dwh_updated) AS SELECT client_id,
 src_region_cd,
 src_period_nr,
 period_year,
 period_type_id,
 dsc_nr,
 lfl_id,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_lil_data_delivery_classification_2;