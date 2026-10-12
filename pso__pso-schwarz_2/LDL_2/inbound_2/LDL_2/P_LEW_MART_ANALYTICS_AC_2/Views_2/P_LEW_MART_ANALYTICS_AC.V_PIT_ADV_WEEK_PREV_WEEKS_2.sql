CREATE OR REPLACE VIEW P_LEW_MART_ANALYTICS_AC.V_PIT_ADV_WEEK_PREV_WEEKS_2
AS
   SELECT
     client_id,
   adv_week_id,
   prev_adv_week_id
  FROM p_lew_mart_analytics.v_pit_adv_week_prev_weeks_2
;