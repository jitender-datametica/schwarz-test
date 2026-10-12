CREATE OR REPLACE VIEW ldl_p_lew_process.v_main_item_group_name_1 AS SELECT MAINITEMGROUP.mainitemgroup_id,
 MAX(CASE
   WHEN LANG.language_iso_cd = 'DE'
   THEN MAINITEMGROUP.mainitemgroup_desc
   ELSE NULL
   END) AS mainitemgroup_name,
 MAX(CASE
   WHEN LANG.language_iso_cd = 'BG'
   THEN MAINITEMGROUP.mainitemgroup_desc
   ELSE NULL
   END) AS mainitemgroup_name_bg,
 MAX(CASE
   WHEN LANG.language_iso_cd = 'CZ'
   THEN MAINITEMGROUP.mainitemgroup_desc
   ELSE NULL
   END) AS mainitemgroup_name_cs,
 MAX(CASE
   WHEN LANG.language_iso_cd = 'DE'
   THEN MAINITEMGROUP.mainitemgroup_desc
   ELSE NULL
   END) AS mainitemgroup_name_de,
 MAX(CASE
   WHEN LANG.language_iso_cd = 'DK'
   THEN MAINITEMGROUP.mainitemgroup_desc
   ELSE NULL
   END) AS mainitemgroup_name_da,
 MAX(CASE
   WHEN LANG.language_iso_cd = 'GR'
   THEN MAINITEMGROUP.mainitemgroup_short_desc
   ELSE NULL
   END) AS mainitemgroup_name_el,
 MAX(CASE
   WHEN LANG.language_iso_cd = 'GB'
   THEN MAINITEMGROUP.mainitemgroup_desc
   ELSE NULL
   END) AS mainitemgroup_name_en,
 MAX(CASE
   WHEN LANG.language_iso_cd = 'ES'
   THEN MAINITEMGROUP.mainitemgroup_desc
   ELSE NULL
   END) AS mainitemgroup_name_es,
 MAX(CASE
   WHEN LANG.language_iso_cd = 'FI'
   THEN MAINITEMGROUP.mainitemgroup_desc
   ELSE NULL
   END) AS mainitemgroup_name_fi,
 MAX(CASE
   WHEN LANG.language_iso_cd = 'FR'
   THEN MAINITEMGROUP.mainitemgroup_short_desc
   ELSE NULL
   END) AS mainitemgroup_name_fr,
 MAX(CASE
   WHEN LANG.language_iso_cd = 'HR'
   THEN MAINITEMGROUP.mainitemgroup_desc
   ELSE NULL
   END) AS mainitemgroup_name_hr,
 MAX(CASE
   WHEN LANG.language_iso_cd = 'HU'
   THEN MAINITEMGROUP.mainitemgroup_desc
   ELSE NULL
   END) AS mainitemgroup_name_hu,
 MAX(CASE
   WHEN LANG.language_iso_cd = 'IT'
   THEN MAINITEMGROUP.mainitemgroup_desc
   ELSE NULL
   END) AS mainitemgroup_name_it,
 MAX(CASE
   WHEN LANG.language_iso_cd = 'LT'
   THEN MAINITEMGROUP.mainitemgroup_desc
   ELSE NULL
   END) AS mainitemgroup_name_lt,
 MAX(CASE
   WHEN LANG.language_iso_cd = 'NL'
   THEN MAINITEMGROUP.mainitemgroup_desc
   ELSE NULL
   END) AS mainitemgroup_name_nl,
 MAX(CASE
   WHEN LANG.language_iso_cd = 'PL'
   THEN MAINITEMGROUP.mainitemgroup_short_desc
   ELSE NULL
   END) AS mainitemgroup_name_pl,
 MAX(CASE
   WHEN LANG.language_iso_cd = 'PT'
   THEN MAINITEMGROUP.mainitemgroup_desc
   ELSE NULL
   END) AS mainitemgroup_name_pt,
 MAX(CASE
   WHEN LANG.language_iso_cd = 'RO'
   THEN MAINITEMGROUP.mainitemgroup_short_desc
   ELSE NULL
   END) AS mainitemgroup_name_ro,
 MAX(CASE
   WHEN LANG.language_iso_cd = 'RS_1'
   THEN MAINITEMGROUP.mainitemgroup_desc
   ELSE NULL
   END) AS mainitemgroup_name_sh,
 MAX(CASE
   WHEN LANG.language_iso_cd = 'SK'
   THEN MAINITEMGROUP.mainitemgroup_desc
   ELSE NULL
   END) AS mainitemgroup_name_sk,
 MAX(CASE
   WHEN LANG.language_iso_cd = 'SI'
   THEN MAINITEMGROUP.mainitemgroup_desc
   ELSE NULL
   END) AS mainitemgroup_name_sl,
 MAX(CASE
   WHEN LANG.language_iso_cd = 'SE'
   THEN MAINITEMGROUP.mainitemgroup_desc
   ELSE NULL
   END) AS mainitemgroup_name_sv
FROM ldl_p_lew_core_ac.v_wawi_itm_mainitemgroup_1 AS MAINITEMGROUP
 INNER JOIN ldl_p_lew_core_ac.v_wawi_ref_language_1 AS LANG ON MAINITEMGROUP.language_id = LANG.language_id
WHERE MAINITEMGROUP.dat_rec_end = CAST('12/31/9999' AS DATE)
GROUP BY MAINITEMGROUP.mainitemgroup_id;