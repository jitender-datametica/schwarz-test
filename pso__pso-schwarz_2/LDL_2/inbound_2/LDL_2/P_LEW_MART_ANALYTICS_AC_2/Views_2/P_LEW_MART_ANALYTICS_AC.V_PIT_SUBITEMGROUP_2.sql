CREATE OR REPLACE VIEW P_LEW_MART_ANALYTICS_AC.V_PIT_SUBITEMGROUP_2
AS
   SELECT
     client_id,
   sub_item_grp_sid,
   src_subitemgrp_cd,
   sub_item_grp_descr_int,
   sub_item_grp_descr_loc
  FROM p_lew_mart_analytics.v_pit_subitemgroup_2
;