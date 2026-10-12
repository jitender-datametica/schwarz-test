/*
#----------------------------------------------------------------------------
# © LIDL Stiftung & Co. KG - DWH / MIS LEAD
#----------------------------------------------------------------------------
# Interface : DDL for view P_LEW_MART_LEAD.v_ref_hier_cockpit_group_transl_2
#----------------------------------------------------------------------------
# History:
#  1.0    2024-01-15         Marcin Malec              Initial version.
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_lead.v_ref_hier_cockpit_group_transl_2 (group_id, group_desc, group_desc_at,
group_desc_be, group_desc_be_fr, group_desc_bg, group_desc_ch, group_desc_cs, group_desc_cy, group_desc_cz,
group_desc_dk, group_desc_ee, group_desc_es, group_desc_fi, group_desc_fr, group_desc_gb, group_desc_gr, group_desc_hr,
group_desc_hu, group_desc_ie, group_desc_it, group_desc_lt, group_desc_lv, group_desc_mt, group_desc_ni, group_desc_nl,
group_desc_pl, group_desc_pt, group_desc_ro, group_desc_rs, group_desc_se, group_desc_si, group_desc_sk, group_desc_us)
AS SELECT REF_HIER.group_id,
 REF_HIER.group_desc,
 COALESCE(TRANSL.transl_at, REF_HIER.group_desc) AS group_desc_at,
 COALESCE(TRANSL.transl_be, REF_HIER.group_desc) AS group_desc_be,
 COALESCE(TRANSL.transl_be_fr, REF_HIER.group_desc) AS group_desc_be_fr,
 COALESCE(TRANSL.transl_bg, REF_HIER.group_desc) AS group_desc_bg,
 COALESCE(TRANSL.transl_ch, REF_HIER.group_desc) AS group_desc_ch,
 COALESCE(TRANSL.transl_cs, REF_HIER.group_desc) AS group_desc_cs,
 COALESCE(TRANSL.transl_cy, REF_HIER.group_desc) AS group_desc_cy,
 COALESCE(TRANSL.transl_cz, REF_HIER.group_desc) AS group_desc_cz,
 COALESCE(TRANSL.transl_dk, REF_HIER.group_desc) AS group_desc_dk,
 COALESCE(TRANSL.transl_ee, REF_HIER.group_desc) AS group_desc_ee,
 COALESCE(TRANSL.transl_es, REF_HIER.group_desc) AS group_desc_es,
 COALESCE(TRANSL.transl_fi, REF_HIER.group_desc) AS group_desc_fi,
 COALESCE(TRANSL.transl_fr, REF_HIER.group_desc) AS group_desc_fr,
 COALESCE(TRANSL.transl_gb, REF_HIER.group_desc) AS group_desc_gb,
 COALESCE(TRANSL.transl_gr, REF_HIER.group_desc) AS group_desc_gr,
 COALESCE(TRANSL.transl_hr, REF_HIER.group_desc) AS group_desc_hr,
 COALESCE(TRANSL.transl_hu, REF_HIER.group_desc) AS group_desc_hu,
 COALESCE(TRANSL.transl_ie, REF_HIER.group_desc) AS group_desc_ie,
 COALESCE(TRANSL.transl_it, REF_HIER.group_desc) AS group_desc_it,
 COALESCE(TRANSL.transl_lt, REF_HIER.group_desc) AS group_desc_lt,
 COALESCE(TRANSL.transl_lv, REF_HIER.group_desc) AS group_desc_lv,
 COALESCE(TRANSL.transl_mt, REF_HIER.group_desc) AS group_desc_mt,
 COALESCE(TRANSL.transl_ni, REF_HIER.group_desc) AS group_desc_ni,
 COALESCE(TRANSL.transl_nl, REF_HIER.group_desc) AS group_desc_nl,
 COALESCE(TRANSL.transl_pl, REF_HIER.group_desc) AS group_desc_pl,
 COALESCE(TRANSL.transl_pt, REF_HIER.group_desc) AS group_desc_pt,
 COALESCE(TRANSL.transl_ro, REF_HIER.group_desc) AS group_desc_ro,
 COALESCE(TRANSL.transl_rs, REF_HIER.group_desc) AS group_desc_rs,
 COALESCE(TRANSL.transl_se, REF_HIER.group_desc) AS group_desc_se,
 COALESCE(TRANSL.transl_si, REF_HIER.group_desc) AS group_desc_si,
 COALESCE(TRANSL.transl_sk, REF_HIER.group_desc) AS group_desc_sk,
 COALESCE(TRANSL.transl_us, REF_HIER.group_desc) AS group_desc_us
FROM ldl_p_lew_mart_lead.t_ref_hier_cockpit_2_0_2 AS REF_HIER
 LEFT JOIN ldl_p_lew_mart_lead.t_ref_transl_cockpit_2_0_2 AS TRANSL ON TRANSL.transl = TRIM(REF_HIER.group_desc);