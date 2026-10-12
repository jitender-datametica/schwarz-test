CREATE OR REPLACE VIEW P_LEW_MART_ANALYTICS_AC.V_PIT_MSI_DRILL_UWG_ITEM_2
AS
   SELECT
     client_id,
   adv_week_id,
   adv_week_sid,
   rltd_adv_week_id,
   rltd_adv_week_sid,
   item_grp_int_sid,
   sub_item_grp_sid,
   item_grp_int_mstr_sid,
   sub_item_grp_mstr_sid,
   _count,
   drill_to_item_link_html
  FROM p_lew_mart_analytics.v_pit_msi_drill_uwg_item_2
;