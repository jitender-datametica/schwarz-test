CREATE OR REPLACE MATERIALIZED VIEW ldl_p_lew_mart_analytics.v_pit_advert_theme_2
OPTIONS(ENABLE_REFRESH = TRUE, REFRESH_INTERVAL_MINUTES = 90) AS
SELECT client_id,
 adv_theme_sid,
 CAST(adv_theme_sid * 100 + client_id AS BIGNUMERIC) AS adv_theme_mstr_sid,
 adv_theme_descr AS advert_theme,
 dwh_created
FROM ldl_p_lew_mart_analytics.t_advert_theme_2
UNION ALL
SELECT client_id,
 - 2,
 CAST(- 2 * 100 + client_id AS BIGNUMERIC) AS adv_theme_mstr_sid,
 'TOT' AS advert_theme,
 CAST('1900-01-01 00:00:00' AS DATETIME) AS dwh_created
FROM ldl_p_lew_mart_analytics.t_pit_country_2;