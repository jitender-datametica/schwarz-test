/*
#----------------------------------------------------------------------------
# © LIDL Stiftung & Co. KG - DWH / MIS LEAD
#----------------------------------------------------------------------------
# Interface : DDL for view P_LEW_MART_LEAD_AC.v_cockpit_attr_unit_transl_1
#----------------------------------------------------------------------------
# History:
#  1.0    2024-01-15         Marcin Malec              Initial version.
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_lead_ac.v_cockpit_attr_unit_transl_1 (identifier_id, identifier_flag,
identifier_unit, identifier_unit_at, identifier_unit_be, identifier_unit_be_fr, identifier_unit_bg, identifier_unit_ch,
identifier_unit_cs, identifier_unit_cy, identifier_unit_cz, identifier_unit_dk, identifier_unit_ee, identifier_unit_es,
identifier_unit_fi, identifier_unit_fr, identifier_unit_gb, identifier_unit_gr, identifier_unit_hr, identifier_unit_hu,
identifier_unit_ie, identifier_unit_it, identifier_unit_lt, identifier_unit_lv, identifier_unit_mt, identifier_unit_ni,
identifier_unit_nl, identifier_unit_pl, identifier_unit_pt, identifier_unit_ro, identifier_unit_rs, identifier_unit_se,
identifier_unit_si, identifier_unit_sk, identifier_unit_us) AS SELECT *
FROM ldl_p_lew_mart_lead.v_cockpit_attr_unit_transl_1;