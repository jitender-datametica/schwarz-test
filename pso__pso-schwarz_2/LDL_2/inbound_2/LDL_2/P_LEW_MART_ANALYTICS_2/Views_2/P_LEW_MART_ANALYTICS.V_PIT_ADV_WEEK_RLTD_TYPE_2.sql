CREATE OR REPLACE VIEW P_LEW_MART_ANALYTICS.V_PIT_ADV_WEEK_RLTD_TYPE_2
AS
   SELECT
     adv_week_rltd_type_id,
   adv_week_rltd_type_descr
  FROM p_lew_mart_analytics.t_advert_week_related_type_2;