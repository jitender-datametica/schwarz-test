/*
#----------------------------------------------------------------------------
# © LIDL Stiftung & Co. KG - DWH / MIS LEAD
#----------------------------------------------------------------------------
# Interface : DDL for view P_LEW_MART_LEAD.v_cockpit_attr_unit_transl
#----------------------------------------------------------------------------
# History:
#  1.0    2024-01-15         Marcin Malec              Initial version.
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW P_LEW_MART_LEAD.v_cockpit_attr_unit_transl
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
  attr_map.identifier_id
, attr_map.identifier_flag
, attr_map.identifier_unit
, COALESCE(transl.transl_AT   , attr_map.identifier_unit) AS identifier_unit_AT   
, COALESCE(transl.transl_BE   , attr_map.identifier_unit) AS identifier_unit_BE   
, COALESCE(transl.transl_BE_fr, attr_map.identifier_unit) AS identifier_unit_BE_fr
, COALESCE(transl.transl_BG   , attr_map.identifier_unit) AS identifier_unit_BG   
, COALESCE(transl.transl_CH   , attr_map.identifier_unit) AS identifier_unit_CH   
, COALESCE(transl.transl_CS   , attr_map.identifier_unit) AS identifier_unit_CS   
, COALESCE(transl.transl_CY   , attr_map.identifier_unit) AS identifier_unit_CY   
, COALESCE(transl.transl_CZ   , attr_map.identifier_unit) AS identifier_unit_CZ   
, COALESCE(transl.transl_DK   , attr_map.identifier_unit) AS identifier_unit_DK   
, COALESCE(transl.transl_EE   , attr_map.identifier_unit) AS identifier_unit_EE   
, COALESCE(transl.transl_ES   , attr_map.identifier_unit) AS identifier_unit_ES   
, COALESCE(transl.transl_FI   , attr_map.identifier_unit) AS identifier_unit_FI   
, COALESCE(transl.transl_FR   , attr_map.identifier_unit) AS identifier_unit_FR   
, COALESCE(transl.transl_GB   , attr_map.identifier_unit) AS identifier_unit_GB   
, COALESCE(transl.transl_GR   , attr_map.identifier_unit) AS identifier_unit_GR   
, COALESCE(transl.transl_HR   , attr_map.identifier_unit) AS identifier_unit_HR   
, COALESCE(transl.transl_HU   , attr_map.identifier_unit) AS identifier_unit_HU   
, COALESCE(transl.transl_IE   , attr_map.identifier_unit) AS identifier_unit_IE   
, COALESCE(transl.transl_IT   , attr_map.identifier_unit) AS identifier_unit_IT   
, COALESCE(transl.transl_LT   , attr_map.identifier_unit) AS identifier_unit_LT   
, COALESCE(transl.transl_LV   , attr_map.identifier_unit) AS identifier_unit_LV   
, COALESCE(transl.transl_MT   , attr_map.identifier_unit) AS identifier_unit_MT   
, COALESCE(transl.transl_NI   , attr_map.identifier_unit) AS identifier_unit_NI   
, COALESCE(transl.transl_NL   , attr_map.identifier_unit) AS identifier_unit_NL   
, COALESCE(transl.transl_PL   , attr_map.identifier_unit) AS identifier_unit_PL   
, COALESCE(transl.transl_PT   , attr_map.identifier_unit) AS identifier_unit_PT   
, COALESCE(transl.transl_RO   , attr_map.identifier_unit) AS identifier_unit_RO   
, COALESCE(transl.transl_RS   , attr_map.identifier_unit) AS identifier_unit_RS   
, COALESCE(transl.transl_SE   , attr_map.identifier_unit) AS identifier_unit_SE   
, COALESCE(transl.transl_SI   , attr_map.identifier_unit) AS identifier_unit_SI   
, COALESCE(transl.transl_SK   , attr_map.identifier_unit) AS identifier_unit_SK   
, COALESCE(transl.transl_US   , attr_map.identifier_unit) AS identifier_unit_US   
FROM P_LEW_MART_LEAD.t_cockpit_attr_id_map attr_map
LEFT OUTER JOIN P_LEW_MART_LEAD.t_ref_transl_cockpit_2_0 transl
ON transl.transl = TRIM(attr_map.identifier_unit)
;
