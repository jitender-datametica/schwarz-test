/*
#----------------------------------------------------------------------------
# © LIDL Stiftung & Co. KG - DWH / MIS LEAD
#----------------------------------------------------------------------------
# Interface : DDL for view P_LEW_MART_LEAD.v_cockpit_attr_lead_proc_transl_2
#----------------------------------------------------------------------------
# History:
#  1.0    2024-01-15         Marcin Malec              Initial version.
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW P_LEW_MART_LEAD.v_cockpit_attr_lead_proc_transl_2
(
  identifier_id
, identifier_flag
, leading_process_id
, leading_process_name
, leading_process_name_AT   
, leading_process_name_BE   
, leading_process_name_BE_fr
, leading_process_name_BG   
, leading_process_name_CH   
, leading_process_name_CS   
, leading_process_name_CY   
, leading_process_name_CZ   
, leading_process_name_DK   
, leading_process_name_EE   
, leading_process_name_ES   
, leading_process_name_FI   
, leading_process_name_FR   
, leading_process_name_GB   
, leading_process_name_GR   
, leading_process_name_HR   
, leading_process_name_HU   
, leading_process_name_IE   
, leading_process_name_IT   
, leading_process_name_LT   
, leading_process_name_LV   
, leading_process_name_MT   
, leading_process_name_NI   
, leading_process_name_NL   
, leading_process_name_PL   
, leading_process_name_PT   
, leading_process_name_RO   
, leading_process_name_RS   
, leading_process_name_SE   
, leading_process_name_SI   
, leading_process_name_SK   
, leading_process_name_US   
)
AS
SELECT
  attr_map.identifier_id
, attr_map.identifier_flag
, attr_map.leading_process_id
, attr_map.leading_process_name
, COALESCE(transl.transl_AT   , attr_map.leading_process_name) AS leading_process_name_AT   
, COALESCE(transl.transl_BE   , attr_map.leading_process_name) AS leading_process_name_BE   
, COALESCE(transl.transl_BE_fr, attr_map.leading_process_name) AS leading_process_name_BE_fr
, COALESCE(transl.transl_BG   , attr_map.leading_process_name) AS leading_process_name_BG   
, COALESCE(transl.transl_CH   , attr_map.leading_process_name) AS leading_process_name_CH   
, COALESCE(transl.transl_CS   , attr_map.leading_process_name) AS leading_process_name_CS   
, COALESCE(transl.transl_CY   , attr_map.leading_process_name) AS leading_process_name_CY   
, COALESCE(transl.transl_CZ   , attr_map.leading_process_name) AS leading_process_name_CZ   
, COALESCE(transl.transl_DK   , attr_map.leading_process_name) AS leading_process_name_DK   
, COALESCE(transl.transl_EE   , attr_map.leading_process_name) AS leading_process_name_EE   
, COALESCE(transl.transl_ES   , attr_map.leading_process_name) AS leading_process_name_ES   
, COALESCE(transl.transl_FI   , attr_map.leading_process_name) AS leading_process_name_FI   
, COALESCE(transl.transl_FR   , attr_map.leading_process_name) AS leading_process_name_FR   
, COALESCE(transl.transl_GB   , attr_map.leading_process_name) AS leading_process_name_GB   
, COALESCE(transl.transl_GR   , attr_map.leading_process_name) AS leading_process_name_GR   
, COALESCE(transl.transl_HR   , attr_map.leading_process_name) AS leading_process_name_HR   
, COALESCE(transl.transl_HU   , attr_map.leading_process_name) AS leading_process_name_HU   
, COALESCE(transl.transl_IE   , attr_map.leading_process_name) AS leading_process_name_IE   
, COALESCE(transl.transl_IT   , attr_map.leading_process_name) AS leading_process_name_IT   
, COALESCE(transl.transl_LT   , attr_map.leading_process_name) AS leading_process_name_LT   
, COALESCE(transl.transl_LV   , attr_map.leading_process_name) AS leading_process_name_LV   
, COALESCE(transl.transl_MT   , attr_map.leading_process_name) AS leading_process_name_MT   
, COALESCE(transl.transl_NI   , attr_map.leading_process_name) AS leading_process_name_NI   
, COALESCE(transl.transl_NL   , attr_map.leading_process_name) AS leading_process_name_NL   
, COALESCE(transl.transl_PL   , attr_map.leading_process_name) AS leading_process_name_PL   
, COALESCE(transl.transl_PT   , attr_map.leading_process_name) AS leading_process_name_PT   
, COALESCE(transl.transl_RO   , attr_map.leading_process_name) AS leading_process_name_RO   
, COALESCE(transl.transl_RS   , attr_map.leading_process_name) AS leading_process_name_RS   
, COALESCE(transl.transl_SE   , attr_map.leading_process_name) AS leading_process_name_SE   
, COALESCE(transl.transl_SI   , attr_map.leading_process_name) AS leading_process_name_SI   
, COALESCE(transl.transl_SK   , attr_map.leading_process_name) AS leading_process_name_SK   
, COALESCE(transl.transl_US   , attr_map.leading_process_name) AS leading_process_name_US   
FROM P_LEW_MART_LEAD.t_cockpit_attr_id_map_2 attr_map
LEFT OUTER JOIN P_LEW_MART_LEAD.t_ref_transl_cockpit_2_0_2 transl
ON transl.transl = TRIM(attr_map.leading_process_name)
;
