/*
#----------------------------------------------------------------------------
# © LIDL Stiftung & Co. KG - DWH / MIS LEAD
#----------------------------------------------------------------------------
# Interface : DDL for view P_LEW_MART_LEAD_AC.v_cockpit_attr_name_det_rep_transl_1
#----------------------------------------------------------------------------
# History:
#  1.0    2024-01-15         Marcin Malec              Initial version.
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW P_LEW_MART_LEAD_AC.v_cockpit_attr_name_det_rep_transl_1
(
  id 
, NAME
, name_AT   
, name_BE   
, name_BE_fr
, name_BG   
, name_CH   
, name_CS   
, name_CY   
, name_CZ   
, name_DK   
, name_EE   
, name_ES   
, name_FI   
, name_FR   
, name_GB   
, name_GR   
, name_HR   
, name_HU   
, name_IE   
, name_IT   
, name_LT   
, name_LV   
, name_MT   
, name_NI   
, name_NL   
, name_PL   
, name_PT   
, name_RO   
, name_RS   
, name_SE   
, name_SI   
, name_SK   
, name_US   
)
AS
SELECT
  id 
, NAME
, name_AT   
, name_BE   
, name_BE_fr
, name_BG   
, name_CH   
, name_CS   
, name_CY   
, name_CZ   
, name_DK   
, name_EE   
, name_ES   
, name_FI   
, name_FR   
, name_GB   
, name_GR   
, name_HR   
, name_HU   
, name_IE   
, name_IT   
, name_LT   
, name_LV   
, name_MT   
, name_NI   
, name_NL   
, name_PL   
, name_PT   
, name_RO   
, name_RS   
, name_SE   
, name_SI   
, name_SK   
, name_US   
FROM P_LEW_MART_LEAD.v_cockpit_attr_name_det_rep_transl_1
;
