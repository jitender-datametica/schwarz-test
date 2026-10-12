CREATE OR REPLACE VIEW P_LEW_MART_ANALYTICS_AC.V_PIT_ITEM_FAMILYGROUP_2
AS
   SELECT
     client_id,
   item_fam_grp_sid,
   item_fam_grp_descr
  FROM p_lew_mart_analytics.v_pit_item_familygroup_2
;