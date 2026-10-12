/*
#----------------------------------------------------------------------------
# © LIDL Stiftung & Co. KG - DWH / MIS LEAD
#----------------------------------------------------------------------------
# Interface : DDL for view P_LEW_MART_LEAD.v_cockpit_attr_proc_abbrev_transl_1
#----------------------------------------------------------------------------
# History:
#  1.0    2024-01-15         Marcin Malec              Initial version.
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW P_LEW_MART_LEAD.v_cockpit_attr_proc_abbrev_transl_1
(
  identifier_id
, identifier_flag
, process_sorting
, process_abbreviation
, process_abbreviation_AT   
, process_abbreviation_BE   
, process_abbreviation_BE_fr
, process_abbreviation_BG   
, process_abbreviation_CH   
, process_abbreviation_CS   
, process_abbreviation_CY   
, process_abbreviation_CZ   
, process_abbreviation_DK   
, process_abbreviation_EE   
, process_abbreviation_ES   
, process_abbreviation_FI   
, process_abbreviation_FR   
, process_abbreviation_GB   
, process_abbreviation_GR   
, process_abbreviation_HR   
, process_abbreviation_HU   
, process_abbreviation_IE   
, process_abbreviation_IT   
, process_abbreviation_LT   
, process_abbreviation_LV   
, process_abbreviation_MT   
, process_abbreviation_NI   
, process_abbreviation_NL   
, process_abbreviation_PL   
, process_abbreviation_PT   
, process_abbreviation_RO   
, process_abbreviation_RS   
, process_abbreviation_SE   
, process_abbreviation_SI   
, process_abbreviation_SK   
, process_abbreviation_US   
)
AS
SELECT
  attr_map.identifier_id
, attr_map.identifier_flag
, attr_map.process_sorting
, attr_map.process_abbreviation
, COALESCE(transl.transl_AT   , attr_map.process_abbreviation) AS process_abbreviation_AT   
, COALESCE(transl.transl_BE   , attr_map.process_abbreviation) AS process_abbreviation_BE   
, COALESCE(transl.transl_BE_fr, attr_map.process_abbreviation) AS process_abbreviation_BE_fr
, COALESCE(transl.transl_BG   , attr_map.process_abbreviation) AS process_abbreviation_BG   
, COALESCE(transl.transl_CH   , attr_map.process_abbreviation) AS process_abbreviation_CH   
, COALESCE(transl.transl_CS   , attr_map.process_abbreviation) AS process_abbreviation_CS   
, COALESCE(transl.transl_CY   , attr_map.process_abbreviation) AS process_abbreviation_CY   
, COALESCE(transl.transl_CZ   , attr_map.process_abbreviation) AS process_abbreviation_CZ   
, COALESCE(transl.transl_DK   , attr_map.process_abbreviation) AS process_abbreviation_DK   
, COALESCE(transl.transl_EE   , attr_map.process_abbreviation) AS process_abbreviation_EE   
, COALESCE(transl.transl_ES   , attr_map.process_abbreviation) AS process_abbreviation_ES   
, COALESCE(transl.transl_FI   , attr_map.process_abbreviation) AS process_abbreviation_FI   
, COALESCE(transl.transl_FR   , attr_map.process_abbreviation) AS process_abbreviation_FR   
, COALESCE(transl.transl_GB   , attr_map.process_abbreviation) AS process_abbreviation_GB   
, COALESCE(transl.transl_GR   , attr_map.process_abbreviation) AS process_abbreviation_GR   
, COALESCE(transl.transl_HR   , attr_map.process_abbreviation) AS process_abbreviation_HR   
, COALESCE(transl.transl_HU   , attr_map.process_abbreviation) AS process_abbreviation_HU   
, COALESCE(transl.transl_IE   , attr_map.process_abbreviation) AS process_abbreviation_IE   
, COALESCE(transl.transl_IT   , attr_map.process_abbreviation) AS process_abbreviation_IT   
, COALESCE(transl.transl_LT   , attr_map.process_abbreviation) AS process_abbreviation_LT   
, COALESCE(transl.transl_LV   , attr_map.process_abbreviation) AS process_abbreviation_LV   
, COALESCE(transl.transl_MT   , attr_map.process_abbreviation) AS process_abbreviation_MT   
, COALESCE(transl.transl_NI   , attr_map.process_abbreviation) AS process_abbreviation_NI   
, COALESCE(transl.transl_NL   , attr_map.process_abbreviation) AS process_abbreviation_NL   
, COALESCE(transl.transl_PL   , attr_map.process_abbreviation) AS process_abbreviation_PL   
, COALESCE(transl.transl_PT   , attr_map.process_abbreviation) AS process_abbreviation_PT   
, COALESCE(transl.transl_RO   , attr_map.process_abbreviation) AS process_abbreviation_RO   
, COALESCE(transl.transl_RS   , attr_map.process_abbreviation) AS process_abbreviation_RS   
, COALESCE(transl.transl_SE   , attr_map.process_abbreviation) AS process_abbreviation_SE   
, COALESCE(transl.transl_SI   , attr_map.process_abbreviation) AS process_abbreviation_SI   
, COALESCE(transl.transl_SK   , attr_map.process_abbreviation) AS process_abbreviation_SK   
, COALESCE(transl.transl_US   , attr_map.process_abbreviation) AS process_abbreviation_US   
FROM P_LEW_MART_LEAD.t_cockpit_attr_id_map_1 attr_map
LEFT OUTER JOIN P_LEW_MART_LEAD.t_ref_transl_cockpit_2_0_1 transl
ON transl.transl = TRIM(attr_map.process_abbreviation)
;
