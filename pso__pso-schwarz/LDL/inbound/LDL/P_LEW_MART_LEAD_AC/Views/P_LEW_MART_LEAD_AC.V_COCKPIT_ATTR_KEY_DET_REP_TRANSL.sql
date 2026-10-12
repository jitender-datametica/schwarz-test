/*
#----------------------------------------------------------------------------
# © LIDL Stiftung & Co. KG - DWH / MIS LEAD
#----------------------------------------------------------------------------
# Interface : DDL for view P_LEW_MART_LEAD_AC.v_cockpit_attr_key_det_rep_transl
#----------------------------------------------------------------------------
# History:
#  1.0    2024-01-15         Marcin Malec              Initial version.
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW P_LEW_MART_LEAD_AC.v_cockpit_attr_key_det_rep_transl
(
  id 
, key_id
, key_desc
, key_desc_AT   
, key_desc_BE   
, key_desc_BE_fr
, key_desc_BG   
, key_desc_CH   
, key_desc_CS   
, key_desc_CY   
, key_desc_CZ   
, key_desc_DK   
, key_desc_EE   
, key_desc_ES   
, key_desc_FI   
, key_desc_FR   
, key_desc_GB   
, key_desc_GR   
, key_desc_HR   
, key_desc_HU   
, key_desc_IE   
, key_desc_IT   
, key_desc_LT   
, key_desc_LV   
, key_desc_MT   
, key_desc_NI   
, key_desc_NL   
, key_desc_PL   
, key_desc_PT   
, key_desc_RO   
, key_desc_RS   
, key_desc_SE   
, key_desc_SI   
, key_desc_SK   
, key_desc_US   
)
AS
SELECT
  id 
, key_id
, key_desc
, key_desc_AT   
, key_desc_BE   
, key_desc_BE_fr
, key_desc_BG   
, key_desc_CH   
, key_desc_CS   
, key_desc_CY   
, key_desc_CZ   
, key_desc_DK   
, key_desc_EE   
, key_desc_ES   
, key_desc_FI   
, key_desc_FR   
, key_desc_GB   
, key_desc_GR   
, key_desc_HR   
, key_desc_HU   
, key_desc_IE   
, key_desc_IT   
, key_desc_LT   
, key_desc_LV   
, key_desc_MT   
, key_desc_NI   
, key_desc_NL   
, key_desc_PL   
, key_desc_PT   
, key_desc_RO   
, key_desc_RS   
, key_desc_SE   
, key_desc_SI   
, key_desc_SK   
, key_desc_US   
FROM P_LEW_MART_LEAD.v_cockpit_attr_key_det_rep_transl
;
