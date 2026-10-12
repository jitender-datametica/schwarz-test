/*
#----------------------------------------------------------------------------
# © LIDL Stiftung & Co. KG - DWH / MIS LEAD
#----------------------------------------------------------------------------
# Interface : DDL for view P_LEW_MART_LEAD_AC.v_cockpit_attr_key_det_rep_transl_2
#----------------------------------------------------------------------------
# History:
#  1.0    2024-01-15         Marcin Malec              Initial version.
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_lead_ac.v_cockpit_attr_key_det_rep_transl_2 (id, key_id, key_desc, key_desc_at,
key_desc_be, key_desc_be_fr, key_desc_bg, key_desc_ch, key_desc_cs, key_desc_cy, key_desc_cz, key_desc_dk, key_desc_ee,
key_desc_es, key_desc_fi, key_desc_fr, key_desc_gb, key_desc_gr, key_desc_hr, key_desc_hu, key_desc_ie, key_desc_it,
key_desc_lt, key_desc_lv, key_desc_mt, key_desc_ni, key_desc_nl, key_desc_pl, key_desc_pt, key_desc_ro, key_desc_rs,
key_desc_se, key_desc_si, key_desc_sk, key_desc_us) AS SELECT *
FROM ldl_p_lew_mart_lead.v_cockpit_attr_key_det_rep_transl_2;