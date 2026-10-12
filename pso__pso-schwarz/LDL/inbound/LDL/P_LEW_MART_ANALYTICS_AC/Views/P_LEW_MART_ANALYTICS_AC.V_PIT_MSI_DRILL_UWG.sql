CREATE OR REPLACE VIEW P_LEW_MART_ANALYTICS_AC.V_PIT_MSI_DRILL_UWG
AS
   SELECT
     client_id,
   adv_week_id,
   adv_week_sid,
   rltd_adv_week_id,
   rltd_adv_week_sid,
   item_grp_int_sid,
   item_grp_int_mstr_sid,
   _count,
   drill_to_uwg_link_html
  FROM p_lew_mart_analytics.v_pit_msi_drill_uwg
;