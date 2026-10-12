/*
#----------------------------------------------------------------------------
# © LIDL Stiftung & Co. KG - DWH / MIS LEAD
#----------------------------------------------------------------------------
# Interface : DDL for view P_LEW_MART_LEAD_AC.v_cockpit_attr_name_det_rep_transl
#----------------------------------------------------------------------------
# History:
#  1.0    2024-01-15         Marcin Malec              Initial version.
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_lead_ac.v_cockpit_attr_name_det_rep_transl (id, name, name_at, name_be, name_be_fr
, name_bg, name_ch, name_cs, name_cy, name_cz, name_dk, name_ee, name_es, name_fi, name_fr, name_gb, name_gr, name_hr,
name_hu, name_ie, name_it, name_lt, name_lv, name_mt, name_ni, name_nl, name_pl, name_pt, name_ro, name_rs, name_se,
name_si, name_sk, name_us) AS SELECT *
FROM ldl_p_lew_mart_lead.v_cockpit_attr_name_det_rep_transl;