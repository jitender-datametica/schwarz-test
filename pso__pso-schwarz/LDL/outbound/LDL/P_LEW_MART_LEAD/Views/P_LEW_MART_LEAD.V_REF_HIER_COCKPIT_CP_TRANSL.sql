/*
#----------------------------------------------------------------------------
# © LIDL Stiftung & Co. KG - DWH / MIS LEAD
#----------------------------------------------------------------------------
# Interface : DDL for view P_LEW_MART_LEAD.v_ref_hier_cockpit_cp_transl
#----------------------------------------------------------------------------
# History:
#  1.0    2024-01-15         Marcin Malec              Initial version.
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_lead.v_ref_hier_cockpit_cp_transl (cockpit_id, cockpit_desc, cockpit_desc_at,
cockpit_desc_be, cockpit_desc_be_fr, cockpit_desc_bg, cockpit_desc_ch, cockpit_desc_cs, cockpit_desc_cy, cockpit_desc_cz
, cockpit_desc_dk, cockpit_desc_ee, cockpit_desc_es, cockpit_desc_fi, cockpit_desc_fr, cockpit_desc_gb, cockpit_desc_gr
, cockpit_desc_hr, cockpit_desc_hu, cockpit_desc_ie, cockpit_desc_it, cockpit_desc_lt, cockpit_desc_lv, cockpit_desc_mt
, cockpit_desc_ni, cockpit_desc_nl, cockpit_desc_pl, cockpit_desc_pt, cockpit_desc_ro, cockpit_desc_rs, cockpit_desc_se
, cockpit_desc_si, cockpit_desc_sk, cockpit_desc_us) AS SELECT REF_HIER.cockpit_id,
 REF_HIER.cockpit_desc,
 COALESCE(TRANSL.transl_at, REF_HIER.cockpit_desc) AS cockpit_desc_at,
 COALESCE(TRANSL.transl_be, REF_HIER.cockpit_desc) AS cockpit_desc_be,
 COALESCE(TRANSL.transl_be_fr, REF_HIER.cockpit_desc) AS cockpit_desc_be_fr,
 COALESCE(TRANSL.transl_bg, REF_HIER.cockpit_desc) AS cockpit_desc_bg,
 COALESCE(TRANSL.transl_ch, REF_HIER.cockpit_desc) AS cockpit_desc_ch,
 COALESCE(TRANSL.transl_cs, REF_HIER.cockpit_desc) AS cockpit_desc_cs,
 COALESCE(TRANSL.transl_cy, REF_HIER.cockpit_desc) AS cockpit_desc_cy,
 COALESCE(TRANSL.transl_cz, REF_HIER.cockpit_desc) AS cockpit_desc_cz,
 COALESCE(TRANSL.transl_dk, REF_HIER.cockpit_desc) AS cockpit_desc_dk,
 COALESCE(TRANSL.transl_ee, REF_HIER.cockpit_desc) AS cockpit_desc_ee,
 COALESCE(TRANSL.transl_es, REF_HIER.cockpit_desc) AS cockpit_desc_es,
 COALESCE(TRANSL.transl_fi, REF_HIER.cockpit_desc) AS cockpit_desc_fi,
 COALESCE(TRANSL.transl_fr, REF_HIER.cockpit_desc) AS cockpit_desc_fr,
 COALESCE(TRANSL.transl_gb, REF_HIER.cockpit_desc) AS cockpit_desc_gb,
 COALESCE(TRANSL.transl_gr, REF_HIER.cockpit_desc) AS cockpit_desc_gr,
 COALESCE(TRANSL.transl_hr, REF_HIER.cockpit_desc) AS cockpit_desc_hr,
 COALESCE(TRANSL.transl_hu, REF_HIER.cockpit_desc) AS cockpit_desc_hu,
 COALESCE(TRANSL.transl_ie, REF_HIER.cockpit_desc) AS cockpit_desc_ie,
 COALESCE(TRANSL.transl_it, REF_HIER.cockpit_desc) AS cockpit_desc_it,
 COALESCE(TRANSL.transl_lt, REF_HIER.cockpit_desc) AS cockpit_desc_lt,
 COALESCE(TRANSL.transl_lv, REF_HIER.cockpit_desc) AS cockpit_desc_lv,
 COALESCE(TRANSL.transl_mt, REF_HIER.cockpit_desc) AS cockpit_desc_mt,
 COALESCE(TRANSL.transl_ni, REF_HIER.cockpit_desc) AS cockpit_desc_ni,
 COALESCE(TRANSL.transl_nl, REF_HIER.cockpit_desc) AS cockpit_desc_nl,
 COALESCE(TRANSL.transl_pl, REF_HIER.cockpit_desc) AS cockpit_desc_pl,
 COALESCE(TRANSL.transl_pt, REF_HIER.cockpit_desc) AS cockpit_desc_pt,
 COALESCE(TRANSL.transl_ro, REF_HIER.cockpit_desc) AS cockpit_desc_ro,
 COALESCE(TRANSL.transl_rs, REF_HIER.cockpit_desc) AS cockpit_desc_rs,
 COALESCE(TRANSL.transl_se, REF_HIER.cockpit_desc) AS cockpit_desc_se,
 COALESCE(TRANSL.transl_si, REF_HIER.cockpit_desc) AS cockpit_desc_si,
 COALESCE(TRANSL.transl_sk, REF_HIER.cockpit_desc) AS cockpit_desc_sk,
 COALESCE(TRANSL.transl_us, REF_HIER.cockpit_desc) AS cockpit_desc_us
FROM ldl_p_lew_mart_lead.t_ref_hier_cockpit_2_0 AS REF_HIER
 LEFT JOIN ldl_p_lew_mart_lead.t_ref_transl_cockpit_2_0 AS TRANSL ON TRANSL.transl = TRIM(REF_HIER.cockpit_desc);