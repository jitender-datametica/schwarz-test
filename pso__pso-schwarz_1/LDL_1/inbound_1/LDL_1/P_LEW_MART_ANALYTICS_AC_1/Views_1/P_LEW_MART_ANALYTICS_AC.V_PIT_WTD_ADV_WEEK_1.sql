CREATE OR REPLACE VIEW P_LEW_MART_ANALYTICS_AC.V_PIT_WTD_ADV_WEEK_1
AS

SELECT
  adv_week_sid
, client_id
, adv_week_id
, wtd_adv_week_sid
, wtd_adv_week_id
, adv_week_rltd_type_id
FROM p_lew_mart_analytics.v_pit_wtd_adv_week_1
;