CREATE OR REPLACE VIEW P_LEW_BIL.V_ITEM_FAMILYGROUP_1 as
   SELECT
     itmfg.client_id,
   itmfg.item_fam_grp_sid,
   itmfg.src_familygrp_cd,
   itmfg.src_familygrp_id,
   sitmgh.sub_item_grp_sid,
   sitmgh.item_grp_int_sid,
   ifgd_lidl.item_fam_grp_descr_long AS item_family_desc_lidl_long,
   ifgd_dflt.item_fam_grp_descr_long AS item_family_desc_default_long,
   ifgd_lidl.item_fam_grp_descr AS item_family_desc_lidl,
   ifgd_dflt.item_fam_grp_descr AS item_family_desc_default,
   lidlctry.lang_cd AS lang_cd_default,
   lidlctry.lang_sid AS lang_sid_default,
   itmfgh.deleted_fg,
   1 AS active_fg
  FROM p_lew_core_ac.v_item_familygroup_hist_1 AS itmfgh
   INNER JOIN p_lew_core_ac.v_item_familygroup_1  AS itmfg
   ON itmfg.item_fam_grp_sid = itmfgh.item_fam_grp_sid
   AND Current_Date BETWEEN itmfgh.dwh_valid_from AND itmfgh.dwh_valid_to
   LEFT OUTER JOIN p_lew_core_ac.v_subitemgroup_hist_1 AS sitmgh
   ON itmfgh.client_id = sitmgh.client_id
   AND itmfgh.sub_item_grp_sid = sitmgh.sub_item_grp_sid
   AND Current_Date BETWEEN sitmgh.dwh_valid_from AND sitmgh.dwh_valid_to
   INNER JOIN p_lew_core_ac.v_country_1 AS lidlctry
   ON itmfg.client_id = lidlctry.country_sid
   LEFT OUTER JOIN p_lew_core_ac.v_item_familygroup_descr_1 AS ifgd_dflt
   ON  ifgd_dflt.item_fam_grp_sid = itmfg.item_fam_grp_sid
   AND ifgd_dflt.lang_sid=lidlctry.lang_sid
     AND ifgd_dflt.client_id = itmfg.client_id
   LEFT OUTER JOIN p_lew_core_ac.v_item_familygroup_descr_1 AS ifgd_lidl
   ON  ifgd_lidl.item_fam_grp_sid = itmfg.item_fam_grp_sid
   AND ifgd_lidl.lang_sid=2
     AND ifgd_lidl.client_id = itmfg.client_id
   ;