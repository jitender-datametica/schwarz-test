CREATE OR REPLACE VIEW ldl_p_lew_mart_pit_onprem.v_pit_scope_country_param_log_2 AS SELECT PA.param_id,
 PA.client_id,
 CAST(PA.param_value_char AS STRING) AS param_value,
 PAR.param_name,
 PAR.param_descr,
 PAR.param_column_datatype
FROM ldl_p_lew_mart_pit_onprem.t_pit_scope_country_param_2 AS PA
 INNER JOIN ldl_p_lew_mart_pit_onprem.t_pit_scope_country_param_ref_2 AS PAR ON PA.param_id = PAR.param_id
WHERE PA.current_fg = 1
 AND PA.deleted_fg = 0
 AND CURRENT_DATE BETWEEN PA.dwh_valid_from AND PA.dwh_valid_to;