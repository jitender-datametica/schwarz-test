/*
#----------------------------------------------------------------------------
# © LIDL Stiftung & Co. KG - DWH / MIS LEAD
#----------------------------------------------------------------------------
# Interface : DDL for view P_LEW_MART_LEAD.v_cockpit_attr_proc_det_rep_transl
#----------------------------------------------------------------------------
# History:
#  1.0    2024-01-15         Marcin Malec              Initial version.
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_lead.v_cockpit_attr_proc_det_rep_transl (id, process_id, process_desc,
process_desc_at, process_desc_be, process_desc_be_fr, process_desc_bg, process_desc_ch, process_desc_cs, process_desc_cy
, process_desc_cz, process_desc_dk, process_desc_ee, process_desc_es, process_desc_fi, process_desc_fr, process_desc_gb
, process_desc_gr, process_desc_hr, process_desc_hu, process_desc_ie, process_desc_it, process_desc_lt, process_desc_lv
, process_desc_mt, process_desc_ni, process_desc_nl, process_desc_pl, process_desc_pt, process_desc_ro, process_desc_rs
, process_desc_se, process_desc_si, process_desc_sk, process_desc_us) AS SELECT DETREP.id,
 DETREP.process_id,
 DETREP.process_desc,
 COALESCE(TRANSL.transl_at, DETREP.process_desc) AS process_desc_at,
 COALESCE(TRANSL.transl_be, DETREP.process_desc) AS process_desc_be,
 COALESCE(TRANSL.transl_be_fr, DETREP.process_desc) AS process_desc_be_fr,
 COALESCE(TRANSL.transl_bg, DETREP.process_desc) AS process_desc_bg,
 COALESCE(TRANSL.transl_ch, DETREP.process_desc) AS process_desc_ch,
 COALESCE(TRANSL.transl_cs, DETREP.process_desc) AS process_desc_cs,
 COALESCE(TRANSL.transl_cy, DETREP.process_desc) AS process_desc_cy,
 COALESCE(TRANSL.transl_cz, DETREP.process_desc) AS process_desc_cz,
 COALESCE(TRANSL.transl_dk, DETREP.process_desc) AS process_desc_dk,
 COALESCE(TRANSL.transl_ee, DETREP.process_desc) AS process_desc_ee,
 COALESCE(TRANSL.transl_es, DETREP.process_desc) AS process_desc_es,
 COALESCE(TRANSL.transl_fi, DETREP.process_desc) AS process_desc_fi,
 COALESCE(TRANSL.transl_fr, DETREP.process_desc) AS process_desc_fr,
 COALESCE(TRANSL.transl_gb, DETREP.process_desc) AS process_desc_gb,
 COALESCE(TRANSL.transl_gr, DETREP.process_desc) AS process_desc_gr,
 COALESCE(TRANSL.transl_hr, DETREP.process_desc) AS process_desc_hr,
 COALESCE(TRANSL.transl_hu, DETREP.process_desc) AS process_desc_hu,
 COALESCE(TRANSL.transl_ie, DETREP.process_desc) AS process_desc_ie,
 COALESCE(TRANSL.transl_it, DETREP.process_desc) AS process_desc_it,
 COALESCE(TRANSL.transl_lt, DETREP.process_desc) AS process_desc_lt,
 COALESCE(TRANSL.transl_lv, DETREP.process_desc) AS process_desc_lv,
 COALESCE(TRANSL.transl_mt, DETREP.process_desc) AS process_desc_mt,
 COALESCE(TRANSL.transl_ni, DETREP.process_desc) AS process_desc_ni,
 COALESCE(TRANSL.transl_nl, DETREP.process_desc) AS process_desc_nl,
 COALESCE(TRANSL.transl_pl, DETREP.process_desc) AS process_desc_pl,
 COALESCE(TRANSL.transl_pt, DETREP.process_desc) AS process_desc_pt,
 COALESCE(TRANSL.transl_ro, DETREP.process_desc) AS process_desc_ro,
 COALESCE(TRANSL.transl_rs, DETREP.process_desc) AS process_desc_rs,
 COALESCE(TRANSL.transl_se, DETREP.process_desc) AS process_desc_se,
 COALESCE(TRANSL.transl_si, DETREP.process_desc) AS process_desc_si,
 COALESCE(TRANSL.transl_sk, DETREP.process_desc) AS process_desc_sk,
 COALESCE(TRANSL.transl_us, DETREP.process_desc) AS process_desc_us
FROM ldl_p_lew_mart_lead.t_cockpit_attr_id_map_detail_reports AS DETREP
 LEFT JOIN ldl_p_lew_mart_lead.t_ref_transl_cockpit_2_0 AS TRANSL ON TRANSL.transl = TRIM(DETREP.process_desc);