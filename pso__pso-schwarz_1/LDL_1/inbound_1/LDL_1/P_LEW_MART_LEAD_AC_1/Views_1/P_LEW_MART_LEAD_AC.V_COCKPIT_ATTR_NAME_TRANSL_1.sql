/*
#----------------------------------------------------------------------------
# © LIDL Stiftung & Co. KG - DWH / MIS LEAD
#----------------------------------------------------------------------------
# Interface : DDL for view P_LEW_MART_LEAD_AC.v_cockpit_attr_name_transl_1
#----------------------------------------------------------------------------
# History:
#  1.0    2024-01-15         Marcin Malec              Initial version.
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW P_LEW_MART_LEAD_AC.v_cockpit_attr_name_transl_1
(
  identifier_id
, identifier_flag
, identifier_display_name
, identifier_display_name_AT   
, identifier_display_name_BE   
, identifier_display_name_BE_fr
, identifier_display_name_BG   
, identifier_display_name_CH   
, identifier_display_name_CS   
, identifier_display_name_CY   
, identifier_display_name_CZ   
, identifier_display_name_DK   
, identifier_display_name_EE   
, identifier_display_name_ES   
, identifier_display_name_FI   
, identifier_display_name_FR   
, identifier_display_name_GB   
, identifier_display_name_GR   
, identifier_display_name_HR   
, identifier_display_name_HU   
, identifier_display_name_IE   
, identifier_display_name_IT   
, identifier_display_name_LT   
, identifier_display_name_LV   
, identifier_display_name_MT   
, identifier_display_name_NI   
, identifier_display_name_NL   
, identifier_display_name_PL   
, identifier_display_name_PT   
, identifier_display_name_RO   
, identifier_display_name_RS   
, identifier_display_name_SE   
, identifier_display_name_SI   
, identifier_display_name_SK   
, identifier_display_name_US   
)
AS
SELECT
  identifier_id
, identifier_flag
, identifier_display_name
, identifier_display_name_AT   
, identifier_display_name_BE   
, identifier_display_name_BE_fr
, identifier_display_name_BG   
, identifier_display_name_CH   
, identifier_display_name_CS   
, identifier_display_name_CY   
, identifier_display_name_CZ   
, identifier_display_name_DK   
, identifier_display_name_EE   
, identifier_display_name_ES   
, identifier_display_name_FI   
, identifier_display_name_FR   
, identifier_display_name_GB   
, identifier_display_name_GR   
, identifier_display_name_HR   
, identifier_display_name_HU   
, identifier_display_name_IE   
, identifier_display_name_IT   
, identifier_display_name_LT   
, identifier_display_name_LV   
, identifier_display_name_MT   
, identifier_display_name_NI   
, identifier_display_name_NL   
, identifier_display_name_PL   
, identifier_display_name_PT   
, identifier_display_name_RO   
, identifier_display_name_RS   
, identifier_display_name_SE   
, identifier_display_name_SI   
, identifier_display_name_SK   
, identifier_display_name_US   
FROM P_LEW_MART_LEAD.v_cockpit_attr_name_transl_1
;

