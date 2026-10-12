/*
#----------------------------------------------------------------------------
# © LIDL Stiftung & Co. KG - DWH / MIS LEAD
#----------------------------------------------------------------------------
# Interface : DDL for table P_LEW_MART_LEAD.t_ref_transl_cockpit_2_0_mstr_locale_2
#----------------------------------------------------------------------------
# History:
#  1.0    2023-10-13         Marcin Malec              Initial version.
#----------------------------------------------------------------------------
*/


CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_lead.t_ref_transl_cockpit_2_0_mstr_locale_2 (
lang STRING(50) OPTIONS(description='Language'),
country_code_export STRING(5) OPTIONS(description='Country_2 code from Oracle translation DB'),
country_code_mstr STRING(5) OPTIONS(description='Country_2 code as in MSTR application'),
localeid NUMERIC(10) OPTIONS(description='Locale id from Oracle export')
)
OPTIONS(description='Country_2 / language list with locale id from Oracle translations export combined with MSTR country_2 codes');