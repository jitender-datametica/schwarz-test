CREATE OR REPLACE VIEW P_LEW_MART_ANALYTICS_AC.V_PIT_MSI_DRILL_DETAIL
AS

SELECT
  client_id
, adv_week_id
, adv_week_sid
, rltd_adv_week_id
, adv_week_rltd_sid
, adv_period_id
, action_type_id
, _count
, drill_to_dokument_link_html
FROM p_lew_mart_analytics.v_pit_msi_drill_detail
;