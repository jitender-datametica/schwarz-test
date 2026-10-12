/*
#----------------------------------------------------------------------------
# © LIDL Stiftung & Co. KG - DWH / MIS LEAD
#----------------------------------------------------------------------------
# Interface : DDL for view P_LEW_MART_LEAD.v_cockpit_attr_lead_proc_transl_2
#----------------------------------------------------------------------------
# History:
#  1.0    2024-01-15         Marcin Malec              Initial version.
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_lead.v_cockpit_attr_lead_proc_transl_2 (identifier_id, identifier_flag,
leading_process_id, leading_process_name, leading_process_name_at, leading_process_name_be, leading_process_name_be_fr,
leading_process_name_bg, leading_process_name_ch, leading_process_name_cs, leading_process_name_cy,
leading_process_name_cz, leading_process_name_dk, leading_process_name_ee, leading_process_name_es,
leading_process_name_fi, leading_process_name_fr, leading_process_name_gb, leading_process_name_gr,
leading_process_name_hr, leading_process_name_hu, leading_process_name_ie, leading_process_name_it,
leading_process_name_lt, leading_process_name_lv, leading_process_name_mt, leading_process_name_ni,
leading_process_name_nl, leading_process_name_pl, leading_process_name_pt, leading_process_name_ro,
leading_process_name_rs, leading_process_name_se, leading_process_name_si, leading_process_name_sk,
leading_process_name_us) AS SELECT ATTR_MAP.identifier_id,
 ATTR_MAP.identifier_flag,
 ATTR_MAP.leading_process_id,
 ATTR_MAP.leading_process_name,
 COALESCE(TRANSL.transl_at, ATTR_MAP.leading_process_name) AS leading_process_name_at,
 COALESCE(TRANSL.transl_be, ATTR_MAP.leading_process_name) AS leading_process_name_be,
 COALESCE(TRANSL.transl_be_fr, ATTR_MAP.leading_process_name) AS leading_process_name_be_fr,
 COALESCE(TRANSL.transl_bg, ATTR_MAP.leading_process_name) AS leading_process_name_bg,
 COALESCE(TRANSL.transl_ch, ATTR_MAP.leading_process_name) AS leading_process_name_ch,
 COALESCE(TRANSL.transl_cs, ATTR_MAP.leading_process_name) AS leading_process_name_cs,
 COALESCE(TRANSL.transl_cy, ATTR_MAP.leading_process_name) AS leading_process_name_cy,
 COALESCE(TRANSL.transl_cz, ATTR_MAP.leading_process_name) AS leading_process_name_cz,
 COALESCE(TRANSL.transl_dk, ATTR_MAP.leading_process_name) AS leading_process_name_dk,
 COALESCE(TRANSL.transl_ee, ATTR_MAP.leading_process_name) AS leading_process_name_ee,
 COALESCE(TRANSL.transl_es, ATTR_MAP.leading_process_name) AS leading_process_name_es,
 COALESCE(TRANSL.transl_fi, ATTR_MAP.leading_process_name) AS leading_process_name_fi,
 COALESCE(TRANSL.transl_fr, ATTR_MAP.leading_process_name) AS leading_process_name_fr,
 COALESCE(TRANSL.transl_gb, ATTR_MAP.leading_process_name) AS leading_process_name_gb,
 COALESCE(TRANSL.transl_gr, ATTR_MAP.leading_process_name) AS leading_process_name_gr,
 COALESCE(TRANSL.transl_hr, ATTR_MAP.leading_process_name) AS leading_process_name_hr,
 COALESCE(TRANSL.transl_hu, ATTR_MAP.leading_process_name) AS leading_process_name_hu,
 COALESCE(TRANSL.transl_ie, ATTR_MAP.leading_process_name) AS leading_process_name_ie,
 COALESCE(TRANSL.transl_it, ATTR_MAP.leading_process_name) AS leading_process_name_it,
 COALESCE(TRANSL.transl_lt, ATTR_MAP.leading_process_name) AS leading_process_name_lt,
 COALESCE(TRANSL.transl_lv, ATTR_MAP.leading_process_name) AS leading_process_name_lv,
 COALESCE(TRANSL.transl_mt, ATTR_MAP.leading_process_name) AS leading_process_name_mt,
 COALESCE(TRANSL.transl_ni, ATTR_MAP.leading_process_name) AS leading_process_name_ni,
 COALESCE(TRANSL.transl_nl, ATTR_MAP.leading_process_name) AS leading_process_name_nl,
 COALESCE(TRANSL.transl_pl, ATTR_MAP.leading_process_name) AS leading_process_name_pl,
 COALESCE(TRANSL.transl_pt, ATTR_MAP.leading_process_name) AS leading_process_name_pt,
 COALESCE(TRANSL.transl_ro, ATTR_MAP.leading_process_name) AS leading_process_name_ro,
 COALESCE(TRANSL.transl_rs, ATTR_MAP.leading_process_name) AS leading_process_name_rs,
 COALESCE(TRANSL.transl_se, ATTR_MAP.leading_process_name) AS leading_process_name_se,
 COALESCE(TRANSL.transl_si, ATTR_MAP.leading_process_name) AS leading_process_name_si,
 COALESCE(TRANSL.transl_sk, ATTR_MAP.leading_process_name) AS leading_process_name_sk,
 COALESCE(TRANSL.transl_us, ATTR_MAP.leading_process_name) AS leading_process_name_us
FROM ldl_p_lew_mart_lead.t_cockpit_attr_id_map_2 AS ATTR_MAP
 LEFT JOIN ldl_p_lew_mart_lead.t_ref_transl_cockpit_2_0_2 AS TRANSL ON TRANSL.transl = TRIM(ATTR_MAP.leading_process_name
   );