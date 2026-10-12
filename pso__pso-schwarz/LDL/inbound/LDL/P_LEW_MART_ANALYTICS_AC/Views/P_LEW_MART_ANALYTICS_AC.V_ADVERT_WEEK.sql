CREATE OR REPLACE VIEW P_LEW_MART_ANALYTICS_AC.V_ADVERT_WEEK
AS
   SELECT
     client_id,
   adv_week_id,
   adv_week_descr,
   adv_week_year_num,
   adv_week_week_num,
   adv_week_start_dt,
   adv_week_end_dt,
   dwh_created,
   dwh_updated
  FROM p_lew_mart_analytics.t_advert_week;