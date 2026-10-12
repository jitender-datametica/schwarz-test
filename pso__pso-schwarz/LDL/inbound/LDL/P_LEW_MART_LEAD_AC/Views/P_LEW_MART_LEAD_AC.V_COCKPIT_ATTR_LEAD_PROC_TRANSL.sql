/*
#----------------------------------------------------------------------------
# © LIDL Stiftung & Co. KG - DWH / MIS LEAD
#----------------------------------------------------------------------------
# Interface : DDL for view P_LEW_MART_LEAD_AC.v_cockpit_attr_lead_proc_transl
#----------------------------------------------------------------------------
# History:
#  1.0    2024-01-15         Marcin Malec              Initial version.
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW P_LEW_MART_LEAD_AC.v_cockpit_attr_lead_proc_transl
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
FROM P_LEW_MART_LEAD.v_cockpit_attr_lead_proc_transl
;
