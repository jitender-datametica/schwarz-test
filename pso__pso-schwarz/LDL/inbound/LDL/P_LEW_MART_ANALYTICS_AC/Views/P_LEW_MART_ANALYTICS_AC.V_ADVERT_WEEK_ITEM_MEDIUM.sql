CREATE OR REPLACE VIEW P_LEW_MART_ANALYTICS_AC.V_ADVERT_WEEK_ITEM_MEDIUM
AS
   SELECT
     client_id,
   adv_week_id,
   item_sid,
   adv_medium_sid
  FROM p_lew_mart_analytics.t_advert_week_item_medium;