/*
#----------------------------------------------------------------------------
# © LIDL Stiftung & Co. KG - DWH / MIS LEAD
#----------------------------------------------------------------------------
# Interface : DDL for table P_LEW_MART_LEAD.t_ref_transl_cockpit_2_0_2
#----------------------------------------------------------------------------
# History:
#  1.0    2023-10-13         Marcin Malec              Initial version.
#----------------------------------------------------------------------------
*/


CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_lead.t_ref_transl_cockpit_2_0_2 (
transl STRING(1000) OPTIONS(description='reftranslation'),
transl_at STRING(1000),
transl_be STRING(1000),
transl_be_fr STRING(1000),
transl_bg STRING(1000),
transl_ch STRING(1000),
transl_cs STRING(1000),
transl_cy STRING(1000),
transl_cz STRING(1000),
transl_dk STRING(1000),
transl_ee STRING(1000),
transl_es STRING(1000),
transl_fi STRING(1000),
transl_fr STRING(1000),
transl_gb STRING(1000),
transl_gr STRING(1000),
transl_hr STRING(1000),
transl_hu STRING(1000),
transl_ie STRING(1000),
transl_it STRING(1000),
transl_lt STRING(1000),
transl_lv STRING(1000),
transl_mt STRING(1000),
transl_ni STRING(1000),
transl_nl STRING(1000),
transl_pl STRING(1000),
transl_pt STRING(1000),
transl_ro STRING(1000),
transl_rs STRING(1000),
transl_se STRING(1000),
transl_si STRING(1000),
transl_sk STRING(1000),
transl_us STRING(1000)
) OPTIONS(description='Cockpit 2.0 translations');