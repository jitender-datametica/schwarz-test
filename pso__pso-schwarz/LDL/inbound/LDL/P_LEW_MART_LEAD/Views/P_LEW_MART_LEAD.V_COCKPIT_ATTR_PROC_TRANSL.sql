/*
#----------------------------------------------------------------------------
# © LIDL Stiftung & Co. KG - DWH / MIS LEAD
#----------------------------------------------------------------------------
# Interface : DDL for view P_LEW_MART_LEAD.v_cockpit_attr_proc_transl
#----------------------------------------------------------------------------
# History:
#  1.0    2024-01-15         Marcin Malec              Initial version.
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW P_LEW_MART_LEAD.v_cockpit_attr_proc_transl
(
  identifier_id
, identifier_flag
, process_sorting
, process_name
, process_name_AT   
, process_name_BE   
, process_name_BE_fr
, process_name_BG   
, process_name_CH   
, process_name_CS   
, process_name_CY   
, process_name_CZ   
, process_name_DK   
, process_name_EE   
, process_name_ES   
, process_name_FI   
, process_name_FR   
, process_name_GB   
, process_name_GR   
, process_name_HR   
, process_name_HU   
, process_name_IE   
, process_name_IT   
, process_name_LT   
, process_name_LV   
, process_name_MT   
, process_name_NI   
, process_name_NL   
, process_name_PL   
, process_name_PT   
, process_name_RO   
, process_name_RS   
, process_name_SE   
, process_name_SI   
, process_name_SK   
, process_name_US   
)
AS
SELECT
  attr_map.identifier_id
, attr_map.identifier_flag
, attr_map.process_sorting
, attr_map.process_name
, COALESCE(transl.transl_AT   , attr_map.process_name) AS process_name_AT   
, COALESCE(transl.transl_BE   , attr_map.process_name) AS process_name_BE   
, COALESCE(transl.transl_BE_fr, attr_map.process_name) AS process_name_BE_fr
, COALESCE(transl.transl_BG   , attr_map.process_name) AS process_name_BG   
, COALESCE(transl.transl_CH   , attr_map.process_name) AS process_name_CH   
, COALESCE(transl.transl_CS   , attr_map.process_name) AS process_name_CS   
, COALESCE(transl.transl_CY   , attr_map.process_name) AS process_name_CY   
, COALESCE(transl.transl_CZ   , attr_map.process_name) AS process_name_CZ   
, COALESCE(transl.transl_DK   , attr_map.process_name) AS process_name_DK   
, COALESCE(transl.transl_EE   , attr_map.process_name) AS process_name_EE   
, COALESCE(transl.transl_ES   , attr_map.process_name) AS process_name_ES   
, COALESCE(transl.transl_FI   , attr_map.process_name) AS process_name_FI   
, COALESCE(transl.transl_FR   , attr_map.process_name) AS process_name_FR   
, COALESCE(transl.transl_GB   , attr_map.process_name) AS process_name_GB   
, COALESCE(transl.transl_GR   , attr_map.process_name) AS process_name_GR   
, COALESCE(transl.transl_HR   , attr_map.process_name) AS process_name_HR   
, COALESCE(transl.transl_HU   , attr_map.process_name) AS process_name_HU   
, COALESCE(transl.transl_IE   , attr_map.process_name) AS process_name_IE   
, COALESCE(transl.transl_IT   , attr_map.process_name) AS process_name_IT   
, COALESCE(transl.transl_LT   , attr_map.process_name) AS process_name_LT   
, COALESCE(transl.transl_LV   , attr_map.process_name) AS process_name_LV   
, COALESCE(transl.transl_MT   , attr_map.process_name) AS process_name_MT   
, COALESCE(transl.transl_NI   , attr_map.process_name) AS process_name_NI   
, COALESCE(transl.transl_NL   , attr_map.process_name) AS process_name_NL   
, COALESCE(transl.transl_PL   , attr_map.process_name) AS process_name_PL   
, COALESCE(transl.transl_PT   , attr_map.process_name) AS process_name_PT   
, COALESCE(transl.transl_RO   , attr_map.process_name) AS process_name_RO   
, COALESCE(transl.transl_RS   , attr_map.process_name) AS process_name_RS   
, COALESCE(transl.transl_SE   , attr_map.process_name) AS process_name_SE   
, COALESCE(transl.transl_SI   , attr_map.process_name) AS process_name_SI   
, COALESCE(transl.transl_SK   , attr_map.process_name) AS process_name_SK   
, COALESCE(transl.transl_US   , attr_map.process_name) AS process_name_US   
FROM P_LEW_MART_LEAD.t_cockpit_attr_id_map attr_map
LEFT OUTER JOIN P_LEW_MART_LEAD.t_ref_transl_cockpit_2_0 transl
ON transl.transl = TRIM(attr_map.process_name)
;
