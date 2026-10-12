/*
#----------------------------------------------------------------------------
# © LIDL Stiftung & Co. KG - DWH / MIS LEAD
#----------------------------------------------------------------------------
# Interface : DDL for view P_LEW_MART_LEAD.v_cockpit_attr_name_transl_2
#----------------------------------------------------------------------------
# History:
#  1.0    2024-01-15         Marcin Malec              Initial version.
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW P_LEW_MART_LEAD.v_cockpit_attr_name_transl_2
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
  attr_map.identifier_id
, attr_map.identifier_flag
, attr_map.identifier_display_name
, SPACE(LEN(identifier_display_name) - LEN(TRIM(identifier_display_name))) || COALESCE(transl.transl_AT   , TRIM(attr_map.identifier_display_name)) AS identifier_display_name_AT   
, SPACE(LEN(identifier_display_name) - LEN(TRIM(identifier_display_name))) || COALESCE(transl.transl_BE   , TRIM(attr_map.identifier_display_name)) AS identifier_display_name_BE   
, SPACE(LEN(identifier_display_name) - LEN(TRIM(identifier_display_name))) || COALESCE(transl.transl_BE_fr, TRIM(attr_map.identifier_display_name)) AS identifier_display_name_BE_fr
, SPACE(LEN(identifier_display_name) - LEN(TRIM(identifier_display_name))) || COALESCE(transl.transl_BG   , TRIM(attr_map.identifier_display_name)) AS identifier_display_name_BG   
, SPACE(LEN(identifier_display_name) - LEN(TRIM(identifier_display_name))) || COALESCE(transl.transl_CH   , TRIM(attr_map.identifier_display_name)) AS identifier_display_name_CH   
, SPACE(LEN(identifier_display_name) - LEN(TRIM(identifier_display_name))) || COALESCE(transl.transl_CS   , TRIM(attr_map.identifier_display_name)) AS identifier_display_name_CS   
, SPACE(LEN(identifier_display_name) - LEN(TRIM(identifier_display_name))) || COALESCE(transl.transl_CY   , TRIM(attr_map.identifier_display_name)) AS identifier_display_name_CY   
, SPACE(LEN(identifier_display_name) - LEN(TRIM(identifier_display_name))) || COALESCE(transl.transl_CZ   , TRIM(attr_map.identifier_display_name)) AS identifier_display_name_CZ   
, SPACE(LEN(identifier_display_name) - LEN(TRIM(identifier_display_name))) || COALESCE(transl.transl_DK   , TRIM(attr_map.identifier_display_name)) AS identifier_display_name_DK   
, SPACE(LEN(identifier_display_name) - LEN(TRIM(identifier_display_name))) || COALESCE(transl.transl_EE   , TRIM(attr_map.identifier_display_name)) AS identifier_display_name_EE   
, SPACE(LEN(identifier_display_name) - LEN(TRIM(identifier_display_name))) || COALESCE(transl.transl_ES   , TRIM(attr_map.identifier_display_name)) AS identifier_display_name_ES   
, SPACE(LEN(identifier_display_name) - LEN(TRIM(identifier_display_name))) || COALESCE(transl.transl_FI   , TRIM(attr_map.identifier_display_name)) AS identifier_display_name_FI   
, SPACE(LEN(identifier_display_name) - LEN(TRIM(identifier_display_name))) || COALESCE(transl.transl_FR   , TRIM(attr_map.identifier_display_name)) AS identifier_display_name_FR   
, SPACE(LEN(identifier_display_name) - LEN(TRIM(identifier_display_name))) || COALESCE(transl.transl_GB   , TRIM(attr_map.identifier_display_name)) AS identifier_display_name_GB   
, SPACE(LEN(identifier_display_name) - LEN(TRIM(identifier_display_name))) || COALESCE(transl.transl_GR   , TRIM(attr_map.identifier_display_name)) AS identifier_display_name_GR   
, SPACE(LEN(identifier_display_name) - LEN(TRIM(identifier_display_name))) || COALESCE(transl.transl_HR   , TRIM(attr_map.identifier_display_name)) AS identifier_display_name_HR   
, SPACE(LEN(identifier_display_name) - LEN(TRIM(identifier_display_name))) || COALESCE(transl.transl_HU   , TRIM(attr_map.identifier_display_name)) AS identifier_display_name_HU   
, SPACE(LEN(identifier_display_name) - LEN(TRIM(identifier_display_name))) || COALESCE(transl.transl_IE   , TRIM(attr_map.identifier_display_name)) AS identifier_display_name_IE   
, SPACE(LEN(identifier_display_name) - LEN(TRIM(identifier_display_name))) || COALESCE(transl.transl_IT   , TRIM(attr_map.identifier_display_name)) AS identifier_display_name_IT   
, SPACE(LEN(identifier_display_name) - LEN(TRIM(identifier_display_name))) || COALESCE(transl.transl_LT   , TRIM(attr_map.identifier_display_name)) AS identifier_display_name_LT   
, SPACE(LEN(identifier_display_name) - LEN(TRIM(identifier_display_name))) || COALESCE(transl.transl_LV   , TRIM(attr_map.identifier_display_name)) AS identifier_display_name_LV   
, SPACE(LEN(identifier_display_name) - LEN(TRIM(identifier_display_name))) || COALESCE(transl.transl_MT   , TRIM(attr_map.identifier_display_name)) AS identifier_display_name_MT   
, SPACE(LEN(identifier_display_name) - LEN(TRIM(identifier_display_name))) || COALESCE(transl.transl_NI   , TRIM(attr_map.identifier_display_name)) AS identifier_display_name_NI   
, SPACE(LEN(identifier_display_name) - LEN(TRIM(identifier_display_name))) || COALESCE(transl.transl_NL   , TRIM(attr_map.identifier_display_name)) AS identifier_display_name_NL   
, SPACE(LEN(identifier_display_name) - LEN(TRIM(identifier_display_name))) || COALESCE(transl.transl_PL   , TRIM(attr_map.identifier_display_name)) AS identifier_display_name_PL   
, SPACE(LEN(identifier_display_name) - LEN(TRIM(identifier_display_name))) || COALESCE(transl.transl_PT   , TRIM(attr_map.identifier_display_name)) AS identifier_display_name_PT   
, SPACE(LEN(identifier_display_name) - LEN(TRIM(identifier_display_name))) || COALESCE(transl.transl_RO   , TRIM(attr_map.identifier_display_name)) AS identifier_display_name_RO   
, SPACE(LEN(identifier_display_name) - LEN(TRIM(identifier_display_name))) || COALESCE(transl.transl_RS   , TRIM(attr_map.identifier_display_name)) AS identifier_display_name_RS   
, SPACE(LEN(identifier_display_name) - LEN(TRIM(identifier_display_name))) || COALESCE(transl.transl_SE   , TRIM(attr_map.identifier_display_name)) AS identifier_display_name_SE   
, SPACE(LEN(identifier_display_name) - LEN(TRIM(identifier_display_name))) || COALESCE(transl.transl_SI   , TRIM(attr_map.identifier_display_name)) AS identifier_display_name_SI   
, SPACE(LEN(identifier_display_name) - LEN(TRIM(identifier_display_name))) || COALESCE(transl.transl_SK   , TRIM(attr_map.identifier_display_name)) AS identifier_display_name_SK   
, SPACE(LEN(identifier_display_name) - LEN(TRIM(identifier_display_name))) || COALESCE(transl.transl_US   , TRIM(attr_map.identifier_display_name)) AS identifier_display_name_US   
FROM P_LEW_MART_LEAD.t_cockpit_attr_id_map_2 attr_map
LEFT OUTER JOIN P_LEW_MART_LEAD.t_ref_transl_cockpit_2_0_2 transl
ON transl.transl = TRIM(attr_map.identifier_display_name)
;

