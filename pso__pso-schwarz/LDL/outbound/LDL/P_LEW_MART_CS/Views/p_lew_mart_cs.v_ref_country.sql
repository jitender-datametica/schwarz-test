/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for #X_LEW_MART_CS#.v_ref_country
#----------------------------------------------------------------------------
# History:
#  1.0  15.03.2021    Gunes, Oguzhan               Transfer to Snowflake.
#                                                  https://jira.schwarz/browse/DDLE-1783
#                                                  Create scripts for snowflake standardisation.
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_cs.v_ref_country (int_id, country_id, country_iso_cd, cluster_id, sorting_order,
dashboard_relevant_fg, country_desc_at, country_desc_be, country_desc_bg, country_desc_ch, country_desc_cy,
country_desc_cz, country_desc, country_desc_dk, country_desc_es, country_desc_fi, country_desc_fr, country_desc_gb,
country_desc_gr, country_desc_hr, country_desc_hu, country_desc_ie, country_desc_it, country_desc_lt, country_desc_ni,
country_desc_nl, country_desc_de, country_desc_pl, country_desc_pt, country_desc_ro, country_desc_se, country_desc_si,
country_desc_sk, country_desc_cs, country_desc_mt, country_desc_us, country_desc_rs) AS SELECT int_id,
 country_id,
 country_iso_cd,
 cluster_id,
 sorting_order,
 dashboard_relevant_fg,
 country_desc_at,
 country_desc_be,
 country_desc_bg,
 country_desc_ch,
 country_desc_cy,
 country_desc_cz,
 country_desc,
 country_desc_dk,
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
 country_desc_de,
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
FROM ldl_p_lew_mart_msi.v_ref_country;