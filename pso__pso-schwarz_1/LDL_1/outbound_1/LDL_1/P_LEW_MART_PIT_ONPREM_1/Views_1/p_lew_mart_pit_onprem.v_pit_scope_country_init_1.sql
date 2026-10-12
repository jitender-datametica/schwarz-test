CREATE OR REPLACE VIEW ldl_p_lew_mart_pit_onprem.v_pit_scope_country_init_1 (client_id, dwh_valid_from, dwh_valid_to,
deleted_fg, dwh_created, dwh_updated) AS SELECT DISTINCT *
FROM ldl_p_lew_mart_pit_onprem.t_pit_scope_country_init_1
WHERE CURRENT_DATE BETWEEN dwh_valid_from AND dwh_valid_to
 AND deleted_fg = 0;