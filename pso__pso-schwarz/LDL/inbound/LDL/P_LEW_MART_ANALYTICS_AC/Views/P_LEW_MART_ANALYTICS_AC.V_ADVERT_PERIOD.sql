CREATE OR REPLACE VIEW P_LEW_MART_ANALYTICS_AC.V_ADVERT_PERIOD
AS
   SELECT
     adv_period_id,
   adv_period_descr,
   mstr_related_fg
  FROM p_lew_mart_analytics.t_advert_period;