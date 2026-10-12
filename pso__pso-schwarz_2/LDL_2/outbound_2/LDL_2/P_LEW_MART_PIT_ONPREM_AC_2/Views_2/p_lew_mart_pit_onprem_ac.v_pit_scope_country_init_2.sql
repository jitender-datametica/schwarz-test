CREATE OR REPLACE VIEW ldl_p_lew_mart_pit_onprem_ac.v_pit_scope_country_init_2 (client_id, dwh_valid_from, dwh_valid_to,
deleted_fg, dwh_created, dwh_updated) AS SELECT *
FROM ldl_p_lew_mart_pit_onprem.v_pit_scope_country_init_2;