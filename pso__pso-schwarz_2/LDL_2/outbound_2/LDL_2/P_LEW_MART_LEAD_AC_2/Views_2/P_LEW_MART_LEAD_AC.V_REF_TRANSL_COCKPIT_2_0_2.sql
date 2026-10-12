/*
#----------------------------------------------------------------------------
# © LIDL Stiftung & Co. KG - DWH / MIS LEAD
#----------------------------------------------------------------------------
# Interface : DDL for view P_LEW_MART_LEAD_AC.v_ref_transl_cockpit_2_0_2
#----------------------------------------------------------------------------
# History:
#  1.0    2023-10-13         Marcin Malec              Initial version.
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_lead_ac.v_ref_transl_cockpit_2_0_2 (transl, transl_at, transl_be, transl_be_fr,
transl_bg, transl_ch, transl_cs, transl_cy, transl_cz, transl_dk, transl_ee, transl_es, transl_fi, transl_fr, transl_gb
, transl_gr, transl_hr, transl_hu, transl_ie, transl_it, transl_lt, transl_lv, transl_mt, transl_ni, transl_nl,
transl_pl, transl_pt, transl_ro, transl_rs, transl_se, transl_si, transl_sk, transl_us) AS SELECT transl,
 transl_at,
 transl_be,
 transl_be_fr,
 transl_bg,
 transl_ch,
 transl_cs,
 transl_cy,
 transl_cz,
 transl_dk,
 transl_ee,
 transl_es,
 transl_fi,
 transl_fr,
 transl_gb,
 transl_gr,
 transl_hr,
 transl_hu,
 transl_ie,
 transl_it,
 transl_lt,
 transl_lv,
 transl_mt,
 transl_ni,
 transl_nl,
 transl_pl,
 transl_pt,
 transl_ro,
 transl_rs,
 transl_se,
 transl_si,
 transl_sk,
 transl_us
FROM ldl_p_lew_mart_lead.t_ref_transl_cockpit_2_0_2;