CREATE OR REPLACE VIEW kfl_production_dbp_view.v_mp_ods_var_zu_2 AS SELECT mandant_id,
 mp_ods_id,
 mp_ods_var_id,
 mp_ods_sub_var_id,
 mp_ods_var_val,
 mp_ods_var_bez
FROM kfl_production_dbp_data.mp_ods_var_zu_2;