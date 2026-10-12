CREATE OR REPLACE VIEW P_LEW_MART_ANALYTICS_AC.V_ADVERT_MEDIUM_1
AS
   SELECT
     client_id,
   adv_medium_sid,
   adv_medium_descr,
   adv_medium_sort_val,
   dwh_created
  FROM p_lew_mart_analytics.t_advert_medium_1;