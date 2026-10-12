CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_msi.v_itm_familygroup_1
OPTIONS(DESCRIPTION = 'MULTI LANGUAGE ITEM_1 FAMILY GROUP DESCRIPTIONS')
AS
/* extraktion des familycodes aus Kompositfeld, Datentypangleichung */ /* Datentypangleichung */
/* Basistabelle familygroups */ /* Basistabelle Unterwarengruppen */ 
SELECT IFG.client_id,
  CASE
  WHEN STRPOS(IFG.src_familygrp_cd, '.') > 0 AND STRPOS(IFG.src_familygrp_cd, '.') < LENGTH(IFG.src_familygrp_cd)
  THEN ROUND(CAST(SUBSTR(IFG.src_familygrp_cd, STRPOS(IFG.src_familygrp_cd, '.') + 1) AS BIGNUMERIC), 0)
  ELSE NULL
  END AS family_cd,
 COALESCE(IFG.src_familygrp_id, IFG.item_fam_grp_sid) AS item_familygroup_id,
 CAST(ROUND(CAST(SIG.src_subitemgrp_cd AS BIGNUMERIC), 0) AS BIGNUMERIC) AS subitemgroup_id,
 IFG.src_familygrp_cd,
  CASE
  WHEN IFG.client_id = 1 AND IFG.lang_cd_default = 'DE'
  THEN IFG.item_family_desc_default
  ELSE NULL
  END AS item_family_desc_at,
  CASE
  WHEN IFG.client_id = 2 AND IFG.lang_cd_default = 'FR'
  THEN IFG.item_family_desc_default
  ELSE NULL
  END AS item_family_desc_be,
  CASE
  WHEN IFG.client_id = 2 AND IFG.lang_cd_default = 'FR'
  THEN IFG.item_family_desc_default
  ELSE NULL
  END AS item_family_desc_be_fr,
  CASE
  WHEN IFG.client_id = 3 AND IFG.lang_cd_default = 'BG'
  THEN IFG.item_family_desc_default
  ELSE NULL
  END AS item_family_desc_bg,
  CASE
  WHEN IFG.client_id = 4 AND IFG.lang_cd_default = 'DE'
  THEN IFG.item_family_desc_default
  ELSE NULL
  END AS item_family_desc_ch,
  CASE
  WHEN IFG.client_id = 5 AND IFG.lang_cd_default = 'EL'
  THEN IFG.item_family_desc_default
  ELSE NULL
  END AS item_family_desc_cy,
  CASE
  WHEN IFG.client_id = 6 AND IFG.lang_cd_default = 'CS'
  THEN IFG.item_family_desc_default
  ELSE NULL
  END AS item_family_desc_cz,
 IFG.item_family_desc_lidl AS item_family_desc,
  CASE
  WHEN IFG.client_id = 8 AND IFG.lang_cd_default = 'DA'
  THEN IFG.item_family_desc_default
  ELSE NULL
  END AS item_family_desc_dk,
  CASE
  WHEN IFG.client_id = 9 AND IFG.lang_cd_default = 'EE'
  THEN IFG.item_family_desc_default
  ELSE NULL
  END AS item_family_desc_ee,
  CASE
  WHEN IFG.client_id IN (10, 31) AND IFG.lang_cd_default = 'ES'
  THEN IFG.item_family_desc_default
  ELSE NULL
  END AS item_family_desc_es,
  CASE
  WHEN IFG.client_id = 11 AND IFG.lang_cd_default = 'FI'
  THEN IFG.item_family_desc_default
  ELSE NULL
  END AS item_family_desc_fi,
  CASE
  WHEN IFG.client_id = 12 AND IFG.lang_cd_default = 'FR'
  THEN IFG.item_family_desc_default
  ELSE NULL
  END AS item_family_desc_fr,
  CASE
  WHEN IFG.client_id = 13 AND IFG.lang_cd_default = 'EN'
  THEN IFG.item_family_desc_default
  ELSE NULL
  END AS item_family_desc_gb,
  CASE
  WHEN IFG.client_id IN (5, 14) AND IFG.lang_cd_default = 'EL'
  THEN IFG.item_family_desc_default
  ELSE NULL
  END AS item_family_desc_gr,
  CASE
  WHEN IFG.client_id = 15 AND IFG.lang_cd_default = 'HR'
  THEN IFG.item_family_desc_default
  ELSE NULL
  END AS item_family_desc_hr,
  CASE
  WHEN IFG.client_id = 16 AND IFG.lang_cd_default = 'HU'
  THEN IFG.item_family_desc_default
  ELSE NULL
  END AS item_family_desc_hu,
  CASE
  WHEN IFG.client_id IN (17, 21) AND IFG.lang_cd_default = 'EN'
  THEN IFG.item_family_desc_default
  ELSE NULL
  END AS item_family_desc_ie,
  CASE
  WHEN IFG.client_id IN (18, 32) AND IFG.lang_cd_default = 'IT'
  THEN IFG.item_family_desc_default
  ELSE NULL
  END AS item_family_desc_it,
  CASE
  WHEN IFG.client_id = 19 AND IFG.lang_cd_default = 'LT'
  THEN IFG.item_family_desc_default
  ELSE NULL
  END AS item_family_desc_lt,
  CASE
  WHEN IFG.client_id = 20 AND IFG.lang_cd_default = 'LV'
  THEN IFG.item_family_desc_default
  ELSE NULL
  END AS item_family_desc_lv,
  CASE
  WHEN IFG.client_id = 21 AND IFG.lang_cd_default = 'EN'
  THEN IFG.item_family_desc_default
  ELSE NULL
  END AS item_family_desc_ni,
  CASE
  WHEN IFG.client_id = 22 AND IFG.lang_cd_default = 'NL'
  THEN IFG.item_family_desc_default
  ELSE NULL
  END AS item_family_desc_nl,
  CASE
  WHEN IFG.client_id = 23 AND IFG.lang_cd_default = 'DE'
  THEN IFG.item_family_desc_default
  ELSE NULL
  END AS item_family_desc_de,
  CASE
  WHEN IFG.client_id = 24 AND IFG.lang_cd_default = 'PL'
  THEN IFG.item_family_desc_default
  ELSE NULL
  END AS item_family_desc_pl,
  CASE
  WHEN IFG.client_id = 25 AND IFG.lang_cd_default = 'PT'
  THEN IFG.item_family_desc_default
  ELSE NULL
  END AS item_family_desc_pt,
  CASE
  WHEN IFG.client_id = 26 AND IFG.lang_cd_default = 'RO'
  THEN IFG.item_family_desc_default
  ELSE NULL
  END AS item_family_desc_ro,
  CASE
  WHEN IFG.client_id = 27 AND IFG.lang_cd_default = 'SV'
  THEN IFG.item_family_desc_default
  ELSE NULL
  END AS item_family_desc_se,
  CASE
  WHEN IFG.client_id = 28 AND IFG.lang_cd_default = 'SL'
  THEN IFG.item_family_desc_default
  ELSE NULL
  END AS item_family_desc_si,
  CASE
  WHEN IFG.client_id = 29 AND IFG.lang_cd_default = 'SK'
  THEN IFG.item_family_desc_default
  ELSE NULL
  END AS item_family_desc_sk,
  CASE
  WHEN IFG.client_id = 31 AND IFG.lang_cd_default = 'ES'
  THEN IFG.item_family_desc_default
  ELSE NULL
  END AS item_family_desc_cs,
  CASE
  WHEN IFG.client_id = 32 AND IFG.lang_cd_default = 'IT'
  THEN IFG.item_family_desc_default
  ELSE NULL
  END AS item_family_desc_mt,
  CASE
  WHEN IFG.client_id = 33 AND IFG.lang_cd_default = 'EN'
  THEN IFG.item_family_desc_default
  ELSE NULL
  END AS item_family_desc_us,
  CASE
  WHEN IFG.client_id = 34 AND IFG.lang_cd_default = 'SH'
  THEN IFG.item_family_desc_default
  ELSE NULL
  END AS item_family_desc_rs,
  CASE
  WHEN IFG.client_id = 1 AND IFG.lang_cd_default = 'DE'
  THEN IFG.item_family_desc_default
  ELSE NULL
  END AS item_family_short_desc_at,
  CASE
  WHEN IFG.client_id = 2 AND IFG.lang_cd_default = 'FR'
  THEN IFG.item_family_desc_default
  ELSE NULL
  END AS item_family_short_desc_be,
  CASE
  WHEN IFG.client_id = 2 AND IFG.lang_cd_default = 'FR'
  THEN IFG.item_family_desc_default
  ELSE NULL
  END AS item_family_short_desc_be_fr,
  CASE
  WHEN IFG.client_id = 3 AND IFG.lang_cd_default = 'BG'
  THEN IFG.item_family_desc_default
  ELSE NULL
  END AS item_family_short_desc_bg,
  CASE
  WHEN IFG.client_id = 4 AND IFG.lang_cd_default = 'DE'
  THEN IFG.item_family_desc_default
  ELSE NULL
  END AS item_family_short_desc_ch,
  CASE
  WHEN IFG.client_id = 5 AND IFG.lang_cd_default = 'EL'
  THEN IFG.item_family_desc_default
  ELSE NULL
  END AS item_family_short_desc_cy,
  CASE
  WHEN IFG.client_id = 6 AND IFG.lang_cd_default = 'CS'
  THEN IFG.item_family_desc_default
  ELSE NULL
  END AS item_family_short_desc_cz,
 IFG.item_family_desc_lidl AS item_family_short_desc,
  CASE
  WHEN IFG.client_id = 8 AND IFG.lang_cd_default = 'DA'
  THEN IFG.item_family_desc_default
  ELSE NULL
  END AS item_family_short_desc_dk,
  CASE
  WHEN IFG.client_id = 9 AND IFG.lang_cd_default = 'EE'
  THEN IFG.item_family_desc_default
  ELSE NULL
  END AS item_family_short_desc_ee,
  CASE
  WHEN IFG.client_id IN (10, 31) AND IFG.lang_cd_default = 'ES'
  THEN IFG.item_family_desc_default
  ELSE NULL
  END AS item_family_short_desc_es,
  CASE
  WHEN IFG.client_id = 11 AND IFG.lang_cd_default = 'FI'
  THEN IFG.item_family_desc_default
  ELSE NULL
  END AS item_family_short_desc_fi,
  CASE
  WHEN IFG.client_id = 12 AND IFG.lang_cd_default = 'FR'
  THEN IFG.item_family_desc_default
  ELSE NULL
  END AS item_family_short_desc_fr,
  CASE
  WHEN IFG.client_id = 13 AND IFG.lang_cd_default = 'EN'
  THEN IFG.item_family_desc_default
  ELSE NULL
  END AS item_family_short_desc_gb,
  CASE
  WHEN IFG.client_id IN (5, 14) AND IFG.lang_cd_default = 'EL'
  THEN IFG.item_family_desc_default
  ELSE NULL
  END AS item_family_short_desc_gr,
  CASE
  WHEN IFG.client_id = 15 AND IFG.lang_cd_default = 'HR'
  THEN IFG.item_family_desc_default
  ELSE NULL
  END AS item_family_short_desc_hr,
  CASE
  WHEN IFG.client_id = 16 AND IFG.lang_cd_default = 'HU'
  THEN IFG.item_family_desc_default
  ELSE NULL
  END AS item_family_short_desc_hu,
  CASE
  WHEN IFG.client_id = 17 AND IFG.lang_cd_default = 'EN'
  THEN IFG.item_family_desc_default
  ELSE NULL
  END AS item_family_short_desc_ie,
  CASE
  WHEN IFG.client_id IN (18, 32) AND IFG.lang_cd_default = 'IT'
  THEN IFG.item_family_desc_default
  ELSE NULL
  END AS item_family_short_desc_it,
  CASE
  WHEN IFG.client_id = 19 AND IFG.lang_cd_default = 'LT'
  THEN IFG.item_family_desc_default
  ELSE NULL
  END AS item_family_short_desc_lt,
  CASE
  WHEN IFG.client_id = 20 AND IFG.lang_cd_default = 'LV'
  THEN IFG.item_family_desc_default
  ELSE NULL
  END AS item_family_short_desc_lv,
  CASE
  WHEN IFG.client_id IN (17, 21) AND IFG.lang_cd_default = 'EN'
  THEN IFG.item_family_desc_default
  ELSE NULL
  END AS item_family_short_desc_ni,
  CASE
  WHEN IFG.client_id = 22 AND IFG.lang_cd_default = 'NL'
  THEN IFG.item_family_desc_default
  ELSE NULL
  END AS item_family_short_desc_nl,
  CASE
  WHEN IFG.client_id = 23 AND IFG.lang_cd_default = 'DE'
  THEN IFG.item_family_desc_default
  ELSE NULL
  END AS item_family_short_desc_de,
  CASE
  WHEN IFG.client_id = 24 AND IFG.lang_cd_default = 'PL'
  THEN IFG.item_family_desc_default
  ELSE NULL
  END AS item_family_short_desc_pl,
  CASE
  WHEN IFG.client_id = 25 AND IFG.lang_cd_default = 'PT'
  THEN IFG.item_family_desc_default
  ELSE NULL
  END AS item_family_short_desc_pt,
  CASE
  WHEN IFG.client_id = 26 AND IFG.lang_cd_default = 'RO'
  THEN IFG.item_family_desc_default
  ELSE NULL
  END AS item_family_short_desc_ro,
  CASE
  WHEN IFG.client_id = 27 AND IFG.lang_cd_default = 'SV'
  THEN IFG.item_family_desc_default
  ELSE NULL
  END AS item_family_short_desc_se,
  CASE
  WHEN IFG.client_id = 28 AND IFG.lang_cd_default = 'SL'
  THEN IFG.item_family_desc_default
  ELSE NULL
  END AS item_family_short_desc_si,
  CASE
  WHEN IFG.client_id = 29 AND IFG.lang_cd_default = 'SK'
  THEN IFG.item_family_desc_default
  ELSE NULL
  END AS item_family_short_desc_sk,
  CASE
  WHEN IFG.client_id IN (10, 31) AND IFG.lang_cd_default = 'ES'
  THEN IFG.item_family_desc_default
  ELSE NULL
  END AS item_family_short_desc_cs,
  CASE
  WHEN IFG.client_id = 32 AND IFG.lang_cd_default = 'IT'
  THEN IFG.item_family_desc_default
  ELSE NULL
  END AS item_family_short_desc_mt,
  CASE
  WHEN IFG.client_id = 33 AND IFG.lang_cd_default = 'EN'
  THEN IFG.item_family_desc_default
  ELSE NULL
  END AS item_family_short_desc_us,
  CASE
  WHEN IFG.client_id = 34 AND IFG.lang_cd_default = 'SH'
  THEN IFG.item_family_desc_default
  ELSE NULL
  END AS item_family_short_desc_rs
FROM ldl_p_lew_bil_ac.v_item_familygroup_1 AS IFG
 INNER JOIN ldl_p_lew_core_ac.v_subitemgroup_1 AS SIG ON IFG.sub_item_grp_sid = SIG.sub_item_grp_sid
QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(IFG.client_id AS STRING), CAST(COALESCE(IFG.src_familygrp_id, IFG.item_fam_grp_sid) AS STRING)
      ORDER BY IFG.item_fam_grp_sid IS NULL, IFG.item_fam_grp_sid)) = 1;
