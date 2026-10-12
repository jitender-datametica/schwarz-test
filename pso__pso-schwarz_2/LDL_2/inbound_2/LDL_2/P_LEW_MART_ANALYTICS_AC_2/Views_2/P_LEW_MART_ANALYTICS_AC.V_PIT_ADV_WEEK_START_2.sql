CREATE OR REPLACE VIEW P_LEW_MART_ANALYTICS_AC.V_PIT_ADV_WEEK_START_2
AS

SELECT
  client_id
, dwh_valid_from
, dwh_valid_from_descr
, dwh_valid_to
, adv_week_start_day
, adv_week_start_day_descr
, adv_week_start_day_abbrv
, following_cal_week_fg
, dwh_created
, dwh_updated 
FROM p_lew_mart_analytics.v_pit_adv_week_start_2;