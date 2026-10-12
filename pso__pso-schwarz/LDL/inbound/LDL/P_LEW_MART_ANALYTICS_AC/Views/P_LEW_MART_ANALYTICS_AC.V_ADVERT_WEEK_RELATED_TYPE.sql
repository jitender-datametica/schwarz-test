CREATE OR REPLACE VIEW P_LEW_MART_ANALYTICS_AC.V_ADVERT_WEEK_RELATED_TYPE
AS
   SELECT
     adv_week_rltd_type_id,
   adv_week_rltd_type_descr
  FROM p_lew_mart_analytics.t_advert_week_related_type;