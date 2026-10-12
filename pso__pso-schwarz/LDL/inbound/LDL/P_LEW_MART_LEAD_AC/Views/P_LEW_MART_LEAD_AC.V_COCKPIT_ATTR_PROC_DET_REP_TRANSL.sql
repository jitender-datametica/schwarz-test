/*
#----------------------------------------------------------------------------
# © LIDL Stiftung & Co. KG - DWH / MIS LEAD
#----------------------------------------------------------------------------
# Interface : DDL for view P_LEW_MART_LEAD_AC.v_cockpit_attr_proc_det_rep_transl
#----------------------------------------------------------------------------
# History:
#  1.0    2024-01-15         Marcin Malec              Initial version.
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW P_LEW_MART_LEAD_AC.v_cockpit_attr_proc_det_rep_transl
(
  id 
, process_id
, process_desc
, process_desc_AT   
, process_desc_BE   
, process_desc_BE_fr
, process_desc_BG   
, process_desc_CH   
, process_desc_CS   
, process_desc_CY   
, process_desc_CZ   
, process_desc_DK   
, process_desc_EE   
, process_desc_ES   
, process_desc_FI   
, process_desc_FR   
, process_desc_GB   
, process_desc_GR   
, process_desc_HR   
, process_desc_HU   
, process_desc_IE   
, process_desc_IT   
, process_desc_LT   
, process_desc_LV   
, process_desc_MT   
, process_desc_NI   
, process_desc_NL   
, process_desc_PL   
, process_desc_PT   
, process_desc_RO   
, process_desc_RS   
, process_desc_SE   
, process_desc_SI   
, process_desc_SK   
, process_desc_US   
)
AS
SELECT
  id 
, process_id
, process_desc
, process_desc_AT   
, process_desc_BE   
, process_desc_BE_fr
, process_desc_BG   
, process_desc_CH   
, process_desc_CS   
, process_desc_CY   
, process_desc_CZ   
, process_desc_DK   
, process_desc_EE   
, process_desc_ES   
, process_desc_FI   
, process_desc_FR   
, process_desc_GB   
, process_desc_GR   
, process_desc_HR   
, process_desc_HU   
, process_desc_IE   
, process_desc_IT   
, process_desc_LT   
, process_desc_LV   
, process_desc_MT   
, process_desc_NI   
, process_desc_NL   
, process_desc_PL   
, process_desc_PT   
, process_desc_RO   
, process_desc_RS   
, process_desc_SE   
, process_desc_SI   
, process_desc_SK   
, process_desc_US   
FROM P_LEW_MART_LEAD.v_cockpit_attr_proc_det_rep_transl
;
