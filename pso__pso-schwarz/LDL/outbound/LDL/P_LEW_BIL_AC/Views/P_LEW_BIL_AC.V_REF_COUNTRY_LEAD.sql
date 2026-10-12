/* #DescStart#
#$Revision: 14749 $, $LastChangedBy: gkunz $
#SubjectAreas#: Access Layer
#DescEnd#
# History:
#  1.1  23.04.2020    Ross, Ulrich             Init
#  1.2  24.04.2020    Ross, Ulrich             Change layer (Database)
#  1.3  07.08.2020    Roy,Ritanjal             Introduce new country Latviya
#  1.4  13.12.2021    Morris, Michael          Add Columns for _BE_fr & _EE */
CREATE OR REPLACE VIEW ldl_p_lew_bil_ac.v_ref_country_lead (int_id, country_id, country_iso_cd, country_group_id,
lisy_sort, dashboard_relevant_fg, country_desc_at, country_desc_be, country_desc_be_fr, country_desc_bg, country_desc_ch
, country_desc_cy, country_desc_cz, country_desc, country_desc_dk, country_desc_ee, country_desc_es, country_desc_fi,
country_desc_fr, country_desc_gb, country_desc_gr, country_desc_hr, country_desc_hu, country_desc_ie, country_desc_it,
country_desc_lt, country_desc_ni, country_desc_nl, country_desc_de, country_desc_lv, country_desc_pl, country_desc_pt,
country_desc_ro, country_desc_se, country_desc_si, country_desc_sk, country_desc_cs, country_desc_mt, country_desc_us,
country_desc_rs) AS SELECT int_id,
 country_id,
 country_iso_cd,
 country_group_id,
 lisy_sort,
 dashboard_relevant_fg,
 country_desc_at,
 country_desc_be,
 country_desc_be_fr,
 country_desc_bg,
 country_desc_ch,
 country_desc_cy,
 country_desc_cz,
 country_desc,
 country_desc_dk,
 country_desc_ee,
 country_desc_es,
 country_desc_fi,
 country_desc_fr,
 country_desc_gb,
 country_desc_gr,
 country_desc_hr,
 country_desc_hu,
 country_desc_ie,
 country_desc_it,
 country_desc_lt,
 country_desc_ni,
 country_desc_nl,
 country_desc_lv AS country_desc_de,
 country_desc_de AS country_desc_lv,
 country_desc_pl,
 country_desc_pt,
 country_desc_ro,
 country_desc_se,
 country_desc_si,
 country_desc_sk,
 country_desc_cs,
 country_desc_mt,
 country_desc_us,
 country_desc_rs
FROM ldl_p_lew_bil.v_ref_country_lead;