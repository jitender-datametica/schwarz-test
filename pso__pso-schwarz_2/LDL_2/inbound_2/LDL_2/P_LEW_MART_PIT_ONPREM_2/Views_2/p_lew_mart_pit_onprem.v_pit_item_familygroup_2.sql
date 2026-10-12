CREATE OR REPLACE VIEW P_LEW_MART_PIT_ONPREM.V_PIT_ITEM_FAMILYGROUP_2

AS
   SELECT
   client_id
,   item_fam_grp_sid
,   src_familygrp_cd    AS item_fam_grp_descr
   FROM p_lew_core_ac.v_item_familygroup_2

   UNION ALL
   SELECT
   country_sid
,   -2::INTEGER
,   'TOT'
   FROM p_lew_core_ac.v_country_2;