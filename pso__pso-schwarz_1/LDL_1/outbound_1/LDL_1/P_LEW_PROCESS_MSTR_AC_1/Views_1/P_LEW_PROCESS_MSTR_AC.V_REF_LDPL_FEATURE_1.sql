/*
#----------------------------------------------------------------------------
# Coupon Type
#----------------------------------------------------------------------------
# History:
#
#  Vrs Date       Developer               Task
#  --- ---------- ----------------------- --------------------------------
#  1.0 2021-12-15 Pawel Wieczorek          SD-2524 Initial version
#  1.1 2022-02-08 Pawel Wieczorek          Add translation
#
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_process_mstr_ac.v_ref_ldpl_feature_1 (feature_id
OPTIONS(description='Feature identifier'), feature_subgroup_id OPTIONS(description='Feature subgroup description'),
feature_desc
OPTIONS(description='Default feature type description, which is not exactly the SCRM value from in P_LEW_PROCESS_MSTR.T_REF_LDPL_FEATURE_TYPE.feature_type_desc'),
feature_desc_at OPTIONS(description='Feature description for lang_cd AT, currently not used'), feature_desc_be
OPTIONS(description='Feature description for lang_cd BE'), feature_desc_bg
OPTIONS(description='Feature description for lang_cd BG'), feature_desc_ch
OPTIONS(description='Feature description for lang_cd CH, currently not used'), feature_desc_cs
OPTIONS(description='Feature description for lang_cd CS'), feature_desc_cy
OPTIONS(description='Feature description for lang_cd CY'), feature_desc_cz
OPTIONS(description='Feature description for lang_cd CZ'), feature_desc_de
OPTIONS(description='Feature description for lang_cd DE, currently not used'), feature_desc_dk
OPTIONS(description='Feature description for lang_cd DK'), feature_desc_es
OPTIONS(description='Feature description for lang_cd ES'), feature_desc_fi
OPTIONS(description='Feature description for lang_cd FI'), feature_desc_fr
OPTIONS(description='Feature description for lang_cd FR'), feature_desc_gb
OPTIONS(description='Feature description for lang_cd GB'), feature_desc_gr
OPTIONS(description='Feature description for lang_cd GR'), feature_desc_hr
OPTIONS(description='Feature description for lang_cd HR'), feature_desc_hu
OPTIONS(description='Feature description for lang_cd HU'), feature_desc_ie
OPTIONS(description='Feature description for lang_cd IE'), feature_desc_it
OPTIONS(description='Feature description for lang_cd IT'), feature_desc_lt
OPTIONS(description='Feature description for lang_cd LT'), feature_desc_lv
OPTIONS(description='Feature description for lang_cd LV'), feature_desc_mt
OPTIONS(description='Feature description for lang_cd MT'), feature_desc_ni
OPTIONS(description='Feature description for lang_cd NI'), feature_desc_nl
OPTIONS(description='Feature description for lang_cd NL'), feature_desc_pl
OPTIONS(description='Feature description for lang_cd PL'), feature_desc_pt
OPTIONS(description='Feature description for lang_cd PT'), feature_desc_ro
OPTIONS(description='Feature description for lang_cd RO'), feature_desc_rs
OPTIONS(description='Feature description for lang_cd RS_1'), feature_desc_se
OPTIONS(description='Feature description for lang_cd SE'), feature_desc_si
OPTIONS(description='Feature description for lang_cd SI'), feature_desc_sk
OPTIONS(description='Feature description for lang_cd SK'), feature_desc_us
OPTIONS(description='Feature description for lang_cd US'), dwh_load_id OPTIONS(description='Load identifier'),
dwh_created OPTIONS(description='Row insert time'), dwh_updated OPTIONS(description='Row update time'))
OPTIONS(DESCRIPTION = `LIDL PLUS FEATURE WITH TRANSLATIONS`) AS SELECT F.feature_id,
 F.feature_subgroup_id,
 COALESCE(lang_desc.feature_desc_de, F.feature_desc) AS feature_desc,
 COALESCE(lang_desc.feature_desc_at, lang_desc.feature_desc_de, F.feature_desc) AS feature_desc_at,
 COALESCE(lang_desc.feature_desc_be, lang_desc.feature_desc_de, F.feature_desc) AS feature_desc_be,
 COALESCE(lang_desc.feature_desc_bg, lang_desc.feature_desc_de, F.feature_desc) AS feature_desc_bg,
 COALESCE(lang_desc.feature_desc_ch, lang_desc.feature_desc_de, F.feature_desc) AS feature_desc_ch,
 COALESCE(lang_desc.feature_desc_cs, lang_desc.feature_desc_de, F.feature_desc) AS feature_desc_cs,
 COALESCE(lang_desc.feature_desc_cy, lang_desc.feature_desc_de, F.feature_desc) AS feature_desc_cy,
 COALESCE(lang_desc.feature_desc_cz, lang_desc.feature_desc_de, F.feature_desc) AS feature_desc_cz,
 COALESCE(lang_desc.feature_desc_de, F.feature_desc) AS feature_desc_de,
 COALESCE(lang_desc.feature_desc_dk, lang_desc.feature_desc_de, F.feature_desc) AS feature_desc_dk,
 COALESCE(lang_desc.feature_desc_es, lang_desc.feature_desc_de, F.feature_desc) AS feature_desc_es,
 COALESCE(lang_desc.feature_desc_fi, lang_desc.feature_desc_de, F.feature_desc) AS feature_desc_fi,
 COALESCE(lang_desc.feature_desc_fr, lang_desc.feature_desc_de, F.feature_desc) AS feature_desc_fr,
 COALESCE(lang_desc.feature_desc_gb, lang_desc.feature_desc_de, F.feature_desc) AS feature_desc_gb,
 COALESCE(lang_desc.feature_desc_gr, lang_desc.feature_desc_de, F.feature_desc) AS feature_desc_gr,
 COALESCE(lang_desc.feature_desc_hr, lang_desc.feature_desc_de, F.feature_desc) AS feature_desc_hr,
 COALESCE(lang_desc.feature_desc_hu, lang_desc.feature_desc_de, F.feature_desc) AS feature_desc_hu,
 COALESCE(lang_desc.feature_desc_ie, lang_desc.feature_desc_de, F.feature_desc) AS feature_desc_ie,
 COALESCE(lang_desc.feature_desc_it, lang_desc.feature_desc_de, F.feature_desc) AS feature_desc_it,
 COALESCE(lang_desc.feature_desc_lt, lang_desc.feature_desc_de, F.feature_desc) AS feature_desc_lt,
 COALESCE(lang_desc.feature_desc_lv, lang_desc.feature_desc_de, F.feature_desc) AS feature_desc_lv,
 COALESCE(lang_desc.feature_desc_mt, lang_desc.feature_desc_de, F.feature_desc) AS feature_desc_mt,
 COALESCE(lang_desc.feature_desc_ni, lang_desc.feature_desc_de, F.feature_desc) AS feature_desc_ni,
 COALESCE(lang_desc.feature_desc_nl, lang_desc.feature_desc_de, F.feature_desc) AS feature_desc_nl,
 COALESCE(lang_desc.feature_desc_pl, lang_desc.feature_desc_de, F.feature_desc) AS feature_desc_pl,
 COALESCE(lang_desc.feature_desc_pt, lang_desc.feature_desc_de, F.feature_desc) AS feature_desc_pt,
 COALESCE(lang_desc.feature_desc_ro, lang_desc.feature_desc_de, F.feature_desc) AS feature_desc_ro,
 COALESCE(lang_desc.feature_desc_rs, lang_desc.feature_desc_de, F.feature_desc) AS feature_desc_rs,
 COALESCE(lang_desc.feature_desc_se, lang_desc.feature_desc_de, F.feature_desc) AS feature_desc_se,
 COALESCE(lang_desc.feature_desc_si, lang_desc.feature_desc_de, F.feature_desc) AS feature_desc_si,
 COALESCE(lang_desc.feature_desc_sk, lang_desc.feature_desc_de, F.feature_desc) AS feature_desc_sk,
 COALESCE(lang_desc.feature_desc_us, lang_desc.feature_desc_de, F.feature_desc) AS feature_desc_us,
 F.dwh_load_id,
 F.dwh_created,
 F.dwh_updated
FROM ldl_p_lew_process_mstr.v_ref_ldpl_feature_1 AS F
 LEFT JOIN (SELECT feature_id,
   'AT' AS feature_desc_at,
   'BE' AS feature_desc_be,
   'BG' AS feature_desc_bg,
   'CH' AS feature_desc_ch,
   'CS' AS feature_desc_cs,
   'CY' AS feature_desc_cy,
   'CZ' AS feature_desc_cz,
   'DE' AS feature_desc_de,
   'DK' AS feature_desc_dk,
   'ES' AS feature_desc_es,
   'FI' AS feature_desc_fi,
   'FR' AS feature_desc_fr,
   'GB' AS feature_desc_gb,
   'GR' AS feature_desc_gr,
   'HR' AS feature_desc_hr,
   'HU' AS feature_desc_hu,
   'IE' AS feature_desc_ie,
   'IT' AS feature_desc_it,
   'LT' AS feature_desc_lt,
   'LV' AS feature_desc_lv,
   'MT' AS feature_desc_mt,
   'NI' AS feature_desc_ni,
   'NL' AS feature_desc_nl,
   'PL' AS feature_desc_pl,
   'PT' AS feature_desc_pt,
   'RO' AS feature_desc_ro,
   'RS_1' AS feature_desc_rs,
   'SE' AS feature_desc_se,
   'SI' AS feature_desc_si,
   'SK' AS feature_desc_sk,
   'US' AS feature_desc_us
  FROM (SELECT feature_id,
     feature_desc,
     lang_cd
    FROM ldl_p_lew_process_mstr.v_ref_ldpl_feature_desc_1) PIVOT (MAX(feature_desc) FOR LANG_CD IN ('AT', 'BE', 'BG', 'CH'
     , 'CS', 'CY', 'CZ', 'DE', 'DK', 'ES', 'FI', 'FR', 'GB', 'GR', 'HR', 'HU', 'IE', 'IT', 'LT', 'LV', 'MT', 'NI', 'NL'
     , 'PL', 'PT', 'RO', 'RS_1', 'SE', 'SI', 'SK', 'US'))) AS lang_desc ON F.feature_id = lang_desc.feature_id;