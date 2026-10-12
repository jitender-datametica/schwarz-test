CREATE OR REPLACE VIEW P_LEW_MART_ANALYTICS_AC.V_PIT_MSI_DRILL_ALL_ITEM_2
AS

SELECT
  client_id
, item_sid
, item_mstr_sid
, adv_week_sid
, adv_week_rltd_sid
, _count
, drill_to_all_items_link_html
FROM p_lew_mart_analytics.v_pit_msi_drill_all_item_2
;