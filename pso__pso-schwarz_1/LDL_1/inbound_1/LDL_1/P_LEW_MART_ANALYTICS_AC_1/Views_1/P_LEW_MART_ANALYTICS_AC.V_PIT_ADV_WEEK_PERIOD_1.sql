CREATE OR REPLACE VIEW P_LEW_MART_ANALYTICS_AC.V_PIT_ADV_WEEK_PERIOD_1
AS

SELECT
  client_id
, adv_week_id
, adv_week_sid
, adv_week_rltd_id
, adv_week_rltd_sid
, adv_period_id
, adv_period_descr
, adv_week_period_start_dt_descr
, adv_week_period_end_dt_descr
, adv_week_period_sort_val
, adv_week_period_start_dt
, adv_week_period_start_day_desc
, adv_week_period_start_day_ab
, adv_week_period_end_dt
, adv_week_period_end_day_desc
, adv_week_period_end_day_ab
, m_adv_week_start_dt
, m_adv_week_end_dt
, m_adv_week_end_ext_dt
, adv_week_period_long_descr
, adv_week_range_long_descr
FROM p_lew_mart_analytics.v_pit_adv_week_period_1;