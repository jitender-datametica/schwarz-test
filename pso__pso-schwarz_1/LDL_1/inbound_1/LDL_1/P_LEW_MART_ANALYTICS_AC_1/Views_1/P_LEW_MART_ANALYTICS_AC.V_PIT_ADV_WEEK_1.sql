CREATE OR REPLACE VIEW P_LEW_MART_ANALYTICS_AC.V_PIT_ADV_WEEK_1
AS

SELECT
  client_id
, adv_week_id
, adv_week_seq
, adv_week_descr
, adv_week_long_descr
, adv_week_year_num
, adv_week_week_num
, adv_week_start_dt
, adv_week_end_dt
, dwh_created
, dwh_updated
FROM p_lew_mart_analytics.v_pit_adv_week_1;