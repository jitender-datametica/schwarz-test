CREATE OR REPLACE VIEW ldl_p_lew_mart_pit_onprem.v_pit_param_2 AS SELECT param_id,
 dwh_valid_from,
 dwh_valid_to,
 param_name,
 param_value
FROM ldl_p_lew_mart_pit_onprem.t_pit_param_2
WHERE CURRENT_DATE BETWEEN dwh_valid_from AND dwh_valid_to;