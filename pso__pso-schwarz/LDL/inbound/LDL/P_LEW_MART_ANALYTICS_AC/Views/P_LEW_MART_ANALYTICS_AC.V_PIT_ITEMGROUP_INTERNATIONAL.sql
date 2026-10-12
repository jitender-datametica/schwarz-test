CREATE OR REPLACE VIEW P_LEW_MART_ANALYTICS_AC.V_PIT_ITEMGROUP_INTERNATIONAL
AS
   SELECT
     client_id,
   item_grp_int_sid,
   src_itemgrp_int_cd,
   item_grp_int_descr_int,
   item_grp_int_descr_loc
  FROM p_lew_mart_analytics.v_pit_itemgroup_international
;