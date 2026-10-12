CREATE OR REPLACE VIEW ldl_p_lew_process.v_subitemgroup_name AS SELECT SUBITEMGR_DESCR.client_id,
 SUBITEMGR_DESCR.sub_item_grp_sid,
 MAX(CASE
   WHEN RLANG.iso_cd = '@'
   THEN SUBITEMGR_DESCR.sub_item_grp_descr
   ELSE NULL
   END) AS sub_item_grp_name,
 MAX(CASE
   WHEN RLANG.iso_cd = 'BG'
   THEN SUBITEMGR_DESCR.sub_item_grp_descr
   ELSE NULL
   END) AS sub_item_grp_name_bg,
 MAX(CASE
   WHEN RLANG.iso_cd = 'CS'
   THEN SUBITEMGR_DESCR.sub_item_grp_descr
   ELSE NULL
   END) AS sub_item_grp_name_cs,
 MAX(CASE
   WHEN RLANG.iso_cd = 'DA'
   THEN SUBITEMGR_DESCR.sub_item_grp_descr
   ELSE NULL
   END) AS sub_item_grp_name_da,
 MAX(CASE
   WHEN RLANG.iso_cd = 'DE'
   THEN SUBITEMGR_DESCR.sub_item_grp_descr
   ELSE NULL
   END) AS sub_item_grp_name_de,
 MAX(CASE
   WHEN RLANG.iso_cd = 'EL'
   THEN SUBITEMGR_DESCR.sub_item_grp_descr
   ELSE NULL
   END) AS sub_item_grp_name_el,
 MAX(CASE
   WHEN RLANG.iso_cd = 'EN'
   THEN SUBITEMGR_DESCR.sub_item_grp_descr
   ELSE NULL
   END) AS sub_item_grp_name_en,
 MAX(CASE
   WHEN RLANG.iso_cd = 'ES'
   THEN SUBITEMGR_DESCR.sub_item_grp_descr
   ELSE NULL
   END) AS sub_item_grp_name_es,
 MAX(CASE
   WHEN RLANG.iso_cd = 'FI'
   THEN SUBITEMGR_DESCR.sub_item_grp_descr
   ELSE NULL
   END) AS sub_item_grp_name_fi,
 MAX(CASE
   WHEN RLANG.iso_cd = 'FR'
   THEN SUBITEMGR_DESCR.sub_item_grp_descr
   ELSE NULL
   END) AS sub_item_grp_name_fr,
 MAX(CASE
   WHEN RLANG.iso_cd = 'HR'
   THEN SUBITEMGR_DESCR.sub_item_grp_descr
   ELSE NULL
   END) AS sub_item_grp_name_hr,
 MAX(CASE
   WHEN RLANG.iso_cd = 'HU'
   THEN SUBITEMGR_DESCR.sub_item_grp_descr
   ELSE NULL
   END) AS sub_item_grp_name_hu,
 MAX(CASE
   WHEN RLANG.iso_cd = 'IT'
   THEN SUBITEMGR_DESCR.sub_item_grp_descr
   ELSE NULL
   END) AS sub_item_grp_name_it,
 MAX(CASE
   WHEN RLANG.iso_cd = 'LT'
   THEN SUBITEMGR_DESCR.sub_item_grp_descr
   ELSE NULL
   END) AS sub_item_grp_name_lt,
 MAX(CASE
   WHEN RLANG.iso_cd = 'NL'
   THEN SUBITEMGR_DESCR.sub_item_grp_descr
   ELSE NULL
   END) AS sub_item_grp_name_nl,
 MAX(CASE
   WHEN RLANG.iso_cd = 'PL'
   THEN SUBITEMGR_DESCR.sub_item_grp_descr
   ELSE NULL
   END) AS sub_item_grp_name_pl,
 MAX(CASE
   WHEN RLANG.iso_cd = 'PT'
   THEN SUBITEMGR_DESCR.sub_item_grp_descr
   ELSE NULL
   END) AS sub_item_grp_name_pt,
 MAX(CASE
   WHEN RLANG.iso_cd = 'RO'
   THEN SUBITEMGR_DESCR.sub_item_grp_descr
   ELSE NULL
   END) AS sub_item_grp_name_ro,
 MAX(CASE
   WHEN RLANG.iso_cd = 'SH'
   THEN SUBITEMGR_DESCR.sub_item_grp_descr
   ELSE NULL
   END) AS sub_item_grp_name_sh,
 MAX(CASE
   WHEN RLANG.iso_cd = 'SK'
   THEN SUBITEMGR_DESCR.sub_item_grp_descr
   ELSE NULL
   END) AS sub_item_grp_name_sk,
 MAX(CASE
   WHEN RLANG.iso_cd = 'SL'
   THEN SUBITEMGR_DESCR.sub_item_grp_descr
   ELSE NULL
   END) AS sub_item_grp_name_sl,
 MAX(CASE
   WHEN RLANG.iso_cd = 'SV'
   THEN SUBITEMGR_DESCR.sub_item_grp_descr
   ELSE NULL
   END) AS sub_item_grp_name_sv
FROM ldl_p_lew_core_ac.v_subitemgroup_descr AS SUBITEMGR_DESCR
 INNER JOIN ldl_p_lew_core_ac.v_report_language AS RLANG ON SUBITEMGR_DESCR.lang_sid = RLANG.lang_sid
GROUP BY SUBITEMGR_DESCR.client_id,
 SUBITEMGR_DESCR.sub_item_grp_sid;