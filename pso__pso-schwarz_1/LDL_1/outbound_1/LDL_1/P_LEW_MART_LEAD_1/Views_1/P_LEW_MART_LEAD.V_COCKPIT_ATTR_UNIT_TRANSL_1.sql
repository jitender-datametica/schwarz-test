/*
#----------------------------------------------------------------------------
# © LIDL Stiftung & Co. KG - DWH / MIS LEAD
#----------------------------------------------------------------------------
# Interface : DDL for view P_LEW_MART_LEAD.v_cockpit_attr_unit_transl_1
#----------------------------------------------------------------------------
# History:
#  1.0    2024-01-15         Marcin Malec              Initial version.
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_lead.v_cockpit_attr_unit_transl_1 (identifier_id, identifier_flag, identifier_unit,
identifier_unit_at, identifier_unit_be, identifier_unit_be_fr, identifier_unit_bg, identifier_unit_ch,
identifier_unit_cs, identifier_unit_cy, identifier_unit_cz, identifier_unit_dk, identifier_unit_ee, identifier_unit_es,
identifier_unit_fi, identifier_unit_fr, identifier_unit_gb, identifier_unit_gr, identifier_unit_hr, identifier_unit_hu,
identifier_unit_ie, identifier_unit_it, identifier_unit_lt, identifier_unit_lv, identifier_unit_mt, identifier_unit_ni,
identifier_unit_nl, identifier_unit_pl, identifier_unit_pt, identifier_unit_ro, identifier_unit_rs, identifier_unit_se,
identifier_unit_si, identifier_unit_sk, identifier_unit_us) AS SELECT ATTR_MAP.identifier_id,
 ATTR_MAP.identifier_flag,
 ATTR_MAP.identifier_unit,
 COALESCE(TRANSL.transl_at, ATTR_MAP.identifier_unit) AS identifier_unit_at,
 COALESCE(TRANSL.transl_be, ATTR_MAP.identifier_unit) AS identifier_unit_be,
 COALESCE(TRANSL.transl_be_fr, ATTR_MAP.identifier_unit) AS identifier_unit_be_fr,
 COALESCE(TRANSL.transl_bg, ATTR_MAP.identifier_unit) AS identifier_unit_bg,
 COALESCE(TRANSL.transl_ch, ATTR_MAP.identifier_unit) AS identifier_unit_ch,
 COALESCE(TRANSL.transl_cs, ATTR_MAP.identifier_unit) AS identifier_unit_cs,
 COALESCE(TRANSL.transl_cy, ATTR_MAP.identifier_unit) AS identifier_unit_cy,
 COALESCE(TRANSL.transl_cz, ATTR_MAP.identifier_unit) AS identifier_unit_cz,
 COALESCE(TRANSL.transl_dk, ATTR_MAP.identifier_unit) AS identifier_unit_dk,
 COALESCE(TRANSL.transl_ee, ATTR_MAP.identifier_unit) AS identifier_unit_ee,
 COALESCE(TRANSL.transl_es, ATTR_MAP.identifier_unit) AS identifier_unit_es,
 COALESCE(TRANSL.transl_fi, ATTR_MAP.identifier_unit) AS identifier_unit_fi,
 COALESCE(TRANSL.transl_fr, ATTR_MAP.identifier_unit) AS identifier_unit_fr,
 COALESCE(TRANSL.transl_gb, ATTR_MAP.identifier_unit) AS identifier_unit_gb,
 COALESCE(TRANSL.transl_gr, ATTR_MAP.identifier_unit) AS identifier_unit_gr,
 COALESCE(TRANSL.transl_hr, ATTR_MAP.identifier_unit) AS identifier_unit_hr,
 COALESCE(TRANSL.transl_hu, ATTR_MAP.identifier_unit) AS identifier_unit_hu,
 COALESCE(TRANSL.transl_ie, ATTR_MAP.identifier_unit) AS identifier_unit_ie,
 COALESCE(TRANSL.transl_it, ATTR_MAP.identifier_unit) AS identifier_unit_it,
 COALESCE(TRANSL.transl_lt, ATTR_MAP.identifier_unit) AS identifier_unit_lt,
 COALESCE(TRANSL.transl_lv, ATTR_MAP.identifier_unit) AS identifier_unit_lv,
 COALESCE(TRANSL.transl_mt, ATTR_MAP.identifier_unit) AS identifier_unit_mt,
 COALESCE(TRANSL.transl_ni, ATTR_MAP.identifier_unit) AS identifier_unit_ni,
 COALESCE(TRANSL.transl_nl, ATTR_MAP.identifier_unit) AS identifier_unit_nl,
 COALESCE(TRANSL.transl_pl, ATTR_MAP.identifier_unit) AS identifier_unit_pl,
 COALESCE(TRANSL.transl_pt, ATTR_MAP.identifier_unit) AS identifier_unit_pt,
 COALESCE(TRANSL.transl_ro, ATTR_MAP.identifier_unit) AS identifier_unit_ro,
 COALESCE(TRANSL.transl_rs, ATTR_MAP.identifier_unit) AS identifier_unit_rs,
 COALESCE(TRANSL.transl_se, ATTR_MAP.identifier_unit) AS identifier_unit_se,
 COALESCE(TRANSL.transl_si, ATTR_MAP.identifier_unit) AS identifier_unit_si,
 COALESCE(TRANSL.transl_sk, ATTR_MAP.identifier_unit) AS identifier_unit_sk,
 COALESCE(TRANSL.transl_us, ATTR_MAP.identifier_unit) AS identifier_unit_us
FROM ldl_p_lew_mart_lead.t_cockpit_attr_id_map_1 AS ATTR_MAP
 LEFT JOIN ldl_p_lew_mart_lead.t_ref_transl_cockpit_2_0_1 AS TRANSL ON TRANSL.transl = TRIM(ATTR_MAP.identifier_unit);