/*
#----------------------------------------------------------------------------
# © LIDL Stiftung & Co. KG - DWH / MIS LEAD
#----------------------------------------------------------------------------
# Interface : DDL for view P_LEW_MART_LEAD_AC.v_ref_transl_cockpit_2_0_mstr_locale_2
#----------------------------------------------------------------------------
# History:
#  1.0    2023-10-13         Marcin Malec              Initial version.
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_lead_ac.v_ref_transl_cockpit_2_0_mstr_locale_2 (lang, country_code_export,
country_code_mstr, localeid) AS SELECT lang,
 country_code_export,
 country_code_mstr,
 localeid
FROM ldl_p_lew_mart_lead.t_ref_transl_cockpit_2_0_mstr_locale_2;