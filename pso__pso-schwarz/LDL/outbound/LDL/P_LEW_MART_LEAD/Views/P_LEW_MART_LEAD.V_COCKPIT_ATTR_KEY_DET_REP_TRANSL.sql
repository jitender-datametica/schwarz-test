/*
#----------------------------------------------------------------------------
# © LIDL Stiftung & Co. KG - DWH / MIS LEAD
#----------------------------------------------------------------------------
# Interface : DDL for view P_LEW_MART_LEAD.v_cockpit_attr_key_det_rep_transl
#----------------------------------------------------------------------------
# History:
#  1.0    2024-01-15         Marcin Malec              Initial version.
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_lead.v_cockpit_attr_key_det_rep_transl (id, key_id, key_desc, key_desc_at,
key_desc_be, key_desc_be_fr, key_desc_bg, key_desc_ch, key_desc_cs, key_desc_cy, key_desc_cz, key_desc_dk, key_desc_ee,
key_desc_es, key_desc_fi, key_desc_fr, key_desc_gb, key_desc_gr, key_desc_hr, key_desc_hu, key_desc_ie, key_desc_it,
key_desc_lt, key_desc_lv, key_desc_mt, key_desc_ni, key_desc_nl, key_desc_pl, key_desc_pt, key_desc_ro, key_desc_rs,
key_desc_se, key_desc_si, key_desc_sk, key_desc_us) AS SELECT DETREP.id,
 DETREP.key_id,
 DETREP.key_desc,
 COALESCE(TRANSL.transl_at, DETREP.key_desc) AS key_desc_at,
 COALESCE(TRANSL.transl_be, DETREP.key_desc) AS key_desc_be,
 COALESCE(TRANSL.transl_be_fr, DETREP.key_desc) AS key_desc_be_fr,
 COALESCE(TRANSL.transl_bg, DETREP.key_desc) AS key_desc_bg,
 COALESCE(TRANSL.transl_ch, DETREP.key_desc) AS key_desc_ch,
 COALESCE(TRANSL.transl_cs, DETREP.key_desc) AS key_desc_cs,
 COALESCE(TRANSL.transl_cy, DETREP.key_desc) AS key_desc_cy,
 COALESCE(TRANSL.transl_cz, DETREP.key_desc) AS key_desc_cz,
 COALESCE(TRANSL.transl_dk, DETREP.key_desc) AS key_desc_dk,
 COALESCE(TRANSL.transl_ee, DETREP.key_desc) AS key_desc_ee,
 COALESCE(TRANSL.transl_es, DETREP.key_desc) AS key_desc_es,
 COALESCE(TRANSL.transl_fi, DETREP.key_desc) AS key_desc_fi,
 COALESCE(TRANSL.transl_fr, DETREP.key_desc) AS key_desc_fr,
 COALESCE(TRANSL.transl_gb, DETREP.key_desc) AS key_desc_gb,
 COALESCE(TRANSL.transl_gr, DETREP.key_desc) AS key_desc_gr,
 COALESCE(TRANSL.transl_hr, DETREP.key_desc) AS key_desc_hr,
 COALESCE(TRANSL.transl_hu, DETREP.key_desc) AS key_desc_hu,
 COALESCE(TRANSL.transl_ie, DETREP.key_desc) AS key_desc_ie,
 COALESCE(TRANSL.transl_it, DETREP.key_desc) AS key_desc_it,
 COALESCE(TRANSL.transl_lt, DETREP.key_desc) AS key_desc_lt,
 COALESCE(TRANSL.transl_lv, DETREP.key_desc) AS key_desc_lv,
 COALESCE(TRANSL.transl_mt, DETREP.key_desc) AS key_desc_mt,
 COALESCE(TRANSL.transl_ni, DETREP.key_desc) AS key_desc_ni,
 COALESCE(TRANSL.transl_nl, DETREP.key_desc) AS key_desc_nl,
 COALESCE(TRANSL.transl_pl, DETREP.key_desc) AS key_desc_pl,
 COALESCE(TRANSL.transl_pt, DETREP.key_desc) AS key_desc_pt,
 COALESCE(TRANSL.transl_ro, DETREP.key_desc) AS key_desc_ro,
 COALESCE(TRANSL.transl_rs, DETREP.key_desc) AS key_desc_rs,
 COALESCE(TRANSL.transl_se, DETREP.key_desc) AS key_desc_se,
 COALESCE(TRANSL.transl_si, DETREP.key_desc) AS key_desc_si,
 COALESCE(TRANSL.transl_sk, DETREP.key_desc) AS key_desc_sk,
 COALESCE(TRANSL.transl_us, DETREP.key_desc) AS key_desc_us
FROM ldl_p_lew_mart_lead.t_cockpit_attr_id_map_detail_reports AS DETREP
 LEFT JOIN ldl_p_lew_mart_lead.t_ref_transl_cockpit_2_0 AS TRANSL ON TRANSL.transl = TRIM(DETREP.key_desc);