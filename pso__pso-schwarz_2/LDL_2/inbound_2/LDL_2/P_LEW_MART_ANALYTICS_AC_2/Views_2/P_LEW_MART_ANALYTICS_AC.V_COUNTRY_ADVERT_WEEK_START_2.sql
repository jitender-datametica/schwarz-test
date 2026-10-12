CREATE OR REPLACE VIEW P_LEW_MART_ANALYTICS_AC.V_COUNTRY_ADVERT_WEEK_START_2
AS
   SELECT
     client_id,
   dwh_valid_from,
   dwh_valid_to,
   adv_week_start_day,
   following_cal_week_fg,
   dwh_created,
   dwh_updated
  FROM p_lew_mart_analytics.t_country_advert_week_start_2;