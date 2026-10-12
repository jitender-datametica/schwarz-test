CREATE OR REPLACE VIEW P_PROCESS_VIEW.V_PIT_ITEM_FAMILYGROUP as
   SELECT
     client_id,
   item_fam_grp_sid,
   src_familygrp_cd    AS item_fam_grp_descr
  FROM  p_lew_core_ac.v_item_familygroup

  UNION ALL

  SELECT
    country_sid,
   -2,
   'TOT'
  FROM  p_lew_core_ac.v_country
;