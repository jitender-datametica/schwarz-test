CREATE OR REPLACE VIEW P_LEW_MART_ANALYTICS_AC.V_PIT_ITEM
AS
   SELECT
     client_id,
   item_sid,
   orig_item_nr,
   item_descr_int,
   item_descr_loc,
   uwg_af_desc,
   subitemgroup_id,
   listing_fg,
   item_familygroup_id,
   subitemgroup_desc_intl,
   item_family_desc_intl

  FROM p_lew_mart_analytics.v_pit_item
;