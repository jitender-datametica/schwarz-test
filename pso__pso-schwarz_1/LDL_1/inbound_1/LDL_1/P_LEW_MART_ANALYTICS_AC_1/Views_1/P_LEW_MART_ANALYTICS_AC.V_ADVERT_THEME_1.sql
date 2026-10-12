CREATE OR REPLACE VIEW P_LEW_MART_ANALYTICS_AC.V_ADVERT_THEME_1
AS
   SELECT
     client_id,
   adv_theme_sid,
   adv_theme_descr,
   dwh_created
  FROM p_lew_mart_analytics.t_advert_theme_1;