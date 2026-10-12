/*
#----------------------------------------------------------------------------
# © LIDL Stiftung & Co. KG - DWH / MIS LEAD
#----------------------------------------------------------------------------
# Interface : DDL for view P_LEW_MART_LEAD_AC.v_cockpit_attr_proc_transl
#----------------------------------------------------------------------------
# History:
#  1.0    2024-01-15         Marcin Malec              Initial version.
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_lead_ac.v_cockpit_attr_proc_transl (identifier_id, identifier_flag,
process_sorting, process_name, process_name_at, process_name_be, process_name_be_fr, process_name_bg, process_name_ch,
process_name_cs, process_name_cy, process_name_cz, process_name_dk, process_name_ee, process_name_es, process_name_fi,
process_name_fr, process_name_gb, process_name_gr, process_name_hr, process_name_hu, process_name_ie, process_name_it,
process_name_lt, process_name_lv, process_name_mt, process_name_ni, process_name_nl, process_name_pl, process_name_pt,
process_name_ro, process_name_rs, process_name_se, process_name_si, process_name_sk, process_name_us) AS SELECT *
FROM ldl_p_lew_mart_lead.v_cockpit_attr_proc_transl;