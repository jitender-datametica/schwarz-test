CREATE OR REPLACE VIEW P_LEW_MART_ANALYTICS_AC.V_PIT_ADVERT_THEME_2
AS
SELECT
  client_id
, adv_theme_sid
, adv_theme_mstr_sid
, advert_theme
, dwh_created
FROM p_lew_mart_analytics.v_pit_advert_theme_2;