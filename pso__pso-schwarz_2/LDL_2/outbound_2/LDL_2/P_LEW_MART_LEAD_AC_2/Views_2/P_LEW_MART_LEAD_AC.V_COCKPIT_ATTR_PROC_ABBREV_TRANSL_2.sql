/*
#----------------------------------------------------------------------------
# © LIDL Stiftung & Co. KG - DWH / MIS LEAD
#----------------------------------------------------------------------------
# Interface : DDL for view P_LEW_MART_LEAD_AC.v_cockpit_attr_proc_abbrev_transl_2
#----------------------------------------------------------------------------
# History:
#  1.0    2024-01-15         Marcin Malec              Initial version.
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_lead_ac.v_cockpit_attr_proc_abbrev_transl_2 (identifier_id, identifier_flag,
process_sorting, process_abbreviation, process_abbreviation_at, process_abbreviation_be, process_abbreviation_be_fr,
process_abbreviation_bg, process_abbreviation_ch, process_abbreviation_cs, process_abbreviation_cy,
process_abbreviation_cz, process_abbreviation_dk, process_abbreviation_ee, process_abbreviation_es,
process_abbreviation_fi, process_abbreviation_fr, process_abbreviation_gb, process_abbreviation_gr,
process_abbreviation_hr, process_abbreviation_hu, process_abbreviation_ie, process_abbreviation_it,
process_abbreviation_lt, process_abbreviation_lv, process_abbreviation_mt, process_abbreviation_ni,
process_abbreviation_nl, process_abbreviation_pl, process_abbreviation_pt, process_abbreviation_ro,
process_abbreviation_rs, process_abbreviation_se, process_abbreviation_si, process_abbreviation_sk,
process_abbreviation_us) AS SELECT *
FROM ldl_p_lew_mart_lead.v_cockpit_attr_proc_abbrev_transl_2;