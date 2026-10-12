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


CREATE OR REPLACE VIEW ldl_p_lew_process_mstr_ac.v_ref_ldpl_discount_type (discount_type_id
OPTIONS(description='Discount type identifier'), discount_type_desc
OPTIONS(description='Default discount type description, which is not exactly the SCRM value from in P_LEW_PROCESS_MSTR.T_REF_LDPL_DISCOUNT_TYPE.discount_type_desc'),
discount_type_desc_at OPTIONS(description='discount type description for lang_cd AT, currently not used'),
discount_type_desc_be OPTIONS(description='discount type description for lang_cd BE'), discount_type_desc_bg
OPTIONS(description='discount type description for lang_cd BG'), discount_type_desc_ch
OPTIONS(description='discount type description for lang_cd CH, currently not used'), discount_type_desc_cs
OPTIONS(description='discount type description for lang_cd CS'), discount_type_desc_cy
OPTIONS(description='discount type description for lang_cd CY'), discount_type_desc_cz
OPTIONS(description='discount type description for lang_cd CZ'), discount_type_desc_de
OPTIONS(description='discount type description for lang_cd DE, currently not used'), discount_type_desc_dk
OPTIONS(description='discount type description for lang_cd DK'), discount_type_desc_es
OPTIONS(description='discount type description for lang_cd ES'), discount_type_desc_fi
OPTIONS(description='discount type description for lang_cd FI'), discount_type_desc_fr
OPTIONS(description='discount type description for lang_cd FR'), discount_type_desc_gb
OPTIONS(description='discount type description for lang_cd GB'), discount_type_desc_gr
OPTIONS(description='discount type description for lang_cd GR'), discount_type_desc_hr
OPTIONS(description='discount type description for lang_cd HR'), discount_type_desc_hu
OPTIONS(description='discount type description for lang_cd HU'), discount_type_desc_ie
OPTIONS(description='discount type description for lang_cd IE'), discount_type_desc_it
OPTIONS(description='discount type description for lang_cd IT'), discount_type_desc_lt
OPTIONS(description='discount type description for lang_cd LT'), discount_type_desc_lv
OPTIONS(description='discount type description for lang_cd LV'), discount_type_desc_mt
OPTIONS(description='discount type description for lang_cd MT'), discount_type_desc_ni
OPTIONS(description='discount type description for lang_cd NI'), discount_type_desc_nl
OPTIONS(description='discount type description for lang_cd NL'), discount_type_desc_pl
OPTIONS(description='discount type description for lang_cd PL'), discount_type_desc_pt
OPTIONS(description='discount type description for lang_cd PT'), discount_type_desc_ro
OPTIONS(description='discount type description for lang_cd RO'), discount_type_desc_rs
OPTIONS(description='discount type description for lang_cd RS'), discount_type_desc_se
OPTIONS(description='discount type description for lang_cd SE'), discount_type_desc_si
OPTIONS(description='discount type description for lang_cd SI'), discount_type_desc_sk
OPTIONS(description='discount type description for lang_cd SK'), discount_type_desc_us
OPTIONS(description='discount type description for lang_cd US'), dwh_load_id OPTIONS(description='Load identifier'),
dwh_created OPTIONS(description='Row insert time'), dwh_updated OPTIONS(description='Row update time'))
OPTIONS(DESCRIPTION = `LIDL PLUS DISCOUNT TYPE`) AS SELECT D.discount_type_id,
 COALESCE(lang_desc.discount_type_desc_de, D.discount_type_desc) AS discount_type_desc,
 COALESCE(lang_desc.discount_type_desc_at, lang_desc.discount_type_desc_de, D.discount_type_desc) AS
 discount_type_desc_at,
 COALESCE(lang_desc.discount_type_desc_be, lang_desc.discount_type_desc_de, D.discount_type_desc) AS
 discount_type_desc_be,
 COALESCE(lang_desc.discount_type_desc_bg, lang_desc.discount_type_desc_de, D.discount_type_desc) AS
 discount_type_desc_bg,
 COALESCE(lang_desc.discount_type_desc_ch, lang_desc.discount_type_desc_de, D.discount_type_desc) AS
 discount_type_desc_ch,
 COALESCE(lang_desc.discount_type_desc_cs, lang_desc.discount_type_desc_de, D.discount_type_desc) AS
 discount_type_desc_cs,
 COALESCE(lang_desc.discount_type_desc_cy, lang_desc.discount_type_desc_de, D.discount_type_desc) AS
 discount_type_desc_cy,
 COALESCE(lang_desc.discount_type_desc_cz, lang_desc.discount_type_desc_de, D.discount_type_desc) AS
 discount_type_desc_cz,
 COALESCE(lang_desc.discount_type_desc_de, D.discount_type_desc) AS discount_type_desc_de,
 COALESCE(lang_desc.discount_type_desc_dk, lang_desc.discount_type_desc_de, D.discount_type_desc) AS
 discount_type_desc_dk,
 COALESCE(lang_desc.discount_type_desc_es, lang_desc.discount_type_desc_de, D.discount_type_desc) AS
 discount_type_desc_es,
 COALESCE(lang_desc.discount_type_desc_fi, lang_desc.discount_type_desc_de, D.discount_type_desc) AS
 discount_type_desc_fi,
 COALESCE(lang_desc.discount_type_desc_fr, lang_desc.discount_type_desc_de, D.discount_type_desc) AS
 discount_type_desc_fr,
 COALESCE(lang_desc.discount_type_desc_gb, lang_desc.discount_type_desc_de, D.discount_type_desc) AS
 discount_type_desc_gb,
 COALESCE(lang_desc.discount_type_desc_gr, lang_desc.discount_type_desc_de, D.discount_type_desc) AS
 discount_type_desc_gr,
 COALESCE(lang_desc.discount_type_desc_hr, lang_desc.discount_type_desc_de, D.discount_type_desc) AS
 discount_type_desc_hr,
 COALESCE(lang_desc.discount_type_desc_hu, lang_desc.discount_type_desc_de, D.discount_type_desc) AS
 discount_type_desc_hu,
 COALESCE(lang_desc.discount_type_desc_ie, lang_desc.discount_type_desc_de, D.discount_type_desc) AS
 discount_type_desc_ie,
 COALESCE(lang_desc.discount_type_desc_it, lang_desc.discount_type_desc_de, D.discount_type_desc) AS
 discount_type_desc_it,
 COALESCE(lang_desc.discount_type_desc_lt, lang_desc.discount_type_desc_de, D.discount_type_desc) AS
 discount_type_desc_lt,
 COALESCE(lang_desc.discount_type_desc_lv, lang_desc.discount_type_desc_de, D.discount_type_desc) AS
 discount_type_desc_lv,
 COALESCE(lang_desc.discount_type_desc_mt, lang_desc.discount_type_desc_de, D.discount_type_desc) AS
 discount_type_desc_mt,
 COALESCE(lang_desc.discount_type_desc_ni, lang_desc.discount_type_desc_de, D.discount_type_desc) AS
 discount_type_desc_ni,
 COALESCE(lang_desc.discount_type_desc_nl, lang_desc.discount_type_desc_de, D.discount_type_desc) AS
 discount_type_desc_nl,
 COALESCE(lang_desc.discount_type_desc_pl, lang_desc.discount_type_desc_de, D.discount_type_desc) AS
 discount_type_desc_pl,
 COALESCE(lang_desc.discount_type_desc_pt, lang_desc.discount_type_desc_de, D.discount_type_desc) AS
 discount_type_desc_pt,
 COALESCE(lang_desc.discount_type_desc_ro, lang_desc.discount_type_desc_de, D.discount_type_desc) AS
 discount_type_desc_ro,
 COALESCE(lang_desc.discount_type_desc_rs, lang_desc.discount_type_desc_de, D.discount_type_desc) AS
 discount_type_desc_rs,
 COALESCE(lang_desc.discount_type_desc_se, lang_desc.discount_type_desc_de, D.discount_type_desc) AS
 discount_type_desc_se,
 COALESCE(lang_desc.discount_type_desc_si, lang_desc.discount_type_desc_de, D.discount_type_desc) AS
 discount_type_desc_si,
 COALESCE(lang_desc.discount_type_desc_sk, lang_desc.discount_type_desc_de, D.discount_type_desc) AS
 discount_type_desc_sk,
 COALESCE(lang_desc.discount_type_desc_us, lang_desc.discount_type_desc_de, D.discount_type_desc) AS
 discount_type_desc_us,
 D.dwh_load_id,
 D.dwh_created,
 D.dwh_updated
FROM ldl_p_lew_process_mstr.v_ref_ldpl_discount_type AS D
 LEFT JOIN (SELECT discount_type_id,
   'AT' AS discount_type_desc_at,
   'BE' AS discount_type_desc_be,
   'BG' AS discount_type_desc_bg,
   'CH' AS discount_type_desc_ch,
   'CS' AS discount_type_desc_cs,
   'CY' AS discount_type_desc_cy,
   'CZ' AS discount_type_desc_cz,
   'DE' AS discount_type_desc_de,
   'DK' AS discount_type_desc_dk,
   'ES' AS discount_type_desc_es,
   'FI' AS discount_type_desc_fi,
   'FR' AS discount_type_desc_fr,
   'GB' AS discount_type_desc_gb,
   'GR' AS discount_type_desc_gr,
   'HR' AS discount_type_desc_hr,
   'HU' AS discount_type_desc_hu,
   'IE' AS discount_type_desc_ie,
   'IT' AS discount_type_desc_it,
   'LT' AS discount_type_desc_lt,
   'LV' AS discount_type_desc_lv,
   'MT' AS discount_type_desc_mt,
   'NI' AS discount_type_desc_ni,
   'NL' AS discount_type_desc_nl,
   'PL' AS discount_type_desc_pl,
   'PT' AS discount_type_desc_pt,
   'RO' AS discount_type_desc_ro,
   'RS' AS discount_type_desc_rs,
   'SE' AS discount_type_desc_se,
   'SI' AS discount_type_desc_si,
   'SK' AS discount_type_desc_sk,
   'US' AS discount_type_desc_us
  FROM (SELECT discount_type_id,
     discount_type_desc,
     lang_cd
    FROM ldl_p_lew_process_mstr.v_ref_ldpl_discount_type_desc) PIVOT (MAX(discount_type_desc) FOR LANG_CD IN ('AT', 'BE'
     , 'BG', 'CH', 'CS', 'CY', 'CZ', 'DE', 'DK', 'ES', 'FI', 'FR', 'GB', 'GR', 'HR', 'HU', 'IE', 'IT', 'LT', 'LV', 'MT'
     , 'NI', 'NL', 'PL', 'PT', 'RO', 'RS', 'SE', 'SI', 'SK', 'US'))) AS lang_desc ON D.discount_type_id = lang_desc.discount_type_id;