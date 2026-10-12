/*
#----------------------------------------------------------------------------
# © LIDL Stiftung & Co. KG - DWH / MIS LEAD
#----------------------------------------------------------------------------
# Interface : DDL for view P_LEW_MART_LEAD_AC.v_cockpit_attr_proc_det_rep_transl_2
#----------------------------------------------------------------------------
# History:
#  1.0    2024-01-15         Marcin Malec              Initial version.
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_lead_ac.v_cockpit_attr_proc_det_rep_transl_2 (id, process_id, process_desc,
process_desc_at, process_desc_be, process_desc_be_fr, process_desc_bg, process_desc_ch, process_desc_cs, process_desc_cy
, process_desc_cz, process_desc_dk, process_desc_ee, process_desc_es, process_desc_fi, process_desc_fr, process_desc_gb
, process_desc_gr, process_desc_hr, process_desc_hu, process_desc_ie, process_desc_it, process_desc_lt, process_desc_lv
, process_desc_mt, process_desc_ni, process_desc_nl, process_desc_pl, process_desc_pt, process_desc_ro, process_desc_rs
, process_desc_se, process_desc_si, process_desc_sk, process_desc_us) AS SELECT *
FROM ldl_p_lew_mart_lead.v_cockpit_attr_proc_det_rep_transl_2;