/*
#----------------------------------------------------------------------------
# Description:
# This view provides the lookup for internal organisation.
#
#-----------------------------------------------------------------------------
# History:
#  1.0     30.01.2023      Patrick Mueller          Initial Version
#  2.0     10.10.2024      Simeon Nikolaev          Adding Translation Columns
#
#-----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_fe_mstr_toolbox_spiegel.v_internal_organisation_2 (int_org_sid, int_org_type_cd, int_org_nr,
int_org_name, int_org_descr, int_org_name_at, int_org_name_be, int_org_name_be_fr, int_org_name_bg, int_org_name_ch,
int_org_name_cy, int_org_name_cz, int_org_name_dk, int_org_name_ee, int_org_name_es, int_org_name_fi, int_org_name_fr,
int_org_name_gb, int_org_name_gr, int_org_name_hr, int_org_name_hu, int_org_name_ie, int_org_name_it, int_org_name_lt,
int_org_name_lv, int_org_name_ni, int_org_name_nl, int_org_name_de, int_org_name_pl, int_org_name_pt, int_org_name_ro,
int_org_name_se, int_org_name_si, int_org_name_sk, int_org_name_cs, int_org_name_mt, int_org_name_us, int_org_name_rs)
AS SELECT IOI.int_org_sid,
 IOI.int_org_type_cd,
 IOI.int_org_nr,
 IOI.int_org_name,
 IOI.int_org_descr,
 RCL.country_desc_at AS int_org_name_at,
 RCL.country_desc_be AS int_org_name_be,
 RCL.country_desc_be AS int_org_name_be_fr,
 RCL.country_desc_bg AS int_org_name_bg,
 RCL.country_desc_ch AS int_org_name_ch,
 RCL.country_desc_cy AS int_org_name_cy,
 RCL.country_desc_cz AS int_org_name_cz,
 RCL.country_desc_dk AS int_org_name_dk,
 RCL.country_desc_ee AS int_org_name_ee,
 RCL.country_desc_es AS int_org_name_es,
 RCL.country_desc_fi AS int_org_name_fi,
 RCL.country_desc_fr AS int_org_name_fr,
 RCL.country_desc_gb AS int_org_name_gb,
 RCL.country_desc_gr AS int_org_name_gr,
 RCL.country_desc_hr AS int_org_name_hr,
 RCL.country_desc_hu AS int_org_name_hu,
 RCL.country_desc_ie AS int_org_name_ie,
 RCL.country_desc_it AS int_org_name_it,
 RCL.country_desc_lt AS int_org_name_lt,
 RCL.country_desc_lv AS int_org_name_lv,
 RCL.country_desc_ni AS int_org_name_ni,
 RCL.country_desc_nl AS int_org_name_nl,
 RCL.country_desc_de AS int_org_name_de,
 RCL.country_desc_pl AS int_org_name_pl,
 RCL.country_desc_pt AS int_org_name_pt,
 RCL.country_desc_ro AS int_org_name_ro,
 RCL.country_desc_se AS int_org_name_se,
 RCL.country_desc_si AS int_org_name_si,
 RCL.country_desc_sk AS int_org_name_sk,
 RCL.country_desc_cs AS int_org_name_cs,
 RCL.country_desc_mt AS int_org_name_mt,
 RCL.country_desc_us AS int_org_name_us,
 RCL.country_desc_rs AS int_org_name_rs
FROM ldl_p_lew_core.t_internal_organisation_2 AS IOI
 INNER JOIN ldl_p_lew_mart_lead.v_ref_client_lead_2 AS RCL ON IOI.int_org_nr = RCL.country_iso_cd
WHERE IOI.int_org_type_cd = 'SPACEMAN';