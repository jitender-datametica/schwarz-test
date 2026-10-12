CREATE OR REPLACE VIEW ldl_p_lew_process.v_item_familygroup_name_1 AS SELECT IFGD_DFLT.client_id,
 IFGD_DFLT.item_fam_grp_sid,
 MAX(CASE
   WHEN RLANG.iso_cd = '@'
   THEN IFGD_DFLT.item_fam_grp_descr
   ELSE NULL
   END) AS item_fam_grp_name,
 MAX(CASE
   WHEN RLANG.iso_cd = 'BG'
   THEN IFGD_DFLT.item_fam_grp_descr
   ELSE NULL
   END) AS item_fam_grp_name_bg,
 MAX(CASE
   WHEN RLANG.iso_cd = 'CS'
   THEN IFGD_DFLT.item_fam_grp_descr
   ELSE NULL
   END) AS item_fam_grp_name_cs,
 MAX(CASE
   WHEN RLANG.iso_cd = 'DA'
   THEN IFGD_DFLT.item_fam_grp_descr
   ELSE NULL
   END) AS item_fam_grp_name_da,
 MAX(CASE
   WHEN RLANG.iso_cd = 'DE'
   THEN IFGD_DFLT.item_fam_grp_descr
   ELSE NULL
   END) AS item_fam_grp_name_de,
 MAX(CASE
   WHEN RLANG.iso_cd = 'EL'
   THEN IFGD_DFLT.item_fam_grp_descr
   ELSE NULL
   END) AS item_fam_grp_name_el,
 MAX(CASE
   WHEN RLANG.iso_cd = 'EN'
   THEN IFGD_DFLT.item_fam_grp_descr
   ELSE NULL
   END) AS item_fam_grp_name_en,
 MAX(CASE
   WHEN RLANG.iso_cd = 'ES'
   THEN IFGD_DFLT.item_fam_grp_descr
   ELSE NULL
   END) AS item_fam_grp_name_es,
 MAX(CASE
   WHEN RLANG.iso_cd = 'FI'
   THEN IFGD_DFLT.item_fam_grp_descr
   ELSE NULL
   END) AS item_fam_grp_name_fi,
 MAX(CASE
   WHEN RLANG.iso_cd = 'FR'
   THEN IFGD_DFLT.item_fam_grp_descr
   ELSE NULL
   END) AS item_fam_grp_name_fr,
 MAX(CASE
   WHEN RLANG.iso_cd = 'HR'
   THEN IFGD_DFLT.item_fam_grp_descr
   ELSE NULL
   END) AS item_fam_grp_name_hr,
 MAX(CASE
   WHEN RLANG.iso_cd = 'HU'
   THEN IFGD_DFLT.item_fam_grp_descr
   ELSE NULL
   END) AS item_fam_grp_name_hu,
 MAX(CASE
   WHEN RLANG.iso_cd = 'IT'
   THEN IFGD_DFLT.item_fam_grp_descr
   ELSE NULL
   END) AS item_fam_grp_name_it,
 MAX(CASE
   WHEN RLANG.iso_cd = 'LT'
   THEN IFGD_DFLT.item_fam_grp_descr
   ELSE NULL
   END) AS item_fam_grp_name_lt,
 MAX(CASE
   WHEN RLANG.iso_cd = 'NL'
   THEN IFGD_DFLT.item_fam_grp_descr
   ELSE NULL
   END) AS item_fam_grp_name_nl,
 MAX(CASE
   WHEN RLANG.iso_cd = 'PL'
   THEN IFGD_DFLT.item_fam_grp_descr
   ELSE NULL
   END) AS item_fam_grp_name_pl,
 MAX(CASE
   WHEN RLANG.iso_cd = 'PT'
   THEN IFGD_DFLT.item_fam_grp_descr
   ELSE NULL
   END) AS item_fam_grp_name_pt,
 MAX(CASE
   WHEN RLANG.iso_cd = 'RO'
   THEN IFGD_DFLT.item_fam_grp_descr
   ELSE NULL
   END) AS item_fam_grp_name_ro,
 MAX(CASE
   WHEN RLANG.iso_cd = 'SH'
   THEN IFGD_DFLT.item_fam_grp_descr
   ELSE NULL
   END) AS item_fam_grp_name_sh,
 MAX(CASE
   WHEN RLANG.iso_cd = 'SK'
   THEN IFGD_DFLT.item_fam_grp_descr
   ELSE NULL
   END) AS item_fam_grp_name_sk,
 MAX(CASE
   WHEN RLANG.iso_cd = 'SL'
   THEN IFGD_DFLT.item_fam_grp_descr
   ELSE NULL
   END) AS item_fam_grp_name_sl,
 MAX(CASE
   WHEN RLANG.iso_cd = 'SV'
   THEN IFGD_DFLT.item_fam_grp_descr
   ELSE NULL
   END) AS item_fam_grp_name_sv
FROM ldl_p_lew_core_ac.v_item_familygroup_descr_1 AS IFGD_DFLT
 INNER JOIN ldl_p_lew_core_ac.v_report_language_1 AS RLANG ON IFGD_DFLT.lang_sid = RLANG.lang_sid
GROUP BY IFGD_DFLT.client_id,
 IFGD_DFLT.item_fam_grp_sid;