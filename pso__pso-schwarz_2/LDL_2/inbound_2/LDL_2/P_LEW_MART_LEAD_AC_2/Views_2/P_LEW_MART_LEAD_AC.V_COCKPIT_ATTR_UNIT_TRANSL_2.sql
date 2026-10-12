/*
#----------------------------------------------------------------------------
# © LIDL Stiftung & Co. KG - DWH / MIS LEAD
#----------------------------------------------------------------------------
# Interface : DDL for view P_LEW_MART_LEAD_AC.v_cockpit_attr_unit_transl_2
#----------------------------------------------------------------------------
# History:
#  1.0    2024-01-15         Marcin Malec              Initial version.
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW P_LEW_MART_LEAD_AC.v_cockpit_attr_unit_transl_2
(
  identifier_id
, identifier_flag
, identifier_unit
, identifier_unit_AT   
, identifier_unit_BE   
, identifier_unit_BE_fr
, identifier_unit_BG   
, identifier_unit_CH   
, identifier_unit_CS   
, identifier_unit_CY   
, identifier_unit_CZ   
, identifier_unit_DK   
, identifier_unit_EE   
, identifier_unit_ES   
, identifier_unit_FI   
, identifier_unit_FR   
, identifier_unit_GB   
, identifier_unit_GR   
, identifier_unit_HR   
, identifier_unit_HU   
, identifier_unit_IE   
, identifier_unit_IT   
, identifier_unit_LT   
, identifier_unit_LV   
, identifier_unit_MT   
, identifier_unit_NI   
, identifier_unit_NL   
, identifier_unit_PL   
, identifier_unit_PT   
, identifier_unit_RO   
, identifier_unit_RS   
, identifier_unit_SE   
, identifier_unit_SI   
, identifier_unit_SK   
, identifier_unit_US   
)
AS
SELECT
  identifier_id
, identifier_flag
, identifier_unit
, identifier_unit_AT   
, identifier_unit_BE   
, identifier_unit_BE_fr
, identifier_unit_BG   
, identifier_unit_CH   
, identifier_unit_CS   
, identifier_unit_CY   
, identifier_unit_CZ   
, identifier_unit_DK   
, identifier_unit_EE   
, identifier_unit_ES   
, identifier_unit_FI   
, identifier_unit_FR   
, identifier_unit_GB   
, identifier_unit_GR   
, identifier_unit_HR   
, identifier_unit_HU   
, identifier_unit_IE   
, identifier_unit_IT   
, identifier_unit_LT   
, identifier_unit_LV   
, identifier_unit_MT   
, identifier_unit_NI   
, identifier_unit_NL   
, identifier_unit_PL   
, identifier_unit_PT   
, identifier_unit_RO   
, identifier_unit_RS   
, identifier_unit_SE   
, identifier_unit_SI   
, identifier_unit_SK   
, identifier_unit_US  
FROM P_LEW_MART_LEAD.v_cockpit_attr_unit_transl_2
;
