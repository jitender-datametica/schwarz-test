/*
#----------------------------------------------------------------------------
# © LIDL Stiftung & Co. KG - DWH / MIS LEAD
#----------------------------------------------------------------------------
# Interface : DDL for view P_LEW_MART_LEAD_AC.v_cockpit_attr_name_transl_2
#----------------------------------------------------------------------------
# History:
#  1.0    2024-01-15         Marcin Malec              Initial version.
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_lead_ac.v_cockpit_attr_name_transl_2 (identifier_id, identifier_flag,
identifier_display_name, identifier_display_name_at, identifier_display_name_be, identifier_display_name_be_fr,
identifier_display_name_bg, identifier_display_name_ch, identifier_display_name_cs, identifier_display_name_cy,
identifier_display_name_cz, identifier_display_name_dk, identifier_display_name_ee, identifier_display_name_es,
identifier_display_name_fi, identifier_display_name_fr, identifier_display_name_gb, identifier_display_name_gr,
identifier_display_name_hr, identifier_display_name_hu, identifier_display_name_ie, identifier_display_name_it,
identifier_display_name_lt, identifier_display_name_lv, identifier_display_name_mt, identifier_display_name_ni,
identifier_display_name_nl, identifier_display_name_pl, identifier_display_name_pt, identifier_display_name_ro,
identifier_display_name_rs, identifier_display_name_se, identifier_display_name_si, identifier_display_name_sk,
identifier_display_name_us) AS SELECT *
FROM ldl_p_lew_mart_lead.v_cockpit_attr_name_transl_2;