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


CREATE OR REPLACE VIEW ldl_p_lew_process_mstr_ac.v_ref_ldpl_coupon_type_subgroup_2 (coupon_type_subgroup_id
OPTIONS(description='Coupon type subgroup identifier'), coupon_type_subgroup_desc
OPTIONS(description='Coupon type subgroup description'), coupon_type_group_id
OPTIONS(description='Coupon type group description'), active_fg OPTIONS(description='Activity Flag'),
coupon_type_subgroup_desc_at OPTIONS(description='coupon subgroup description for lang_cd AT, currently not used'),
coupon_type_subgroup_desc_be OPTIONS(description='coupon subgroup description for lang_cd BE'),
coupon_type_subgroup_desc_bg OPTIONS(description='coupon subgroup description for lang_cd BG'),
coupon_type_subgroup_desc_ch OPTIONS(description='coupon subgroup description for lang_cd CH, currently not used'),
coupon_type_subgroup_desc_cs OPTIONS(description='coupon subgroup description for lang_cd CS'),
coupon_type_subgroup_desc_cy OPTIONS(description='coupon subgroup description for lang_cd CY'),
coupon_type_subgroup_desc_cz OPTIONS(description='coupon subgroup description for lang_cd CZ'),
coupon_type_subgroup_desc_de OPTIONS(description='coupon subgroup description for lang_cd DE, currently not used'),
coupon_type_subgroup_desc_dk OPTIONS(description='coupon subgroup description for lang_cd DK'),
coupon_type_subgroup_desc_es OPTIONS(description='coupon subgroup description for lang_cd ES'),
coupon_type_subgroup_desc_fi OPTIONS(description='coupon subgroup description for lang_cd FI'),
coupon_type_subgroup_desc_fr OPTIONS(description='coupon subgroup description for lang_cd FR'),
coupon_type_subgroup_desc_gb OPTIONS(description='coupon subgroup description for lang_cd GB'),
coupon_type_subgroup_desc_gr OPTIONS(description='coupon subgroup description for lang_cd GR'),
coupon_type_subgroup_desc_hr OPTIONS(description='coupon subgroup description for lang_cd HR'),
coupon_type_subgroup_desc_hu OPTIONS(description='coupon subgroup description for lang_cd HU'),
coupon_type_subgroup_desc_ie OPTIONS(description='coupon subgroup description for lang_cd IE'),
coupon_type_subgroup_desc_it OPTIONS(description='coupon subgroup description for lang_cd IT'),
coupon_type_subgroup_desc_lt OPTIONS(description='coupon subgroup description for lang_cd LT'),
coupon_type_subgroup_desc_lv OPTIONS(description='coupon subgroup description for lang_cd LV'),
coupon_type_subgroup_desc_mt OPTIONS(description='coupon subgroup description for lang_cd MT'),
coupon_type_subgroup_desc_ni OPTIONS(description='coupon subgroup description for lang_cd NI'),
coupon_type_subgroup_desc_nl OPTIONS(description='coupon subgroup description for lang_cd NL'),
coupon_type_subgroup_desc_pl OPTIONS(description='coupon subgroup description for lang_cd PL'),
coupon_type_subgroup_desc_pt OPTIONS(description='coupon subgroup description for lang_cd PT'),
coupon_type_subgroup_desc_ro OPTIONS(description='coupon subgroup description for lang_cd RO'),
coupon_type_subgroup_desc_rs OPTIONS(description='coupon subgroup description for lang_cd RS_2'),
coupon_type_subgroup_desc_se OPTIONS(description='coupon subgroup description for lang_cd SE'),
coupon_type_subgroup_desc_si OPTIONS(description='coupon subgroup description for lang_cd SI'),
coupon_type_subgroup_desc_sk OPTIONS(description='coupon subgroup description for lang_cd SK'),
coupon_type_subgroup_desc_us OPTIONS(description='coupon subgroup description for lang_cd US'), dwh_load_id
OPTIONS(description='Load identifier'), dwh_created OPTIONS(description='Row insert time'), dwh_updated
OPTIONS(description='Row update time')) OPTIONS(DESCRIPTION = `LIDL PLUS COUPON TYPE SUBGROUP`) AS SELECT CS.coupon_type_subgroup_id
 ,
 CS.coupon_type_subgroup_desc,
 CS.coupon_type_group_id,
 CS.active_fg,
 COALESCE(lang_desc.coupon_type_subgroup_at, CS.coupon_type_subgroup_desc) AS coupon_type_subgroup_desc_at,
 COALESCE(lang_desc.coupon_type_subgroup_be, CS.coupon_type_subgroup_desc) AS coupon_type_subgroup_desc_be,
 COALESCE(lang_desc.coupon_type_subgroup_bg, CS.coupon_type_subgroup_desc) AS coupon_type_subgroup_desc_bg,
 COALESCE(lang_desc.coupon_type_subgroup_ch, CS.coupon_type_subgroup_desc) AS coupon_type_subgroup_desc_ch,
 COALESCE(lang_desc.coupon_type_subgroup_cs, CS.coupon_type_subgroup_desc) AS coupon_type_subgroup_desc_cs,
 COALESCE(lang_desc.coupon_type_subgroup_cy, CS.coupon_type_subgroup_desc) AS coupon_type_subgroup_desc_cy,
 COALESCE(lang_desc.coupon_type_subgroup_cz, CS.coupon_type_subgroup_desc) AS coupon_type_subgroup_desc_cz,
 COALESCE(lang_desc.coupon_type_subgroup_de, CS.coupon_type_subgroup_desc) AS coupon_type_subgroup_desc_de,
 COALESCE(lang_desc.coupon_type_subgroup_dk, CS.coupon_type_subgroup_desc) AS coupon_type_subgroup_desc_dk,
 COALESCE(lang_desc.coupon_type_subgroup_es, CS.coupon_type_subgroup_desc) AS coupon_type_subgroup_desc_es,
 COALESCE(lang_desc.coupon_type_subgroup_fi, CS.coupon_type_subgroup_desc) AS coupon_type_subgroup_desc_fi,
 COALESCE(lang_desc.coupon_type_subgroup_fr, CS.coupon_type_subgroup_desc) AS coupon_type_subgroup_desc_fr,
 COALESCE(lang_desc.coupon_type_subgroup_gb, CS.coupon_type_subgroup_desc) AS coupon_type_subgroup_desc_gb,
 COALESCE(lang_desc.coupon_type_subgroup_gr, CS.coupon_type_subgroup_desc) AS coupon_type_subgroup_desc_gr,
 COALESCE(lang_desc.coupon_type_subgroup_hr, CS.coupon_type_subgroup_desc) AS coupon_type_subgroup_desc_hr,
 COALESCE(lang_desc.coupon_type_subgroup_hu, CS.coupon_type_subgroup_desc) AS coupon_type_subgroup_desc_hu,
 COALESCE(lang_desc.coupon_type_subgroup_ie, CS.coupon_type_subgroup_desc) AS coupon_type_subgroup_desc_ie,
 COALESCE(lang_desc.coupon_type_subgroup_it, CS.coupon_type_subgroup_desc) AS coupon_type_subgroup_desc_it,
 COALESCE(lang_desc.coupon_type_subgroup_lt, CS.coupon_type_subgroup_desc) AS coupon_type_subgroup_desc_lt,
 COALESCE(lang_desc.coupon_type_subgroup_lv, CS.coupon_type_subgroup_desc) AS coupon_type_subgroup_desc_lv,
 COALESCE(lang_desc.coupon_type_subgroup_mt, CS.coupon_type_subgroup_desc) AS coupon_type_subgroup_desc_mt,
 COALESCE(lang_desc.coupon_type_subgroup_ni, CS.coupon_type_subgroup_desc) AS coupon_type_subgroup_desc_ni,
 COALESCE(lang_desc.coupon_type_subgroup_nl, CS.coupon_type_subgroup_desc) AS coupon_type_subgroup_desc_nl,
 COALESCE(lang_desc.coupon_type_subgroup_pl, CS.coupon_type_subgroup_desc) AS coupon_type_subgroup_desc_pl,
 COALESCE(lang_desc.coupon_type_subgroup_pt, CS.coupon_type_subgroup_desc) AS coupon_type_subgroup_desc_pt,
 COALESCE(lang_desc.coupon_type_subgroup_ro, CS.coupon_type_subgroup_desc) AS coupon_type_subgroup_desc_ro,
 COALESCE(lang_desc.coupon_type_subgroup_rs, CS.coupon_type_subgroup_desc) AS coupon_type_subgroup_desc_rs,
 COALESCE(lang_desc.coupon_type_subgroup_se, CS.coupon_type_subgroup_desc) AS coupon_type_subgroup_desc_se,
 COALESCE(lang_desc.coupon_type_subgroup_si, CS.coupon_type_subgroup_desc) AS coupon_type_subgroup_desc_si,
 COALESCE(lang_desc.coupon_type_subgroup_sk, CS.coupon_type_subgroup_desc) AS coupon_type_subgroup_desc_sk,
 COALESCE(lang_desc.coupon_type_subgroup_us, CS.coupon_type_subgroup_desc) AS coupon_type_subgroup_desc_us,
 CS.dwh_load_id,
 CS.dwh_created,
 CS.dwh_updated
FROM ldl_p_lew_process_mstr.v_ref_ldpl_coupon_type_subgroup_2 AS CS
 LEFT JOIN (SELECT coupon_type_subgroup_id,
   'AT' AS coupon_type_subgroup_at,
   'BE' AS coupon_type_subgroup_be,
   'BG' AS coupon_type_subgroup_bg,
   'CH' AS coupon_type_subgroup_ch,
   'CS' AS coupon_type_subgroup_cs,
   'CY' AS coupon_type_subgroup_cy,
   'CZ' AS coupon_type_subgroup_cz,
   'DE' AS coupon_type_subgroup_de,
   'DK' AS coupon_type_subgroup_dk,
   'ES' AS coupon_type_subgroup_es,
   'FI' AS coupon_type_subgroup_fi,
   'FR' AS coupon_type_subgroup_fr,
   'GB' AS coupon_type_subgroup_gb,
   'GR' AS coupon_type_subgroup_gr,
   'HR' AS coupon_type_subgroup_hr,
   'HU' AS coupon_type_subgroup_hu,
   'IE' AS coupon_type_subgroup_ie,
   'IT' AS coupon_type_subgroup_it,
   'LT' AS coupon_type_subgroup_lt,
   'LV' AS coupon_type_subgroup_lv,
   'MT' AS coupon_type_subgroup_mt,
   'NI' AS coupon_type_subgroup_ni,
   'NL' AS coupon_type_subgroup_nl,
   'PL' AS coupon_type_subgroup_pl,
   'PT' AS coupon_type_subgroup_pt,
   'RO' AS coupon_type_subgroup_ro,
   'RS_2' AS coupon_type_subgroup_rs,
   'SE' AS coupon_type_subgroup_se,
   'SI' AS coupon_type_subgroup_si,
   'SK' AS coupon_type_subgroup_sk,
   'US' AS coupon_type_subgroup_us
  FROM (SELECT coupon_type_subgroup_id,
     coupon_type_subgroup_desc,
     lang_cd
    FROM ldl_p_lew_process_mstr.v_ref_ldpl_coupon_type_subgroup_desc_2) PIVOT (MAX(coupon_type_subgroup_desc) FOR LANG_CD
    IN ('AT', 'BE', 'BG', 'CH', 'CS', 'CY', 'CZ', 'DE', 'DK', 'ES', 'FI', 'FR', 'GB', 'GR', 'HR', 'HU', 'IE', 'IT', 'LT'
     , 'LV', 'MT', 'NI', 'NL', 'PL', 'PT', 'RO', 'RS_2', 'SE', 'SI', 'SK', 'US'))) AS lang_desc ON CS.coupon_type_subgroup_id
   = lang_desc.coupon_type_subgroup_id;