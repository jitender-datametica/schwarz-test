/*
#----------------------------------------------------------------------------
# Coupon Type
#----------------------------------------------------------------------------
# History:
#
#  Vrs Date       Developer               Task
#  --- ---------- ----------------------- --------------------------------
#  1.0 2021-12-15 Pawel Wieczorek          SD-2524 Initial version
#  1.1 2022-02-08 Marcin Kikola	           Add translations
#  1.2 2024-06-10 Marcin Kikola            Fix for loyalty
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_process_mstr_ac.v_ref_ldpl_feature_group_1 (loyalty_id
OPTIONS(description='Loyalty atrtibute identifier'), feature_group_id OPTIONS(description='Feature_group identifier'),
feature_group_desc OPTIONS(description='Feature_group description'), active_fg OPTIONS(description='Activity Flag'),
feature_group_desc_at OPTIONS(description='Feature group description for lang_cd AT, currently not used'),
feature_group_desc_be OPTIONS(description='Feature group description for lang_cd BE'), feature_group_desc_bg
OPTIONS(description='Feature group description for lang_cd BG'), feature_group_desc_ch
OPTIONS(description='Feature group description for lang_cd CH, currently not used'), feature_group_desc_cs
OPTIONS(description='Feature group description for lang_cd CS'), feature_group_desc_cy
OPTIONS(description='Feature group description for lang_cd CY'), feature_group_desc_cz
OPTIONS(description='Feature group description for lang_cd CZ'), feature_group_desc_de
OPTIONS(description='Feature group description for lang_cd DE, currently not used'), feature_group_desc_dk
OPTIONS(description='Feature group description for lang_cd DK'), feature_group_desc_es
OPTIONS(description='Feature group description for lang_cd ES'), feature_group_desc_fi
OPTIONS(description='Feature group description for lang_cd FI'), feature_group_desc_fr
OPTIONS(description='Feature group description for lang_cd FR'), feature_group_desc_gb
OPTIONS(description='Feature group description for lang_cd GB'), feature_group_desc_gr
OPTIONS(description='Feature group description for lang_cd GR'), feature_group_desc_hr
OPTIONS(description='Feature group description for lang_cd HR'), feature_group_desc_hu
OPTIONS(description='Feature group description for lang_cd HU'), feature_group_desc_ie
OPTIONS(description='Feature group description for lang_cd IE'), feature_group_desc_it
OPTIONS(description='Feature group description for lang_cd IT'), feature_group_desc_lt
OPTIONS(description='Feature group description for lang_cd LT'), feature_group_desc_lv
OPTIONS(description='Feature group description for lang_cd LV'), feature_group_desc_mt
OPTIONS(description='Feature group description for lang_cd MT'), feature_group_desc_ni
OPTIONS(description='Feature group description for lang_cd NI'), feature_group_desc_nl
OPTIONS(description='Feature group description for lang_cd NL'), feature_group_desc_pl
OPTIONS(description='Feature group description for lang_cd PL'), feature_group_desc_pt
OPTIONS(description='Feature group description for lang_cd PT'), feature_group_desc_ro
OPTIONS(description='Feature group description for lang_cd RO'), feature_group_desc_rs
OPTIONS(description='Feature group description for lang_cd RS_1'), feature_group_desc_se
OPTIONS(description='Feature group description for lang_cd SE'), feature_group_desc_si
OPTIONS(description='Feature group description for lang_cd SI'), feature_group_desc_sk
OPTIONS(description='Feature group description for lang_cd SK'), feature_group_desc_us
OPTIONS(description='Feature group description for lang_cd US'), dwh_load_id OPTIONS(description='Load identifier'),
dwh_created OPTIONS(description='Row insert time'), dwh_updated OPTIONS(description='Row update time'))
OPTIONS(DESCRIPTION = `LIDL PLUS FEATURE_GROUP`) AS SELECT FS.loyalty_id,
 FS.feature_group_id,
 FS.feature_group_desc,
 FS.active_fg,
 COALESCE(lang_desc.feature_group_desc_at, FS.feature_group_desc) AS feature_group_desc_at,
 COALESCE(lang_desc.feature_group_desc_be, FS.feature_group_desc) AS feature_group_desc_be,
 COALESCE(lang_desc.feature_group_desc_bg, FS.feature_group_desc) AS feature_group_desc_bg,
 COALESCE(lang_desc.feature_group_desc_ch, FS.feature_group_desc) AS feature_group_desc_ch,
 COALESCE(lang_desc.feature_group_desc_cs, FS.feature_group_desc) AS feature_group_desc_cs,
 COALESCE(lang_desc.feature_group_desc_cy, FS.feature_group_desc) AS feature_group_desc_cy,
 COALESCE(lang_desc.feature_group_desc_cz, FS.feature_group_desc) AS feature_group_desc_cz,
 COALESCE(lang_desc.feature_group_desc_de, FS.feature_group_desc) AS feature_group_desc_de,
 COALESCE(lang_desc.feature_group_desc_dk, FS.feature_group_desc) AS feature_group_desc_dk,
 COALESCE(lang_desc.feature_group_desc_es, FS.feature_group_desc) AS feature_group_desc_es,
 COALESCE(lang_desc.feature_group_desc_fi, FS.feature_group_desc) AS feature_group_desc_fi,
 COALESCE(lang_desc.feature_group_desc_fr, FS.feature_group_desc) AS feature_group_desc_fr,
 COALESCE(lang_desc.feature_group_desc_gb, FS.feature_group_desc) AS feature_group_desc_gb,
 COALESCE(lang_desc.feature_group_desc_gr, FS.feature_group_desc) AS feature_group_desc_gr,
 COALESCE(lang_desc.feature_group_desc_hr, FS.feature_group_desc) AS feature_group_desc_hr,
 COALESCE(lang_desc.feature_group_desc_hu, FS.feature_group_desc) AS feature_group_desc_hu,
 COALESCE(lang_desc.feature_group_desc_ie, FS.feature_group_desc) AS feature_group_desc_ie,
 COALESCE(lang_desc.feature_group_desc_it, FS.feature_group_desc) AS feature_group_desc_it,
 COALESCE(lang_desc.feature_group_desc_lt, FS.feature_group_desc) AS feature_group_desc_lt,
 COALESCE(lang_desc.feature_group_desc_lv, FS.feature_group_desc) AS feature_group_desc_lv,
 COALESCE(lang_desc.feature_group_desc_mt, FS.feature_group_desc) AS feature_group_desc_mt,
 COALESCE(lang_desc.feature_group_desc_ni, FS.feature_group_desc) AS feature_group_desc_ni,
 COALESCE(lang_desc.feature_group_desc_nl, FS.feature_group_desc) AS feature_group_desc_nl,
 COALESCE(lang_desc.feature_group_desc_pl, FS.feature_group_desc) AS feature_group_desc_pl,
 COALESCE(lang_desc.feature_group_desc_pt, FS.feature_group_desc) AS feature_group_desc_pt,
 COALESCE(lang_desc.feature_group_desc_ro, FS.feature_group_desc) AS feature_group_desc_ro,
 COALESCE(lang_desc.feature_group_desc_rs, FS.feature_group_desc) AS feature_group_desc_rs,
 COALESCE(lang_desc.feature_group_desc_se, FS.feature_group_desc) AS feature_group_desc_se,
 COALESCE(lang_desc.feature_group_desc_si, FS.feature_group_desc) AS feature_group_desc_si,
 COALESCE(lang_desc.feature_group_desc_sk, FS.feature_group_desc) AS feature_group_desc_sk,
 COALESCE(lang_desc.feature_group_desc_us, FS.feature_group_desc) AS feature_group_desc_us,
 FS.dwh_load_id,
 FS.dwh_created,
 FS.dwh_updated
FROM ldl_p_lew_process_mstr.v_ref_ldpl_feature_group_1 AS FS
 LEFT JOIN (SELECT feature_group_id,
   'AT' AS feature_group_desc_at,
   'BE' AS feature_group_desc_be,
   'BG' AS feature_group_desc_bg,
   'CH' AS feature_group_desc_ch,
   'CS' AS feature_group_desc_cs,
   'CY' AS feature_group_desc_cy,
   'CZ' AS feature_group_desc_cz,
   'DE' AS feature_group_desc_de,
   'DK' AS feature_group_desc_dk,
   'ES' AS feature_group_desc_es,
   'FI' AS feature_group_desc_fi,
   'FR' AS feature_group_desc_fr,
   'GB' AS feature_group_desc_gb,
   'GR' AS feature_group_desc_gr,
   'HR' AS feature_group_desc_hr,
   'HU' AS feature_group_desc_hu,
   'IE' AS feature_group_desc_ie,
   'IT' AS feature_group_desc_it,
   'LT' AS feature_group_desc_lt,
   'LV' AS feature_group_desc_lv,
   'MT' AS feature_group_desc_mt,
   'NI' AS feature_group_desc_ni,
   'NL' AS feature_group_desc_nl,
   'PL' AS feature_group_desc_pl,
   'PT' AS feature_group_desc_pt,
   'RO' AS feature_group_desc_ro,
   'RS_1' AS feature_group_desc_rs,
   'SE' AS feature_group_desc_se,
   'SI' AS feature_group_desc_si,
   'SK' AS feature_group_desc_sk,
   'US' AS feature_group_desc_us
  FROM (SELECT feature_group_id,
     feature_group_desc,
     lang_cd
    FROM ldl_p_lew_process_mstr.v_ref_ldpl_feature_group_desc_1) PIVOT (MAX(feature_group_desc) FOR LANG_CD IN ('AT', 'BE'
     , 'BG', 'CH', 'CS', 'CY', 'CZ', 'DE', 'DK', 'ES', 'FI', 'FR', 'GB', 'GR', 'HR', 'HU', 'IE', 'IT', 'LT', 'LV', 'MT'
     , 'NI', 'NL', 'PL', 'PT', 'RO', 'RS_1', 'SE', 'SI', 'SK', 'US'))) AS lang_desc ON FS.feature_group_id = lang_desc.feature_group_id;