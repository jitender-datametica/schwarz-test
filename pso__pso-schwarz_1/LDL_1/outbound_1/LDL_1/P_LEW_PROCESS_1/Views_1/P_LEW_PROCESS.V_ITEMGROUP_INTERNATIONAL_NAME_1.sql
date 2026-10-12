CREATE OR REPLACE VIEW ldl_p_lew_process.v_itemgroup_international_name_1 AS SELECT ITEMGROUP_INTERNATIONAL_DESCR.client_id
 ,
 ITEMGROUP_INTERNATIONAL_DESCR.item_grp_int_sid,
 MAX(CASE
   WHEN RLANG.iso_cd = '@'
   THEN ITEMGROUP_INTERNATIONAL_DESCR.item_grp_int_descr
   ELSE NULL
   END) AS item_grp_int_name,
 MAX(CASE
   WHEN RLANG.iso_cd = 'BG'
   THEN ITEMGROUP_INTERNATIONAL_DESCR.item_grp_int_descr
   ELSE NULL
   END) AS item_grp_int_name_bg,
 MAX(CASE
   WHEN RLANG.iso_cd = 'CS'
   THEN ITEMGROUP_INTERNATIONAL_DESCR.item_grp_int_descr
   ELSE NULL
   END) AS item_grp_int_name_cs,
 MAX(CASE
   WHEN RLANG.iso_cd = 'DA'
   THEN ITEMGROUP_INTERNATIONAL_DESCR.item_grp_int_descr
   ELSE NULL
   END) AS item_grp_int_name_da,
 MAX(CASE
   WHEN RLANG.iso_cd = 'DE'
   THEN ITEMGROUP_INTERNATIONAL_DESCR.item_grp_int_descr
   ELSE NULL
   END) AS item_grp_int_name_de,
 MAX(CASE
   WHEN RLANG.iso_cd = 'EL'
   THEN ITEMGROUP_INTERNATIONAL_DESCR.item_grp_int_descr
   ELSE NULL
   END) AS item_grp_int_name_el,
 MAX(CASE
   WHEN RLANG.iso_cd = 'EN'
   THEN ITEMGROUP_INTERNATIONAL_DESCR.item_grp_int_descr
   ELSE NULL
   END) AS item_grp_int_name_en,
 MAX(CASE
   WHEN RLANG.iso_cd = 'ES'
   THEN ITEMGROUP_INTERNATIONAL_DESCR.item_grp_int_descr
   ELSE NULL
   END) AS item_grp_int_name_es,
 MAX(CASE
   WHEN RLANG.iso_cd = 'FI'
   THEN ITEMGROUP_INTERNATIONAL_DESCR.item_grp_int_descr
   ELSE NULL
   END) AS item_grp_int_name_fi,
 MAX(CASE
   WHEN RLANG.iso_cd = 'FR'
   THEN ITEMGROUP_INTERNATIONAL_DESCR.item_grp_int_descr
   ELSE NULL
   END) AS item_grp_int_name_fr,
 MAX(CASE
   WHEN RLANG.iso_cd = 'HR'
   THEN ITEMGROUP_INTERNATIONAL_DESCR.item_grp_int_descr
   ELSE NULL
   END) AS item_grp_int_name_hr,
 MAX(CASE
   WHEN RLANG.iso_cd = 'HU'
   THEN ITEMGROUP_INTERNATIONAL_DESCR.item_grp_int_descr
   ELSE NULL
   END) AS item_grp_int_name_hu,
 MAX(CASE
   WHEN RLANG.iso_cd = 'IT'
   THEN ITEMGROUP_INTERNATIONAL_DESCR.item_grp_int_descr
   ELSE NULL
   END) AS item_grp_int_name_it,
 MAX(CASE
   WHEN RLANG.iso_cd = 'LT'
   THEN ITEMGROUP_INTERNATIONAL_DESCR.item_grp_int_descr
   ELSE NULL
   END) AS item_grp_int_name_lt,
 MAX(CASE
   WHEN RLANG.iso_cd = 'NL'
   THEN ITEMGROUP_INTERNATIONAL_DESCR.item_grp_int_descr
   ELSE NULL
   END) AS item_grp_int_name_nl,
 MAX(CASE
   WHEN RLANG.iso_cd = 'PL'
   THEN ITEMGROUP_INTERNATIONAL_DESCR.item_grp_int_descr
   ELSE NULL
   END) AS item_grp_int_name_pl,
 MAX(CASE
   WHEN RLANG.iso_cd = 'PT'
   THEN ITEMGROUP_INTERNATIONAL_DESCR.item_grp_int_descr
   ELSE NULL
   END) AS item_grp_int_name_pt,
 MAX(CASE
   WHEN RLANG.iso_cd = 'RO'
   THEN ITEMGROUP_INTERNATIONAL_DESCR.item_grp_int_descr
   ELSE NULL
   END) AS item_grp_int_name_ro,
 MAX(CASE
   WHEN RLANG.iso_cd = 'SH'
   THEN ITEMGROUP_INTERNATIONAL_DESCR.item_grp_int_descr
   ELSE NULL
   END) AS item_grp_int_name_sh,
 MAX(CASE
   WHEN RLANG.iso_cd = 'SK'
   THEN ITEMGROUP_INTERNATIONAL_DESCR.item_grp_int_descr
   ELSE NULL
   END) AS item_grp_int_name_sk,
 MAX(CASE
   WHEN RLANG.iso_cd = 'SL'
   THEN ITEMGROUP_INTERNATIONAL_DESCR.item_grp_int_descr
   ELSE NULL
   END) AS item_grp_int_name_sl,
 MAX(CASE
   WHEN RLANG.iso_cd = 'SV'
   THEN ITEMGROUP_INTERNATIONAL_DESCR.item_grp_int_descr
   ELSE NULL
   END) AS item_grp_int_name_sv
FROM ldl_p_lew_core_ac.v_itemgroup_international_descr_1 AS ITEMGROUP_INTERNATIONAL_DESCR
 INNER JOIN ldl_p_lew_core_ac.v_report_language_1 AS RLANG ON ITEMGROUP_INTERNATIONAL_DESCR.lang_sid = RLANG.lang_sid
GROUP BY ITEMGROUP_INTERNATIONAL_DESCR.client_id,
 ITEMGROUP_INTERNATIONAL_DESCR.item_grp_int_sid;