/*
#----------------------------------------------------------------------------
# Coupon Type
#----------------------------------------------------------------------------
# History:
#
#  Vrs Date       Developer               Task
#  --- ---------- ----------------------- --------------------------------
#  1.0 2021-12-15 Pawel Wieczorek          SD-2524 Initial version
#  1.1 2022-02-08 Marcin Kikola	           Add translation
 
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_process_mstr_ac.v_ref_ldpl_feature_subgroup_2 (feature_subgroup_id
OPTIONS(description='Feature subgroup identifier'), feature_subgroup_desc
OPTIONS(description='Feature subgroup description'), feature_group_id OPTIONS(description='Feature_group identifier'),
active_fg OPTIONS(description='Activity Flag'), feature_subgroup_desc_at
OPTIONS(description='Feature subgroup description for lang_cd AT, currently not used'), feature_subgroup_desc_be
OPTIONS(description='Feature subgroup description for lang_cd BE'), feature_subgroup_desc_bg
OPTIONS(description='Feature subgroup description for lang_cd BG'), feature_subgroup_desc_ch
OPTIONS(description='Feature subgroup description for lang_cd CH, currently not used'), feature_subgroup_desc_cs
OPTIONS(description='Feature subgroup description for lang_cd CS'), feature_subgroup_desc_cy
OPTIONS(description='Feature subgroup description for lang_cd CY'), feature_subgroup_desc_cz
OPTIONS(description='Feature subgroup description for lang_cd CZ'), feature_subgroup_desc_de
OPTIONS(description='Feature subgroup description for lang_cd DE, currently not used'), feature_subgroup_desc_dk
OPTIONS(description='Feature subgroup description for lang_cd DK'), feature_subgroup_desc_es
OPTIONS(description='Feature subgroup description for lang_cd ES'), feature_subgroup_desc_fi
OPTIONS(description='Feature subgroup description for lang_cd FI'), feature_subgroup_desc_fr
OPTIONS(description='Feature subgroup description for lang_cd FR'), feature_subgroup_desc_gb
OPTIONS(description='Feature subgroup description for lang_cd GB'), feature_subgroup_desc_gr
OPTIONS(description='Feature subgroup description for lang_cd GR'), feature_subgroup_desc_hr
OPTIONS(description='Feature subgroup description for lang_cd HR'), feature_subgroup_desc_hu
OPTIONS(description='Feature subgroup description for lang_cd HU'), feature_subgroup_desc_ie
OPTIONS(description='Feature subgroup description for lang_cd IE'), feature_subgroup_desc_it
OPTIONS(description='Feature subgroup description for lang_cd IT'), feature_subgroup_desc_lt
OPTIONS(description='Feature subgroup description for lang_cd LT'), feature_subgroup_desc_lv
OPTIONS(description='Feature subgroup description for lang_cd LV'), feature_subgroup_desc_mt
OPTIONS(description='Feature subgroup description for lang_cd MT'), feature_subgroup_desc_ni
OPTIONS(description='Feature subgroup description for lang_cd NI'), feature_subgroup_desc_nl
OPTIONS(description='Feature subgroup description for lang_cd NL'), feature_subgroup_desc_pl
OPTIONS(description='Feature subgroup description for lang_cd PL'), feature_subgroup_desc_pt
OPTIONS(description='Feature subgroup description for lang_cd PT'), feature_subgroup_desc_ro
OPTIONS(description='Feature subgroup description for lang_cd RO'), feature_subgroup_desc_rs
OPTIONS(description='Feature subgroup description for lang_cd RS_2'), feature_subgroup_desc_se
OPTIONS(description='Feature subgroup description for lang_cd SE'), feature_subgroup_desc_si
OPTIONS(description='Feature subgroup description for lang_cd SI'), feature_subgroup_desc_sk
OPTIONS(description='Feature subgroup description for lang_cd SK'), feature_subgroup_desc_us
OPTIONS(description='Feature subgroup description for lang_cd US'), dwh_load_id OPTIONS(description='Load identifier'),
dwh_created OPTIONS(description='Row insert time'), dwh_updated OPTIONS(description='Row update time'))
OPTIONS(DESCRIPTION = `LIDL PLUS FEATURE SUBGROUP`) AS SELECT FS.feature_subgroup_id,
 FS.feature_subgroup_desc,
 FS.feature_group_id,
 FS.active_fg,
 COALESCE(lang_desc.feature_subgroup_desc_at, FS.feature_subgroup_desc) AS feature_subgroup_desc_at,
 COALESCE(lang_desc.feature_subgroup_desc_be, FS.feature_subgroup_desc) AS feature_subgroup_desc_be,
 COALESCE(lang_desc.feature_subgroup_desc_bg, FS.feature_subgroup_desc) AS feature_subgroup_desc_bg,
 COALESCE(lang_desc.feature_subgroup_desc_ch, FS.feature_subgroup_desc) AS feature_subgroup_desc_ch,
 COALESCE(lang_desc.feature_subgroup_desc_cs, FS.feature_subgroup_desc) AS feature_subgroup_desc_cs,
 COALESCE(lang_desc.feature_subgroup_desc_cy, FS.feature_subgroup_desc) AS feature_subgroup_desc_cy,
 COALESCE(lang_desc.feature_subgroup_desc_cz, FS.feature_subgroup_desc) AS feature_subgroup_desc_cz,
 COALESCE(lang_desc.feature_subgroup_desc_de, FS.feature_subgroup_desc) AS feature_subgroup_desc_de,
 COALESCE(lang_desc.feature_subgroup_desc_dk, FS.feature_subgroup_desc) AS feature_subgroup_desc_dk,
 COALESCE(lang_desc.feature_subgroup_desc_es, FS.feature_subgroup_desc) AS feature_subgroup_desc_es,
 COALESCE(lang_desc.feature_subgroup_desc_fi, FS.feature_subgroup_desc) AS feature_subgroup_desc_fi,
 COALESCE(lang_desc.feature_subgroup_desc_fr, FS.feature_subgroup_desc) AS feature_subgroup_desc_fr,
 COALESCE(lang_desc.feature_subgroup_desc_gb, FS.feature_subgroup_desc) AS feature_subgroup_desc_gb,
 COALESCE(lang_desc.feature_subgroup_desc_gr, FS.feature_subgroup_desc) AS feature_subgroup_desc_gr,
 COALESCE(lang_desc.feature_subgroup_desc_hr, FS.feature_subgroup_desc) AS feature_subgroup_desc_hr,
 COALESCE(lang_desc.feature_subgroup_desc_hu, FS.feature_subgroup_desc) AS feature_subgroup_desc_hu,
 COALESCE(lang_desc.feature_subgroup_desc_ie, FS.feature_subgroup_desc) AS feature_subgroup_desc_ie,
 COALESCE(lang_desc.feature_subgroup_desc_it, FS.feature_subgroup_desc) AS feature_subgroup_desc_it,
 COALESCE(lang_desc.feature_subgroup_desc_lt, FS.feature_subgroup_desc) AS feature_subgroup_desc_lt,
 COALESCE(lang_desc.feature_subgroup_desc_lv, FS.feature_subgroup_desc) AS feature_subgroup_desc_lv,
 COALESCE(lang_desc.feature_subgroup_desc_mt, FS.feature_subgroup_desc) AS feature_subgroup_desc_mt,
 COALESCE(lang_desc.feature_subgroup_desc_ni, FS.feature_subgroup_desc) AS feature_subgroup_desc_ni,
 COALESCE(lang_desc.feature_subgroup_desc_nl, FS.feature_subgroup_desc) AS feature_subgroup_desc_nl,
 COALESCE(lang_desc.feature_subgroup_desc_pl, FS.feature_subgroup_desc) AS feature_subgroup_desc_pl,
 COALESCE(lang_desc.feature_subgroup_desc_pt, FS.feature_subgroup_desc) AS feature_subgroup_desc_pt,
 COALESCE(lang_desc.feature_subgroup_desc_ro, FS.feature_subgroup_desc) AS feature_subgroup_desc_ro,
 COALESCE(lang_desc.feature_subgroup_desc_rs, FS.feature_subgroup_desc) AS feature_subgroup_desc_rs,
 COALESCE(lang_desc.feature_subgroup_desc_se, FS.feature_subgroup_desc) AS feature_subgroup_desc_se,
 COALESCE(lang_desc.feature_subgroup_desc_si, FS.feature_subgroup_desc) AS feature_subgroup_desc_si,
 COALESCE(lang_desc.feature_subgroup_desc_sk, FS.feature_subgroup_desc) AS feature_subgroup_desc_sk,
 COALESCE(lang_desc.feature_subgroup_desc_us, FS.feature_subgroup_desc) AS feature_subgroup_desc_us,
 FS.dwh_load_id,
 FS.dwh_created,
 FS.dwh_updated
FROM ldl_p_lew_process_mstr.v_ref_ldpl_feature_subgroup_2 AS FS
 LEFT JOIN (SELECT feature_subgroup_id,
   'AT' AS feature_subgroup_desc_at,
   'BE' AS feature_subgroup_desc_be,
   'BG' AS feature_subgroup_desc_bg,
   'CH' AS feature_subgroup_desc_ch,
   'CS' AS feature_subgroup_desc_cs,
   'CY' AS feature_subgroup_desc_cy,
   'CZ' AS feature_subgroup_desc_cz,
   'DE' AS feature_subgroup_desc_de,
   'DK' AS feature_subgroup_desc_dk,
   'ES' AS feature_subgroup_desc_es,
   'FI' AS feature_subgroup_desc_fi,
   'FR' AS feature_subgroup_desc_fr,
   'GB' AS feature_subgroup_desc_gb,
   'GR' AS feature_subgroup_desc_gr,
   'HR' AS feature_subgroup_desc_hr,
   'HU' AS feature_subgroup_desc_hu,
   'IE' AS feature_subgroup_desc_ie,
   'IT' AS feature_subgroup_desc_it,
   'LT' AS feature_subgroup_desc_lt,
   'LV' AS feature_subgroup_desc_lv,
   'MT' AS feature_subgroup_desc_mt,
   'NI' AS feature_subgroup_desc_ni,
   'NL' AS feature_subgroup_desc_nl,
   'PL' AS feature_subgroup_desc_pl,
   'PT' AS feature_subgroup_desc_pt,
   'RO' AS feature_subgroup_desc_ro,
   'RS_2' AS feature_subgroup_desc_rs,
   'SE' AS feature_subgroup_desc_se,
   'SI' AS feature_subgroup_desc_si,
   'SK' AS feature_subgroup_desc_sk,
   'US' AS feature_subgroup_desc_us
  FROM (SELECT feature_subgroup_id,
     feature_subgroup_desc,
     lang_cd
    FROM ldl_p_lew_process_mstr.v_ref_ldpl_feature_subgroup_desc_2) PIVOT (MAX(feature_subgroup_desc) FOR LANG_CD IN ('AT'
     , 'BE', 'BG', 'CH', 'CS', 'CY', 'CZ', 'DE', 'DK', 'ES', 'FI', 'FR', 'GB', 'GR', 'HR', 'HU', 'IE', 'IT', 'LT', 'LV'
     , 'MT', 'NI', 'NL', 'PL', 'PT', 'RO', 'RS_2', 'SE', 'SI', 'SK', 'US'))) AS lang_desc ON FS.feature_subgroup_id =
  lang_desc.feature_subgroup_id;