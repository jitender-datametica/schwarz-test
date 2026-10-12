CREATE OR REPLACE VIEW ldl_p_lew_mart_pit_onprem.v_pit_advert_theme AS SELECT client_id,
 adv_theme_sid,
 CAST(adv_theme_sid * 100 + client_id AS BIGNUMERIC) AS adv_theme_mstr_sid,
 adv_theme_descr AS advert_theme,
 dwh_created
FROM ldl_p_lew_mart_pit_onprem.t_advert_theme
WHERE adv_theme_sid >= 0
UNION ALL
SELECT client_id,
 adv_theme_sid,
 CAST(adv_theme_sid * 100 - client_id AS BIGNUMERIC) AS adv_theme_mstr_sid,
 adv_theme_descr AS advert_theme,
 dwh_created
FROM ldl_p_lew_mart_pit_onprem.t_advert_theme
WHERE adv_theme_sid < 0
UNION ALL
SELECT DISTINCT client_id,
  - 2000 - client_id AS adv_theme_sid,
 CAST((- 2000 - client_id) * 100 - client_id AS BIGNUMERIC) AS adv_theme_mstr_sid,
 'TOT' AS advert_theme,
  (SAFE.PARSE_DATETIME('%F %H24:%M:%S', '1900-01-01 00:00:00')) AS dwh_created
FROM ldl_p_lew_mart_pit_onprem.t_pit_scope_country_param_country
WHERE pv_fg = 1;