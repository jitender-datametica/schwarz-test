/*
#----------------------------------------------------------------------------
# © LIDL Stiftung & Co. KG - DWH / MIS LEAD
#----------------------------------------------------------------------------
# Interface : DDL for view P_LEW_MART_LEAD_AC.v_ref_hier_cockpit_cp_transl_1
#----------------------------------------------------------------------------
# History:
#  1.0    2024-01-15         Marcin Malec              Initial version.
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_lead_ac.v_ref_hier_cockpit_cp_transl_1 (cockpit_id, cockpit_desc, cockpit_desc_at,
cockpit_desc_be, cockpit_desc_be_fr, cockpit_desc_bg, cockpit_desc_ch, cockpit_desc_cs, cockpit_desc_cy, cockpit_desc_cz
, cockpit_desc_dk, cockpit_desc_ee, cockpit_desc_es, cockpit_desc_fi, cockpit_desc_fr, cockpit_desc_gb, cockpit_desc_gr
, cockpit_desc_hr, cockpit_desc_hu, cockpit_desc_ie, cockpit_desc_it, cockpit_desc_lt, cockpit_desc_lv, cockpit_desc_mt
, cockpit_desc_ni, cockpit_desc_nl, cockpit_desc_pl, cockpit_desc_pt, cockpit_desc_ro, cockpit_desc_rs, cockpit_desc_se
, cockpit_desc_si, cockpit_desc_sk, cockpit_desc_us) AS SELECT *
FROM ldl_p_lew_mart_lead.v_ref_hier_cockpit_cp_transl_1;