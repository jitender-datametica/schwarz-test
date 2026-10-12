/*
#----------------------------------------------------------------------------
# © LIDL Stiftung & Co. KG - DWH / MIS LEAD
#----------------------------------------------------------------------------
# Interface : DDL for view P_LEW_MART_LEAD_AC.v_ref_hier_cockpit_group_transl_2
#----------------------------------------------------------------------------
# History:
#  1.0    2024-01-15         Marcin Malec              Initial version.
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_lead_ac.v_ref_hier_cockpit_group_transl_2 (group_id, group_desc, group_desc_at,
group_desc_be, group_desc_be_fr, group_desc_bg, group_desc_ch, group_desc_cs, group_desc_cy, group_desc_cz,
group_desc_dk, group_desc_ee, group_desc_es, group_desc_fi, group_desc_fr, group_desc_gb, group_desc_gr, group_desc_hr,
group_desc_hu, group_desc_ie, group_desc_it, group_desc_lt, group_desc_lv, group_desc_mt, group_desc_ni, group_desc_nl,
group_desc_pl, group_desc_pt, group_desc_ro, group_desc_rs, group_desc_se, group_desc_si, group_desc_sk, group_desc_us)
AS SELECT *
FROM ldl_p_lew_mart_lead.v_ref_hier_cockpit_group_transl_2;