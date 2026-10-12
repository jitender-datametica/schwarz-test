/*
#----------------------------------------------------------------------------
# © LIDL Stiftung & Co. KG - DWH / MIS LEAD
#----------------------------------------------------------------------------
# Interface : DDL for view P_LEW_MART_LEAD_AC.v_cockpit_attr_lead_proc_transl
#----------------------------------------------------------------------------
# History:
#  1.0    2024-01-15         Marcin Malec              Initial version.
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_lead_ac.v_cockpit_attr_lead_proc_transl (identifier_id, identifier_flag,
leading_process_id, leading_process_name, leading_process_name_at, leading_process_name_be, leading_process_name_be_fr,
leading_process_name_bg, leading_process_name_ch, leading_process_name_cs, leading_process_name_cy,
leading_process_name_cz, leading_process_name_dk, leading_process_name_ee, leading_process_name_es,
leading_process_name_fi, leading_process_name_fr, leading_process_name_gb, leading_process_name_gr,
leading_process_name_hr, leading_process_name_hu, leading_process_name_ie, leading_process_name_it,
leading_process_name_lt, leading_process_name_lv, leading_process_name_mt, leading_process_name_ni,
leading_process_name_nl, leading_process_name_pl, leading_process_name_pt, leading_process_name_ro,
leading_process_name_rs, leading_process_name_se, leading_process_name_si, leading_process_name_sk,
leading_process_name_us) AS SELECT *
FROM ldl_p_lew_mart_lead.v_cockpit_attr_lead_proc_transl;