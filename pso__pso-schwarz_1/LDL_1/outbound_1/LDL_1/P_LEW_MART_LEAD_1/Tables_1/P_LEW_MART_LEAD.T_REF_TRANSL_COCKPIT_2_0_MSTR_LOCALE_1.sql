/*
#----------------------------------------------------------------------------
# © LIDL Stiftung & Co. KG - DWH / MIS LEAD
#----------------------------------------------------------------------------
# Interface : DDL for table P_LEW_MART_LEAD.t_ref_transl_cockpit_2_0_mstr_locale_1
#----------------------------------------------------------------------------
# History:
#  1.0    2023-10-13         Marcin Malec              Initial version.
#----------------------------------------------------------------------------
*/


CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_lead.t_ref_transl_cockpit_2_0_mstr_locale_1 (
lang STRING(50) OPTIONS(description='Language'),
country_code_export STRING(5) OPTIONS(description='Country_1 code from Oracle translation DB'),
country_code_mstr STRING(5) OPTIONS(description='Country_1 code as in MSTR application'),
localeid NUMERIC(10) OPTIONS(description='Locale id from Oracle export')
)
OPTIONS(description='Country_1 / language list with locale id from Oracle translations export combined with MSTR country_1 codes');