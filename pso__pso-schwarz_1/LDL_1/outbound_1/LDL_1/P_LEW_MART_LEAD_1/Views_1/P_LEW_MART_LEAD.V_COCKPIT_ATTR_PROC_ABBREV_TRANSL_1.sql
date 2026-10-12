/*
#----------------------------------------------------------------------------
# © LIDL Stiftung & Co. KG - DWH / MIS LEAD
#----------------------------------------------------------------------------
# Interface : DDL for view P_LEW_MART_LEAD.v_cockpit_attr_proc_abbrev_transl_1
#----------------------------------------------------------------------------
# History:
#  1.0    2024-01-15         Marcin Malec              Initial version.
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_lead.v_cockpit_attr_proc_abbrev_transl_1 (identifier_id, identifier_flag,
process_sorting, process_abbreviation, process_abbreviation_at, process_abbreviation_be, process_abbreviation_be_fr,
process_abbreviation_bg, process_abbreviation_ch, process_abbreviation_cs, process_abbreviation_cy,
process_abbreviation_cz, process_abbreviation_dk, process_abbreviation_ee, process_abbreviation_es,
process_abbreviation_fi, process_abbreviation_fr, process_abbreviation_gb, process_abbreviation_gr,
process_abbreviation_hr, process_abbreviation_hu, process_abbreviation_ie, process_abbreviation_it,
process_abbreviation_lt, process_abbreviation_lv, process_abbreviation_mt, process_abbreviation_ni,
process_abbreviation_nl, process_abbreviation_pl, process_abbreviation_pt, process_abbreviation_ro,
process_abbreviation_rs, process_abbreviation_se, process_abbreviation_si, process_abbreviation_sk,
process_abbreviation_us) AS SELECT ATTR_MAP.identifier_id,
 ATTR_MAP.identifier_flag,
 ATTR_MAP.process_sorting,
 ATTR_MAP.process_abbreviation,
 COALESCE(TRANSL.transl_at, ATTR_MAP.process_abbreviation) AS process_abbreviation_at,
 COALESCE(TRANSL.transl_be, ATTR_MAP.process_abbreviation) AS process_abbreviation_be,
 COALESCE(TRANSL.transl_be_fr, ATTR_MAP.process_abbreviation) AS process_abbreviation_be_fr,
 COALESCE(TRANSL.transl_bg, ATTR_MAP.process_abbreviation) AS process_abbreviation_bg,
 COALESCE(TRANSL.transl_ch, ATTR_MAP.process_abbreviation) AS process_abbreviation_ch,
 COALESCE(TRANSL.transl_cs, ATTR_MAP.process_abbreviation) AS process_abbreviation_cs,
 COALESCE(TRANSL.transl_cy, ATTR_MAP.process_abbreviation) AS process_abbreviation_cy,
 COALESCE(TRANSL.transl_cz, ATTR_MAP.process_abbreviation) AS process_abbreviation_cz,
 COALESCE(TRANSL.transl_dk, ATTR_MAP.process_abbreviation) AS process_abbreviation_dk,
 COALESCE(TRANSL.transl_ee, ATTR_MAP.process_abbreviation) AS process_abbreviation_ee,
 COALESCE(TRANSL.transl_es, ATTR_MAP.process_abbreviation) AS process_abbreviation_es,
 COALESCE(TRANSL.transl_fi, ATTR_MAP.process_abbreviation) AS process_abbreviation_fi,
 COALESCE(TRANSL.transl_fr, ATTR_MAP.process_abbreviation) AS process_abbreviation_fr,
 COALESCE(TRANSL.transl_gb, ATTR_MAP.process_abbreviation) AS process_abbreviation_gb,
 COALESCE(TRANSL.transl_gr, ATTR_MAP.process_abbreviation) AS process_abbreviation_gr,
 COALESCE(TRANSL.transl_hr, ATTR_MAP.process_abbreviation) AS process_abbreviation_hr,
 COALESCE(TRANSL.transl_hu, ATTR_MAP.process_abbreviation) AS process_abbreviation_hu,
 COALESCE(TRANSL.transl_ie, ATTR_MAP.process_abbreviation) AS process_abbreviation_ie,
 COALESCE(TRANSL.transl_it, ATTR_MAP.process_abbreviation) AS process_abbreviation_it,
 COALESCE(TRANSL.transl_lt, ATTR_MAP.process_abbreviation) AS process_abbreviation_lt,
 COALESCE(TRANSL.transl_lv, ATTR_MAP.process_abbreviation) AS process_abbreviation_lv,
 COALESCE(TRANSL.transl_mt, ATTR_MAP.process_abbreviation) AS process_abbreviation_mt,
 COALESCE(TRANSL.transl_ni, ATTR_MAP.process_abbreviation) AS process_abbreviation_ni,
 COALESCE(TRANSL.transl_nl, ATTR_MAP.process_abbreviation) AS process_abbreviation_nl,
 COALESCE(TRANSL.transl_pl, ATTR_MAP.process_abbreviation) AS process_abbreviation_pl,
 COALESCE(TRANSL.transl_pt, ATTR_MAP.process_abbreviation) AS process_abbreviation_pt,
 COALESCE(TRANSL.transl_ro, ATTR_MAP.process_abbreviation) AS process_abbreviation_ro,
 COALESCE(TRANSL.transl_rs, ATTR_MAP.process_abbreviation) AS process_abbreviation_rs,
 COALESCE(TRANSL.transl_se, ATTR_MAP.process_abbreviation) AS process_abbreviation_se,
 COALESCE(TRANSL.transl_si, ATTR_MAP.process_abbreviation) AS process_abbreviation_si,
 COALESCE(TRANSL.transl_sk, ATTR_MAP.process_abbreviation) AS process_abbreviation_sk,
 COALESCE(TRANSL.transl_us, ATTR_MAP.process_abbreviation) AS process_abbreviation_us
FROM ldl_p_lew_mart_lead.t_cockpit_attr_id_map_1 AS ATTR_MAP
 LEFT JOIN ldl_p_lew_mart_lead.t_ref_transl_cockpit_2_0_1 AS TRANSL ON TRANSL.transl = TRIM(ATTR_MAP.process_abbreviation
   );