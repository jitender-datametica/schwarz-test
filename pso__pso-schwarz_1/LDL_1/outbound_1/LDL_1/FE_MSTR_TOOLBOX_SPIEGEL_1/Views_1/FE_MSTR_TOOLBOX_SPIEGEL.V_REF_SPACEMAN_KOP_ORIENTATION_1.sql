/*
#----------------------------------------------------------------------------
# Description:
# This view provides translation for the orientation kop attribute.
#
#-----------------------------------------------------------------------------
# History:
#  1.0     14.03.2025      Simeon Nikolaev         Initial Version
#
#-----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_fe_mstr_toolbox_spiegel.v_ref_spaceman_kop_orientation_1 (case_orientation_cd,
case_orientation_desc, case_orientation_desc_de, case_orientation_desc_ch, case_orientation_desc_at,
case_orientation_desc_be_fr, case_orientation_desc_bg, case_orientation_desc_cy, case_orientation_desc_cz,
case_orientation_desc_dk, case_orientation_desc_es, case_orientation_desc_fi, case_orientation_desc_fr,
case_orientation_desc_gb, case_orientation_desc_gr, case_orientation_desc_hr, case_orientation_desc_hu,
case_orientation_desc_ie, case_orientation_desc_it, case_orientation_desc_lt, case_orientation_desc_ni,
case_orientation_desc_nl, case_orientation_desc_pl, case_orientation_desc_pt, case_orientation_desc_ro,
case_orientation_desc_se, case_orientation_desc_si, case_orientation_desc_sk, case_orientation_desc_cs,
case_orientation_desc_mt, case_orientation_desc_us, case_orientation_desc_rs) AS SELECT case_orientation_cd,
 case_orientation_cd_de AS case_orientation_desc,
 case_orientation_cd_de AS case_orientation_desc_de,
 case_orientation_cd_de AS case_orientation_desc_ch,
 case_orientation_cd_de AS case_orientation_desc_at,
 case_orientation_cd AS case_orientation_desc_be_fr,
 case_orientation_cd AS case_orientation_desc_bg,
 case_orientation_cd AS case_orientation_desc_cy,
 case_orientation_cd AS case_orientation_desc_cz,
 case_orientation_cd AS case_orientation_desc_dk,
 case_orientation_cd AS case_orientation_desc_es,
 case_orientation_cd AS case_orientation_desc_fi,
 case_orientation_cd AS case_orientation_desc_fr,
 case_orientation_cd AS case_orientation_desc_gb,
 case_orientation_cd AS case_orientation_desc_gr,
 case_orientation_cd AS case_orientation_desc_hr,
 case_orientation_cd AS case_orientation_desc_hu,
 case_orientation_cd AS case_orientation_desc_ie,
 case_orientation_cd AS case_orientation_desc_it,
 case_orientation_cd AS case_orientation_desc_lt,
 case_orientation_cd AS case_orientation_desc_ni,
 case_orientation_cd AS case_orientation_desc_nl,
 case_orientation_cd AS case_orientation_desc_pl,
 case_orientation_cd AS case_orientation_desc_pt,
 case_orientation_cd AS case_orientation_desc_ro,
 case_orientation_cd AS case_orientation_desc_se,
 case_orientation_cd AS case_orientation_desc_si,
 case_orientation_cd AS case_orientation_desc_sk,
 case_orientation_cd AS case_orientation_desc_cs,
 case_orientation_cd AS case_orientation_desc_mt,
 case_orientation_cd AS case_orientation_desc_us,
 case_orientation_cd AS case_orientation_desc_rs
FROM (SELECT DISTINCT case_orientation_cd,
    CASE
    WHEN LOWER(case_orientation_cd) = 'front side'
    THEN 'Front-Seite'
    WHEN LOWER(case_orientation_cd) = 'side front'
    THEN 'Seite-Front'
    WHEN LOWER(case_orientation_cd) = 'side end'
    THEN 'Seite-Ende'
    WHEN LOWER(case_orientation_cd) = 'end side'
    THEN 'Ende-Seite'
    WHEN LOWER(case_orientation_cd) = 'end front'
    THEN 'Ende-Front'
    WHEN LOWER(case_orientation_cd) = 'front end'
    THEN 'Front-Ende'
    ELSE NULL
    END AS case_orientation_cd_de
  FROM ldl_fe_mstr_toolbox_spiegel.v_agg_spaceman_kop_1) AS t0;