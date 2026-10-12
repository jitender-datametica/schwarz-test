CREATE OR REPLACE VIEW ldl_p_lew_process_ac.v_client_config_2 (client_id, country_lidl_cd, client_name, ai_timezone,
sales_gross_fg) AS SELECT client_id,
 country_lidl_cd,
 client_name,
 ai_timezone,
 sales_gross_fg
FROM ldl_p_lew_process.t_client_config_2;