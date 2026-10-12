CREATE OR REPLACE VIEW ldl_p_lew_process.v_item_name_1 AS SELECT DESCR.client_id,
 DESCR.item_sid,
 MAX(CASE
   WHEN RLANG.iso_cd = '@'
   THEN DESCR.item_descr
   ELSE NULL
   END) AS item_name,
 MAX(CASE
   WHEN RLANG.iso_cd = 'BG'
   THEN DESCR.item_descr
   ELSE NULL
   END) AS item_name_bg,
 MAX(CASE
   WHEN RLANG.iso_cd = 'CS'
   THEN DESCR.item_descr
   ELSE NULL
   END) AS item_name_cs,
 MAX(CASE
   WHEN RLANG.iso_cd = 'DA'
   THEN DESCR.item_descr
   ELSE NULL
   END) AS item_name_da,
 MAX(CASE
   WHEN RLANG.iso_cd = 'DE'
   THEN DESCR.item_descr
   ELSE NULL
   END) AS item_name_de,
 MAX(CASE
   WHEN RLANG.iso_cd = 'EL'
   THEN DESCR.item_descr
   ELSE NULL
   END) AS item_name_el,
 MAX(CASE
   WHEN RLANG.iso_cd = 'EN'
   THEN DESCR.item_descr
   ELSE NULL
   END) AS item_name_en,
 MAX(CASE
   WHEN RLANG.iso_cd = 'ES'
   THEN DESCR.item_descr
   ELSE NULL
   END) AS item_name_es,
 MAX(CASE
   WHEN RLANG.iso_cd = 'FI'
   THEN DESCR.item_descr
   ELSE NULL
   END) AS item_name_fi,
 MAX(CASE
   WHEN RLANG.iso_cd = 'FR'
   THEN DESCR.item_descr
   ELSE NULL
   END) AS item_name_fr,
 MAX(CASE
   WHEN RLANG.iso_cd = 'HR'
   THEN DESCR.item_descr
   ELSE NULL
   END) AS item_name_hr,
 MAX(CASE
   WHEN RLANG.iso_cd = 'HU'
   THEN DESCR.item_descr
   ELSE NULL
   END) AS item_name_hu,
 MAX(CASE
   WHEN RLANG.iso_cd = 'IT'
   THEN DESCR.item_descr
   ELSE NULL
   END) AS item_name_it,
 MAX(CASE
   WHEN RLANG.iso_cd = 'LT'
   THEN DESCR.item_descr
   ELSE NULL
   END) AS item_name_lt,
 MAX(CASE
   WHEN RLANG.iso_cd = 'NL'
   THEN DESCR.item_descr
   ELSE NULL
   END) AS item_name_nl,
 MAX(CASE
   WHEN RLANG.iso_cd = 'PL'
   THEN DESCR.item_descr
   ELSE NULL
   END) AS item_name_pl,
 MAX(CASE
   WHEN RLANG.iso_cd = 'PT'
   THEN DESCR.item_descr
   ELSE NULL
   END) AS item_name_pt,
 MAX(CASE
   WHEN RLANG.iso_cd = 'RO'
   THEN DESCR.item_descr
   ELSE NULL
   END) AS item_name_ro,
 MAX(CASE
   WHEN RLANG.iso_cd = 'SH'
   THEN DESCR.item_descr
   ELSE NULL
   END) AS item_name_sh,
 MAX(CASE
   WHEN RLANG.iso_cd = 'SK'
   THEN DESCR.item_descr
   ELSE NULL
   END) AS item_name_sk,
 MAX(CASE
   WHEN RLANG.iso_cd = 'SL'
   THEN DESCR.item_descr
   ELSE NULL
   END) AS item_name_sl,
 MAX(CASE
   WHEN RLANG.iso_cd = 'SV'
   THEN DESCR.item_descr
   ELSE NULL
   END) AS item_name_sv
FROM ldl_p_lew_core_ac.v_item_descr_1 AS DESCR
 INNER JOIN ldl_p_lew_core_ac.v_report_language_1 AS RLANG ON DESCR.lang_sid = RLANG.lang_sid
GROUP BY DESCR.client_id,
 DESCR.item_sid;