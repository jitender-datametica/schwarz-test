CREATE OR REPLACE VIEW ldl_p_lew_mart_pit_onprem_ac.v_pit_scope_country_param_ref_2 AS SELECT param_id,
 param_name,
 param_descr,
 param_column_datatype,
 pit_initial_fg,
 pit_reagg_fg,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_mart_pit_onprem.t_pit_scope_country_param_ref_2;