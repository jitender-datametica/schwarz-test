/*
#----------------------------------------------------------------------------
# © LIDL Stiftung & Co. KG - DWH / MIS LEAD
#----------------------------------------------------------------------------
# Interface : DDL for view P_LEW_MART_LEAD.v_cockpit_attr_name_transl
#----------------------------------------------------------------------------
# History:
#  1.0    2024-01-15         Marcin Malec              Initial version.
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_lead.v_cockpit_attr_name_transl (identifier_id, identifier_flag,
identifier_display_name, identifier_display_name_at, identifier_display_name_be, identifier_display_name_be_fr,
identifier_display_name_bg, identifier_display_name_ch, identifier_display_name_cs, identifier_display_name_cy,
identifier_display_name_cz, identifier_display_name_dk, identifier_display_name_ee, identifier_display_name_es,
identifier_display_name_fi, identifier_display_name_fr, identifier_display_name_gb, identifier_display_name_gr,
identifier_display_name_hr, identifier_display_name_hu, identifier_display_name_ie, identifier_display_name_it,
identifier_display_name_lt, identifier_display_name_lv, identifier_display_name_mt, identifier_display_name_ni,
identifier_display_name_nl, identifier_display_name_pl, identifier_display_name_pt, identifier_display_name_ro,
identifier_display_name_rs, identifier_display_name_se, identifier_display_name_si, identifier_display_name_sk,
identifier_display_name_us) AS SELECT ATTR_MAP.identifier_id,
 ATTR_MAP.identifier_flag,
 ATTR_MAP.identifier_display_name,
  CAST(REPEAT(' ', LENGTH(ATTR_MAP.identifier_display_name) - LENGTH(TRIM(ATTR_MAP.identifier_display_name))) AS STRING)
  || COALESCE(TRANSL.transl_at, TRIM(ATTR_MAP.identifier_display_name)) AS identifier_display_name_at,
  CAST(REPEAT(' ', LENGTH(ATTR_MAP.identifier_display_name) - LENGTH(TRIM(ATTR_MAP.identifier_display_name))) AS STRING)
  || COALESCE(TRANSL.transl_be, TRIM(ATTR_MAP.identifier_display_name)) AS identifier_display_name_be,
  CAST(REPEAT(' ', LENGTH(ATTR_MAP.identifier_display_name) - LENGTH(TRIM(ATTR_MAP.identifier_display_name))) AS STRING)
  || COALESCE(TRANSL.transl_be_fr, TRIM(ATTR_MAP.identifier_display_name)) AS identifier_display_name_be_fr,
  CAST(REPEAT(' ', LENGTH(ATTR_MAP.identifier_display_name) - LENGTH(TRIM(ATTR_MAP.identifier_display_name))) AS STRING)
  || COALESCE(TRANSL.transl_bg, TRIM(ATTR_MAP.identifier_display_name)) AS identifier_display_name_bg,
  CAST(REPEAT(' ', LENGTH(ATTR_MAP.identifier_display_name) - LENGTH(TRIM(ATTR_MAP.identifier_display_name))) AS STRING)
  || COALESCE(TRANSL.transl_ch, TRIM(ATTR_MAP.identifier_display_name)) AS identifier_display_name_ch,
  CAST(REPEAT(' ', LENGTH(ATTR_MAP.identifier_display_name) - LENGTH(TRIM(ATTR_MAP.identifier_display_name))) AS STRING)
  || COALESCE(TRANSL.transl_cs, TRIM(ATTR_MAP.identifier_display_name)) AS identifier_display_name_cs,
  CAST(REPEAT(' ', LENGTH(ATTR_MAP.identifier_display_name) - LENGTH(TRIM(ATTR_MAP.identifier_display_name))) AS STRING)
  || COALESCE(TRANSL.transl_cy, TRIM(ATTR_MAP.identifier_display_name)) AS identifier_display_name_cy,
  CAST(REPEAT(' ', LENGTH(ATTR_MAP.identifier_display_name) - LENGTH(TRIM(ATTR_MAP.identifier_display_name))) AS STRING)
  || COALESCE(TRANSL.transl_cz, TRIM(ATTR_MAP.identifier_display_name)) AS identifier_display_name_cz,
  CAST(REPEAT(' ', LENGTH(ATTR_MAP.identifier_display_name) - LENGTH(TRIM(ATTR_MAP.identifier_display_name))) AS STRING)
  || COALESCE(TRANSL.transl_dk, TRIM(ATTR_MAP.identifier_display_name)) AS identifier_display_name_dk,
  CAST(REPEAT(' ', LENGTH(ATTR_MAP.identifier_display_name) - LENGTH(TRIM(ATTR_MAP.identifier_display_name))) AS STRING)
  || COALESCE(TRANSL.transl_ee, TRIM(ATTR_MAP.identifier_display_name)) AS identifier_display_name_ee,
  CAST(REPEAT(' ', LENGTH(ATTR_MAP.identifier_display_name) - LENGTH(TRIM(ATTR_MAP.identifier_display_name))) AS STRING)
  || COALESCE(TRANSL.transl_es, TRIM(ATTR_MAP.identifier_display_name)) AS identifier_display_name_es,
  CAST(REPEAT(' ', LENGTH(ATTR_MAP.identifier_display_name) - LENGTH(TRIM(ATTR_MAP.identifier_display_name))) AS STRING)
  || COALESCE(TRANSL.transl_fi, TRIM(ATTR_MAP.identifier_display_name)) AS identifier_display_name_fi,
  CAST(REPEAT(' ', LENGTH(ATTR_MAP.identifier_display_name) - LENGTH(TRIM(ATTR_MAP.identifier_display_name))) AS STRING)
  || COALESCE(TRANSL.transl_fr, TRIM(ATTR_MAP.identifier_display_name)) AS identifier_display_name_fr,
  CAST(REPEAT(' ', LENGTH(ATTR_MAP.identifier_display_name) - LENGTH(TRIM(ATTR_MAP.identifier_display_name))) AS STRING)
  || COALESCE(TRANSL.transl_gb, TRIM(ATTR_MAP.identifier_display_name)) AS identifier_display_name_gb,
  CAST(REPEAT(' ', LENGTH(ATTR_MAP.identifier_display_name) - LENGTH(TRIM(ATTR_MAP.identifier_display_name))) AS STRING)
  || COALESCE(TRANSL.transl_gr, TRIM(ATTR_MAP.identifier_display_name)) AS identifier_display_name_gr,
  CAST(REPEAT(' ', LENGTH(ATTR_MAP.identifier_display_name) - LENGTH(TRIM(ATTR_MAP.identifier_display_name))) AS STRING)
  || COALESCE(TRANSL.transl_hr, TRIM(ATTR_MAP.identifier_display_name)) AS identifier_display_name_hr,
  CAST(REPEAT(' ', LENGTH(ATTR_MAP.identifier_display_name) - LENGTH(TRIM(ATTR_MAP.identifier_display_name))) AS STRING)
  || COALESCE(TRANSL.transl_hu, TRIM(ATTR_MAP.identifier_display_name)) AS identifier_display_name_hu,
  CAST(REPEAT(' ', LENGTH(ATTR_MAP.identifier_display_name) - LENGTH(TRIM(ATTR_MAP.identifier_display_name))) AS STRING)
  || COALESCE(TRANSL.transl_ie, TRIM(ATTR_MAP.identifier_display_name)) AS identifier_display_name_ie,
  CAST(REPEAT(' ', LENGTH(ATTR_MAP.identifier_display_name) - LENGTH(TRIM(ATTR_MAP.identifier_display_name))) AS STRING)
  || COALESCE(TRANSL.transl_it, TRIM(ATTR_MAP.identifier_display_name)) AS identifier_display_name_it,
  CAST(REPEAT(' ', LENGTH(ATTR_MAP.identifier_display_name) - LENGTH(TRIM(ATTR_MAP.identifier_display_name))) AS STRING)
  || COALESCE(TRANSL.transl_lt, TRIM(ATTR_MAP.identifier_display_name)) AS identifier_display_name_lt,
  CAST(REPEAT(' ', LENGTH(ATTR_MAP.identifier_display_name) - LENGTH(TRIM(ATTR_MAP.identifier_display_name))) AS STRING)
  || COALESCE(TRANSL.transl_lv, TRIM(ATTR_MAP.identifier_display_name)) AS identifier_display_name_lv,
  CAST(REPEAT(' ', LENGTH(ATTR_MAP.identifier_display_name) - LENGTH(TRIM(ATTR_MAP.identifier_display_name))) AS STRING)
  || COALESCE(TRANSL.transl_mt, TRIM(ATTR_MAP.identifier_display_name)) AS identifier_display_name_mt,
  CAST(REPEAT(' ', LENGTH(ATTR_MAP.identifier_display_name) - LENGTH(TRIM(ATTR_MAP.identifier_display_name))) AS STRING)
  || COALESCE(TRANSL.transl_ni, TRIM(ATTR_MAP.identifier_display_name)) AS identifier_display_name_ni,
  CAST(REPEAT(' ', LENGTH(ATTR_MAP.identifier_display_name) - LENGTH(TRIM(ATTR_MAP.identifier_display_name))) AS STRING)
  || COALESCE(TRANSL.transl_nl, TRIM(ATTR_MAP.identifier_display_name)) AS identifier_display_name_nl,
  CAST(REPEAT(' ', LENGTH(ATTR_MAP.identifier_display_name) - LENGTH(TRIM(ATTR_MAP.identifier_display_name))) AS STRING)
  || COALESCE(TRANSL.transl_pl, TRIM(ATTR_MAP.identifier_display_name)) AS identifier_display_name_pl,
  CAST(REPEAT(' ', LENGTH(ATTR_MAP.identifier_display_name) - LENGTH(TRIM(ATTR_MAP.identifier_display_name))) AS STRING)
  || COALESCE(TRANSL.transl_pt, TRIM(ATTR_MAP.identifier_display_name)) AS identifier_display_name_pt,
  CAST(REPEAT(' ', LENGTH(ATTR_MAP.identifier_display_name) - LENGTH(TRIM(ATTR_MAP.identifier_display_name))) AS STRING)
  || COALESCE(TRANSL.transl_ro, TRIM(ATTR_MAP.identifier_display_name)) AS identifier_display_name_ro,
  CAST(REPEAT(' ', LENGTH(ATTR_MAP.identifier_display_name) - LENGTH(TRIM(ATTR_MAP.identifier_display_name))) AS STRING)
  || COALESCE(TRANSL.transl_rs, TRIM(ATTR_MAP.identifier_display_name)) AS identifier_display_name_rs,
  CAST(REPEAT(' ', LENGTH(ATTR_MAP.identifier_display_name) - LENGTH(TRIM(ATTR_MAP.identifier_display_name))) AS STRING)
  || COALESCE(TRANSL.transl_se, TRIM(ATTR_MAP.identifier_display_name)) AS identifier_display_name_se,
  CAST(REPEAT(' ', LENGTH(ATTR_MAP.identifier_display_name) - LENGTH(TRIM(ATTR_MAP.identifier_display_name))) AS STRING)
  || COALESCE(TRANSL.transl_si, TRIM(ATTR_MAP.identifier_display_name)) AS identifier_display_name_si,
  CAST(REPEAT(' ', LENGTH(ATTR_MAP.identifier_display_name) - LENGTH(TRIM(ATTR_MAP.identifier_display_name))) AS STRING)
  || COALESCE(TRANSL.transl_sk, TRIM(ATTR_MAP.identifier_display_name)) AS identifier_display_name_sk,
  CAST(REPEAT(' ', LENGTH(ATTR_MAP.identifier_display_name) - LENGTH(TRIM(ATTR_MAP.identifier_display_name))) AS STRING)
  || COALESCE(TRANSL.transl_us, TRIM(ATTR_MAP.identifier_display_name)) AS identifier_display_name_us
FROM ldl_p_lew_mart_lead.t_cockpit_attr_id_map AS ATTR_MAP
 LEFT JOIN ldl_p_lew_mart_lead.t_ref_transl_cockpit_2_0 AS TRANSL ON TRANSL.transl = TRIM(ATTR_MAP.identifier_display_name
   );