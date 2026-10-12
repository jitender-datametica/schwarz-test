/*
#----------------------------------------------------------------------------------------------------------------
# Interface: DDL for FE_MSTR_TOOLBOX_SPIEGEL.V_REF_SPACEMAN_KOP_PLACING_2
#----------------------------------------------------------------------------------------------------------------
# History:
#  1.0  12.03.2025	SIMEON NIKOLAEV	INITIAL SETUP
#
#----------------------------------------------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_fe_mstr_toolbox_spiegel.v_ref_spaceman_kop_placing_2 (pbt_placing, pbt_placing_desc,
pbt_placing_desc_de, pbt_placing_desc_ch, pbt_placing_desc_at, pbt_placing_desc_be_fr, pbt_placing_desc_bg,
pbt_placing_desc_cy, pbt_placing_desc_cz, pbt_placing_desc_dk, pbt_placing_desc_es, pbt_placing_desc_fi,
pbt_placing_desc_fr, pbt_placing_desc_gb, pbt_placing_desc_gr, pbt_placing_desc_hr, pbt_placing_desc_hu,
pbt_placing_desc_ie, pbt_placing_desc_it, pbt_placing_desc_lt, pbt_placing_desc_ni, pbt_placing_desc_nl,
pbt_placing_desc_pl, pbt_placing_desc_pt, pbt_placing_desc_ro, pbt_placing_desc_se, pbt_placing_desc_si,
pbt_placing_desc_sk, pbt_placing_desc_cs, pbt_placing_desc_mt, pbt_placing_desc_us, pbt_placing_desc_rs) AS SELECT
 pbt_placing,
 pbt_placing_de AS pbt_placing_desc,
 pbt_placing_de AS pbt_placing_desc_de,
 pbt_placing_de AS pbt_placing_desc_ch,
 pbt_placing_de AS pbt_placing_desc_at,
 pbt_placing_en AS pbt_placing_desc_be_fr,
 pbt_placing_en AS pbt_placing_desc_bg,
 pbt_placing_en AS pbt_placing_desc_cy,
 pbt_placing_en AS pbt_placing_desc_cz,
 pbt_placing_en AS pbt_placing_desc_dk,
 pbt_placing_en AS pbt_placing_desc_es,
 pbt_placing_en AS pbt_placing_desc_fi,
 pbt_placing_en AS pbt_placing_desc_fr,
 pbt_placing_en AS pbt_placing_desc_gb,
 pbt_placing_en AS pbt_placing_desc_gr,
 pbt_placing_en AS pbt_placing_desc_hr,
 pbt_placing_en AS pbt_placing_desc_hu,
 pbt_placing_en AS pbt_placing_desc_ie,
 pbt_placing_en AS pbt_placing_desc_it,
 pbt_placing_en AS pbt_placing_desc_lt,
 pbt_placing_en AS pbt_placing_desc_ni,
 pbt_placing_en AS pbt_placing_desc_nl,
 pbt_placing_en AS pbt_placing_desc_pl,
 pbt_placing_en AS pbt_placing_desc_pt,
 pbt_placing_en AS pbt_placing_desc_ro,
 pbt_placing_en AS pbt_placing_desc_se,
 pbt_placing_en AS pbt_placing_desc_si,
 pbt_placing_en AS pbt_placing_desc_sk,
 pbt_placing_en AS pbt_placing_desc_cs,
 pbt_placing_en AS pbt_placing_desc_mt,
 pbt_placing_en AS pbt_placing_desc_us,
 pbt_placing_en AS pbt_placing_desc_rs
FROM (SELECT DISTINCT pbt_placing,
    CASE
    WHEN pbt_placing = 'Palette - DD'
    THEN 'DD'
    WHEN pbt_placing = 'Palette - EP/GMA'
    THEN 'EP/GMA'
    WHEN pbt_placing = 'Regal - Mittel_Oberzug'
    THEN 'Middle/ Top Shelf'
    WHEN pbt_placing = 'Regal - Podest'
    THEN 'Plinth'
    ELSE ' '
    END AS pbt_placing_en,
    CASE
    WHEN pbt_placing = 'Palette - DD'
    THEN 'DD'
    WHEN pbt_placing = 'Palette - EP/GMA'
    THEN 'EP/GMA'
    WHEN pbt_placing = 'Regal - Mittel_Oberzug'
    THEN 'Mittel-/Oberzug'
    WHEN pbt_placing = 'Regal - Podest'
    THEN 'Podest'
    ELSE ' '
    END AS pbt_placing_de
  FROM ldl_fe_mstr_toolbox_spiegel.v_agg_spaceman_kop_2) AS t0;