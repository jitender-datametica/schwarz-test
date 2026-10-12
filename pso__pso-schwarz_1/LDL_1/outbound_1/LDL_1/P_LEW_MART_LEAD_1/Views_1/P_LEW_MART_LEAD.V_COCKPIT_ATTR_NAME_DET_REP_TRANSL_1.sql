/*
#----------------------------------------------------------------------------
# © LIDL Stiftung & Co. KG - DWH / MIS LEAD
#----------------------------------------------------------------------------
# Interface : DDL for view P_LEW_MART_LEAD.v_cockpit_attr_name_det_rep_transl_1
#----------------------------------------------------------------------------
# History:
#  1.0    2024-01-15         Marcin Malec              Initial version.
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_lead.v_cockpit_attr_name_det_rep_transl_1 (id, name, name_at, name_be, name_be_fr,
name_bg, name_ch, name_cs, name_cy, name_cz, name_dk, name_ee, name_es, name_fi, name_fr, name_gb, name_gr, name_hr,
name_hu, name_ie, name_it, name_lt, name_lv, name_mt, name_ni, name_nl, name_pl, name_pt, name_ro, name_rs, name_se,
name_si, name_sk, name_us) AS SELECT DETREP.id,
 DETREP.name,
 COALESCE(TRANSL.transl_at, DETREP.name) AS name_at,
 COALESCE(TRANSL.transl_be, DETREP.name) AS name_be,
 COALESCE(TRANSL.transl_be_fr, DETREP.name) AS name_be_fr,
 COALESCE(TRANSL.transl_bg, DETREP.name) AS name_bg,
 COALESCE(TRANSL.transl_ch, DETREP.name) AS name_ch,
 COALESCE(TRANSL.transl_cs, DETREP.name) AS name_cs,
 COALESCE(TRANSL.transl_cy, DETREP.name) AS name_cy,
 COALESCE(TRANSL.transl_cz, DETREP.name) AS name_cz,
 COALESCE(TRANSL.transl_dk, DETREP.name) AS name_dk,
 COALESCE(TRANSL.transl_ee, DETREP.name) AS name_ee,
 COALESCE(TRANSL.transl_es, DETREP.name) AS name_es,
 COALESCE(TRANSL.transl_fi, DETREP.name) AS name_fi,
 COALESCE(TRANSL.transl_fr, DETREP.name) AS name_fr,
 COALESCE(TRANSL.transl_gb, DETREP.name) AS name_gb,
 COALESCE(TRANSL.transl_gr, DETREP.name) AS name_gr,
 COALESCE(TRANSL.transl_hr, DETREP.name) AS name_hr,
 COALESCE(TRANSL.transl_hu, DETREP.name) AS name_hu,
 COALESCE(TRANSL.transl_ie, DETREP.name) AS name_ie,
 COALESCE(TRANSL.transl_it, DETREP.name) AS name_it,
 COALESCE(TRANSL.transl_lt, DETREP.name) AS name_lt,
 COALESCE(TRANSL.transl_lv, DETREP.name) AS name_lv,
 COALESCE(TRANSL.transl_mt, DETREP.name) AS name_mt,
 COALESCE(TRANSL.transl_ni, DETREP.name) AS name_ni,
 COALESCE(TRANSL.transl_nl, DETREP.name) AS name_nl,
 COALESCE(TRANSL.transl_pl, DETREP.name) AS name_pl,
 COALESCE(TRANSL.transl_pt, DETREP.name) AS name_pt,
 COALESCE(TRANSL.transl_ro, DETREP.name) AS name_ro,
 COALESCE(TRANSL.transl_rs, DETREP.name) AS name_rs,
 COALESCE(TRANSL.transl_se, DETREP.name) AS name_se,
 COALESCE(TRANSL.transl_si, DETREP.name) AS name_si,
 COALESCE(TRANSL.transl_sk, DETREP.name) AS name_sk,
 COALESCE(TRANSL.transl_us, DETREP.name) AS name_us
FROM ldl_p_lew_mart_lead.t_cockpit_attr_id_map_detail_reports_1 AS DETREP
 LEFT JOIN ldl_p_lew_mart_lead.t_ref_transl_cockpit_2_0_1 AS TRANSL ON TRANSL.transl = TRIM(DETREP.name);