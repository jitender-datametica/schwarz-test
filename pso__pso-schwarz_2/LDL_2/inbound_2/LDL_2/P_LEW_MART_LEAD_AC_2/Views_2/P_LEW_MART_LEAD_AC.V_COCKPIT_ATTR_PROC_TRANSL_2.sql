/*
#----------------------------------------------------------------------------
# © LIDL Stiftung & Co. KG - DWH / MIS LEAD
#----------------------------------------------------------------------------
# Interface : DDL for view P_LEW_MART_LEAD_AC.v_cockpit_attr_proc_transl_2
#----------------------------------------------------------------------------
# History:
#  1.0    2024-01-15         Marcin Malec              Initial version.
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW P_LEW_MART_LEAD_AC.v_cockpit_attr_proc_transl_2
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
FROM P_LEW_MART_LEAD.v_cockpit_attr_proc_transl_2
;
