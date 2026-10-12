CREATE OR REPLACE VIEW ldl_p_lew_mart_pit_onprem.v_pit_scope_country_param_country_1 (client_id, country_name,
country_iso2, lang_sid, dwh_valid_from, dwh_valid_to, wawi_fg, pv_fg, deleted_fg, dwh_created, dwh_updated) AS SELECT
 client_id,
 country_name,
 country_iso2,
 lang_sid,
 dwh_valid_from,
 dwh_valid_to,
 wawi_fg,
 pv_fg,
 deleted_fg,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_mart_pit_onprem.t_pit_scope_country_param_country_1
WHERE CURRENT_DATE BETWEEN dwh_valid_from AND dwh_valid_to
 AND pv_fg = 1
 AND deleted_fg = 0;