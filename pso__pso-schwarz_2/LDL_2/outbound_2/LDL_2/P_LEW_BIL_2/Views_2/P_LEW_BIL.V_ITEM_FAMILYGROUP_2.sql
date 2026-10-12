CREATE OR REPLACE VIEW ldl_p_lew_bil.v_item_familygroup_2 AS SELECT ITMFG.client_id,
 ITMFG.item_fam_grp_sid,
 ITMFG.src_familygrp_cd,
 ITMFG.src_familygrp_id,
 SITMGH.sub_item_grp_sid,
 SITMGH.item_grp_int_sid,
 IFGD_LIDL.item_fam_grp_descr_long AS item_family_desc_lidl_long,
 IFGD_DFLT.item_fam_grp_descr_long AS item_family_desc_default_long,
 IFGD_LIDL.item_fam_grp_descr AS item_family_desc_lidl,
 IFGD_DFLT.item_fam_grp_descr AS item_family_desc_default,
 LIDLCTRY.lang_cd AS lang_cd_default,
 LIDLCTRY.lang_sid AS lang_sid_default,
 ITMFGH.deleted_fg,
 1 AS active_fg
FROM ldl_p_lew_core_ac.v_item_familygroup_hist_2 AS ITMFGH
 INNER JOIN ldl_p_lew_core_ac.v_item_familygroup_2 AS ITMFG ON ITMFGH.item_fam_grp_sid = ITMFG.item_fam_grp_sid AND
   CURRENT_DATE BETWEEN ITMFGH.dwh_valid_from AND ITMFGH.dwh_valid_to
 LEFT JOIN ldl_p_lew_core_ac.v_subitemgroup_hist_2 AS SITMGH ON ITMFGH.client_id = SITMGH.client_id AND ITMFGH.sub_item_grp_sid
     = SITMGH.sub_item_grp_sid AND CURRENT_DATE BETWEEN SITMGH.dwh_valid_from AND SITMGH.dwh_valid_to
 INNER JOIN ldl_p_lew_core_ac.v_country_2 AS LIDLCTRY ON ITMFG.client_id = LIDLCTRY.country_sid
 LEFT JOIN ldl_p_lew_core_ac.v_item_familygroup_descr_2 AS IFGD_DFLT ON ITMFG.item_fam_grp_sid = IFGD_DFLT.item_fam_grp_sid
     AND LIDLCTRY.lang_sid = IFGD_DFLT.lang_sid AND ITMFG.client_id = IFGD_DFLT.client_id
 LEFT JOIN ldl_p_lew_core_ac.v_item_familygroup_descr_2 AS IFGD_LIDL ON ITMFG.item_fam_grp_sid = IFGD_LIDL.item_fam_grp_sid
     AND IFGD_LIDL.lang_sid = 2 AND ITMFG.client_id = IFGD_LIDL.client_id;