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


CREATE OR REPLACE VIEW ldl_p_lew_process_mstr_ac.v_ref_ldpl_coupon_type_group_2 (coupon_type_group_id
OPTIONS(description='Coupon type group identifier'), coupon_type_group_desc
OPTIONS(description='Coupon type group description'), active_fg OPTIONS(description='Activity Flag'),
coupon_type_group_desc_at OPTIONS(description='coupon type group description for lang_cd AT, currently not used'),
coupon_type_group_desc_be OPTIONS(description='coupon type group description for lang_cd BE'), coupon_type_group_desc_bg
OPTIONS(description='coupon type group description for lang_cd BG'), coupon_type_group_desc_ch
OPTIONS(description='coupon type group description for lang_cd CH, currently not used'), coupon_type_group_desc_cs
OPTIONS(description='coupon type group description for lang_cd CS'), coupon_type_group_desc_cy
OPTIONS(description='coupon type group description for lang_cd CY'), coupon_type_group_desc_cz
OPTIONS(description='coupon type group description for lang_cd CZ'), coupon_type_group_desc_de
OPTIONS(description='coupon type group description for lang_cd DE, currently not used'), coupon_type_group_desc_dk
OPTIONS(description='coupon type group description for lang_cd DK'), coupon_type_group_desc_es
OPTIONS(description='coupon type group description for lang_cd ES'), coupon_type_group_desc_fi
OPTIONS(description='coupon type group description for lang_cd FI'), coupon_type_group_desc_fr
OPTIONS(description='coupon type group description for lang_cd FR'), coupon_type_group_desc_gb
OPTIONS(description='coupon type group description for lang_cd GB'), coupon_type_group_desc_gr
OPTIONS(description='coupon type group description for lang_cd GR'), coupon_type_group_desc_hr
OPTIONS(description='coupon type group description for lang_cd HR'), coupon_type_group_desc_hu
OPTIONS(description='coupon type group description for lang_cd HU'), coupon_type_group_desc_ie
OPTIONS(description='coupon type group description for lang_cd IE'), coupon_type_group_desc_it
OPTIONS(description='coupon type group description for lang_cd IT'), coupon_type_group_desc_lt
OPTIONS(description='coupon type group description for lang_cd LT'), coupon_type_group_desc_lv
OPTIONS(description='coupon type group description for lang_cd LV'), coupon_type_group_desc_mt
OPTIONS(description='coupon type group description for lang_cd MT'), coupon_type_group_desc_ni
OPTIONS(description='coupon type group description for lang_cd NI'), coupon_type_group_desc_nl
OPTIONS(description='coupon type group description for lang_cd NL'), coupon_type_group_desc_pl
OPTIONS(description='coupon type group description for lang_cd PL'), coupon_type_group_desc_pt
OPTIONS(description='coupon type group description for lang_cd PT'), coupon_type_group_desc_ro
OPTIONS(description='coupon type group description for lang_cd RO'), coupon_type_group_desc_rs
OPTIONS(description='coupon type group description for lang_cd RS_2'), coupon_type_group_desc_se
OPTIONS(description='coupon type group description for lang_cd SE'), coupon_type_group_desc_si
OPTIONS(description='coupon type group description for lang_cd SI'), coupon_type_group_desc_sk
OPTIONS(description='coupon type group description for lang_cd SK'), coupon_type_group_desc_us
OPTIONS(description='coupon type group description for lang_cd US'), dwh_load_id OPTIONS(description='Load identifier'),
dwh_created OPTIONS(description='Row insert time'), dwh_updated OPTIONS(description='Row update time'))
OPTIONS(DESCRIPTION = `LIDL PLUS COUPON TYPE GROUP`) AS SELECT CT.coupon_type_group_id,
 CT.coupon_type_group_desc,
 CT.active_fg,
 COALESCE(lang_desc.coupon_type_group_desc_at, CT.coupon_type_group_desc) AS coupon_type_group_desc_at,
 COALESCE(lang_desc.coupon_type_group_desc_be, CT.coupon_type_group_desc) AS coupon_type_group_desc_be,
 COALESCE(lang_desc.coupon_type_group_desc_bg, CT.coupon_type_group_desc) AS coupon_type_group_desc_bg,
 COALESCE(lang_desc.coupon_type_group_desc_ch, CT.coupon_type_group_desc) AS coupon_type_group_desc_ch,
 COALESCE(lang_desc.coupon_type_group_desc_cs, CT.coupon_type_group_desc) AS coupon_type_group_desc_cs,
 COALESCE(lang_desc.coupon_type_group_desc_cy, CT.coupon_type_group_desc) AS coupon_type_group_desc_cy,
 COALESCE(lang_desc.coupon_type_group_desc_cz, CT.coupon_type_group_desc) AS coupon_type_group_desc_cz,
 COALESCE(lang_desc.coupon_type_group_desc_de, CT.coupon_type_group_desc) AS coupon_type_group_desc_de,
 COALESCE(lang_desc.coupon_type_group_desc_dk, CT.coupon_type_group_desc) AS coupon_type_group_desc_dk,
 COALESCE(lang_desc.coupon_type_group_desc_es, CT.coupon_type_group_desc) AS coupon_type_group_desc_es,
 COALESCE(lang_desc.coupon_type_group_desc_fi, CT.coupon_type_group_desc) AS coupon_type_group_desc_fi,
 COALESCE(lang_desc.coupon_type_group_desc_fr, CT.coupon_type_group_desc) AS coupon_type_group_desc_fr,
 COALESCE(lang_desc.coupon_type_group_desc_gb, CT.coupon_type_group_desc) AS coupon_type_group_desc_gb,
 COALESCE(lang_desc.coupon_type_group_desc_gr, CT.coupon_type_group_desc) AS coupon_type_group_desc_gr,
 COALESCE(lang_desc.coupon_type_group_desc_hr, CT.coupon_type_group_desc) AS coupon_type_group_desc_hr,
 COALESCE(lang_desc.coupon_type_group_desc_hu, CT.coupon_type_group_desc) AS coupon_type_group_desc_hu,
 COALESCE(lang_desc.coupon_type_group_desc_ie, CT.coupon_type_group_desc) AS coupon_type_group_desc_ie,
 COALESCE(lang_desc.coupon_type_group_desc_it, CT.coupon_type_group_desc) AS coupon_type_group_desc_it,
 COALESCE(lang_desc.coupon_type_group_desc_lt, CT.coupon_type_group_desc) AS coupon_type_group_desc_lt,
 COALESCE(lang_desc.coupon_type_group_desc_lv, CT.coupon_type_group_desc) AS coupon_type_group_desc_lv,
 COALESCE(lang_desc.coupon_type_group_desc_mt, CT.coupon_type_group_desc) AS coupon_type_group_desc_mt,
 COALESCE(lang_desc.coupon_type_group_desc_ni, CT.coupon_type_group_desc) AS coupon_type_group_desc_ni,
 COALESCE(lang_desc.coupon_type_group_desc_nl, CT.coupon_type_group_desc) AS coupon_type_group_desc_nl,
 COALESCE(lang_desc.coupon_type_group_desc_pl, CT.coupon_type_group_desc) AS coupon_type_group_desc_pl,
 COALESCE(lang_desc.coupon_type_group_desc_pt, CT.coupon_type_group_desc) AS coupon_type_group_desc_pt,
 COALESCE(lang_desc.coupon_type_group_desc_ro, CT.coupon_type_group_desc) AS coupon_type_group_desc_ro,
 COALESCE(lang_desc.coupon_type_group_desc_rs, CT.coupon_type_group_desc) AS coupon_type_group_desc_rs,
 COALESCE(lang_desc.coupon_type_group_desc_se, CT.coupon_type_group_desc) AS coupon_type_group_desc_se,
 COALESCE(lang_desc.coupon_type_group_desc_si, CT.coupon_type_group_desc) AS coupon_type_group_desc_si,
 COALESCE(lang_desc.coupon_type_group_desc_sk, CT.coupon_type_group_desc) AS coupon_type_group_desc_sk,
 COALESCE(lang_desc.coupon_type_group_desc_us, CT.coupon_type_group_desc) AS coupon_type_group_desc_us,
 CT.dwh_load_id,
 CT.dwh_created,
 CT.dwh_updated
FROM ldl_p_lew_process_mstr.v_ref_ldpl_coupon_type_group_2 AS CT
 LEFT JOIN (SELECT coupon_type_group_id,
   'AT' AS coupon_type_group_desc_at,
   'BE' AS coupon_type_group_desc_be,
   'BG' AS coupon_type_group_desc_bg,
   'CH' AS coupon_type_group_desc_ch,
   'CS' AS coupon_type_group_desc_cs,
   'CY' AS coupon_type_group_desc_cy,
   'CZ' AS coupon_type_group_desc_cz,
   'DE' AS coupon_type_group_desc_de,
   'DK' AS coupon_type_group_desc_dk,
   'ES' AS coupon_type_group_desc_es,
   'FI' AS coupon_type_group_desc_fi,
   'FR' AS coupon_type_group_desc_fr,
   'GB' AS coupon_type_group_desc_gb,
   'GR' AS coupon_type_group_desc_gr,
   'HR' AS coupon_type_group_desc_hr,
   'HU' AS coupon_type_group_desc_hu,
   'IE' AS coupon_type_group_desc_ie,
   'IT' AS coupon_type_group_desc_it,
   'LT' AS coupon_type_group_desc_lt,
   'LV' AS coupon_type_group_desc_lv,
   'MT' AS coupon_type_group_desc_mt,
   'NI' AS coupon_type_group_desc_ni,
   'NL' AS coupon_type_group_desc_nl,
   'PL' AS coupon_type_group_desc_pl,
   'PT' AS coupon_type_group_desc_pt,
   'RO' AS coupon_type_group_desc_ro,
   'RS_2' AS coupon_type_group_desc_rs,
   'SE' AS coupon_type_group_desc_se,
   'SI' AS coupon_type_group_desc_si,
   'SK' AS coupon_type_group_desc_sk,
   'US' AS coupon_type_group_desc_us
  FROM (SELECT coupon_type_group_id,
     coupon_type_group_desc,
     lang_cd
    FROM ldl_p_lew_process_mstr.v_ref_ldpl_coupon_type_group_desc_2) PIVOT (MAX(coupon_type_group_desc) FOR LANG_CD IN ('AT'
     , 'BE', 'BG', 'CH', 'CS', 'CY', 'CZ', 'DE', 'DK', 'ES', 'FI', 'FR', 'GB', 'GR', 'HR', 'HU', 'IE', 'IT', 'LT', 'LV'
     , 'MT', 'NI', 'NL', 'PL', 'PT', 'RO', 'RS_2', 'SE', 'SI', 'SK', 'US'))) AS lang_desc ON CT.coupon_type_group_id =
  lang_desc.coupon_type_group_id;