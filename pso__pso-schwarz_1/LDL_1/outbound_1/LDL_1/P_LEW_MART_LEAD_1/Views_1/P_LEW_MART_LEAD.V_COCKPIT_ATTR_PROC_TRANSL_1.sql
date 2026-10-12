/*
#----------------------------------------------------------------------------
# © LIDL Stiftung & Co. KG - DWH / MIS LEAD
#----------------------------------------------------------------------------
# Interface : DDL for view P_LEW_MART_LEAD.v_cockpit_attr_proc_transl_1
#----------------------------------------------------------------------------
# History:
#  1.0    2024-01-15         Marcin Malec              Initial version.
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_lead.v_cockpit_attr_proc_transl_1 (identifier_id, identifier_flag, process_sorting,
process_name, process_name_at, process_name_be, process_name_be_fr, process_name_bg, process_name_ch, process_name_cs,
process_name_cy, process_name_cz, process_name_dk, process_name_ee, process_name_es, process_name_fi, process_name_fr,
process_name_gb, process_name_gr, process_name_hr, process_name_hu, process_name_ie, process_name_it, process_name_lt,
process_name_lv, process_name_mt, process_name_ni, process_name_nl, process_name_pl, process_name_pt, process_name_ro,
process_name_rs, process_name_se, process_name_si, process_name_sk, process_name_us) AS SELECT ATTR_MAP.identifier_id,
 ATTR_MAP.identifier_flag,
 ATTR_MAP.process_sorting,
 ATTR_MAP.process_name,
 COALESCE(TRANSL.transl_at, ATTR_MAP.process_name) AS process_name_at,
 COALESCE(TRANSL.transl_be, ATTR_MAP.process_name) AS process_name_be,
 COALESCE(TRANSL.transl_be_fr, ATTR_MAP.process_name) AS process_name_be_fr,
 COALESCE(TRANSL.transl_bg, ATTR_MAP.process_name) AS process_name_bg,
 COALESCE(TRANSL.transl_ch, ATTR_MAP.process_name) AS process_name_ch,
 COALESCE(TRANSL.transl_cs, ATTR_MAP.process_name) AS process_name_cs,
 COALESCE(TRANSL.transl_cy, ATTR_MAP.process_name) AS process_name_cy,
 COALESCE(TRANSL.transl_cz, ATTR_MAP.process_name) AS process_name_cz,
 COALESCE(TRANSL.transl_dk, ATTR_MAP.process_name) AS process_name_dk,
 COALESCE(TRANSL.transl_ee, ATTR_MAP.process_name) AS process_name_ee,
 COALESCE(TRANSL.transl_es, ATTR_MAP.process_name) AS process_name_es,
 COALESCE(TRANSL.transl_fi, ATTR_MAP.process_name) AS process_name_fi,
 COALESCE(TRANSL.transl_fr, ATTR_MAP.process_name) AS process_name_fr,
 COALESCE(TRANSL.transl_gb, ATTR_MAP.process_name) AS process_name_gb,
 COALESCE(TRANSL.transl_gr, ATTR_MAP.process_name) AS process_name_gr,
 COALESCE(TRANSL.transl_hr, ATTR_MAP.process_name) AS process_name_hr,
 COALESCE(TRANSL.transl_hu, ATTR_MAP.process_name) AS process_name_hu,
 COALESCE(TRANSL.transl_ie, ATTR_MAP.process_name) AS process_name_ie,
 COALESCE(TRANSL.transl_it, ATTR_MAP.process_name) AS process_name_it,
 COALESCE(TRANSL.transl_lt, ATTR_MAP.process_name) AS process_name_lt,
 COALESCE(TRANSL.transl_lv, ATTR_MAP.process_name) AS process_name_lv,
 COALESCE(TRANSL.transl_mt, ATTR_MAP.process_name) AS process_name_mt,
 COALESCE(TRANSL.transl_ni, ATTR_MAP.process_name) AS process_name_ni,
 COALESCE(TRANSL.transl_nl, ATTR_MAP.process_name) AS process_name_nl,
 COALESCE(TRANSL.transl_pl, ATTR_MAP.process_name) AS process_name_pl,
 COALESCE(TRANSL.transl_pt, ATTR_MAP.process_name) AS process_name_pt,
 COALESCE(TRANSL.transl_ro, ATTR_MAP.process_name) AS process_name_ro,
 COALESCE(TRANSL.transl_rs, ATTR_MAP.process_name) AS process_name_rs,
 COALESCE(TRANSL.transl_se, ATTR_MAP.process_name) AS process_name_se,
 COALESCE(TRANSL.transl_si, ATTR_MAP.process_name) AS process_name_si,
 COALESCE(TRANSL.transl_sk, ATTR_MAP.process_name) AS process_name_sk,
 COALESCE(TRANSL.transl_us, ATTR_MAP.process_name) AS process_name_us
FROM ldl_p_lew_mart_lead.t_cockpit_attr_id_map_1 AS ATTR_MAP
 LEFT JOIN ldl_p_lew_mart_lead.t_ref_transl_cockpit_2_0_1 AS TRANSL ON TRANSL.transl = TRIM(ATTR_MAP.process_name);